import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/core/theme/app_text_styles.dart';
import 'package:movies_app/core/utils/constants/app_assets.dart';
import 'package:movies_app/core/utils/context_extension.dart';
import 'package:movies_app/data/model/movie_data_model.dart';
import 'package:movies_app/ui/screens/home/bloc/movie_details_bloc/movie_details_bloc.dart';
import 'package:movies_app/ui/screens/home/bloc/movie_details_bloc/movie_details_state.dart';
import 'package:movies_app/ui/screens/home/tabs/home_tab/widgets/movie_details_image_section.dart';
import 'package:movies_app/ui/screens/home/tabs/home_tab/widgets/movie_details_numbers.dart';
import 'package:movies_app/ui/screens/home/tabs/home_tab/widgets/movie_sections.dart';
import 'package:movies_app/ui/screens/home/tabs/home_tab/widgets/screen_shot_container.dart';
import 'package:movies_app/ui/screens/home/tabs/profile_tab/cubit/favourite_cubit.dart';
import 'package:movies_app/ui/screens/home/tabs/profile_tab/cubit/favourite_states.dart';
import 'package:movies_app/ui/screens/home/tabs/profile_tab/cubit/history_cubit.dart';
import 'package:movies_app/ui/widgets/custom_button.dart';
import 'package:movies_app/ui/widgets/custom_gride_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  bool isFav = false;
  bool _savedToHistory = false;
  bool _isGoogleLoggedIn = false;

  @override
  void initState() {
    super.initState();

    _checkGoogleLogin();

    // check if movie is favourite
    if (!_isGoogleLoggedIn) {
      context
          .read<FavouriteCubit>()
          .isMovieFavourite(movieId: widget.movieId.toString())
          .then((fav) {
            setState(() {
              isFav = fav;
            });
          });
    }
  }

  Future<void> _checkGoogleLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? loggedIn = prefs.getBool('isGoogleLoggedIn');
    if (mounted) {
      setState(() {
        _isGoogleLoggedIn = loggedIn ?? false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieDetailsBloc, MovieDetailsState>(
      listener: (context, state) {
        if (state is MovieDetailsNull) {
          context.showSnackBar("Not Available Now!");
          Future.delayed(Duration(milliseconds: 200), () {
            Navigator.pop(context);
          });
        }
      },
      builder: (context, state) {
        if (state is MovieDetailsError) {
          return Center(
            child: Text(state.message, style: AppTextStyles.whiteBold20),
          );
        } else if (state is MovieDetailsSuccess) {
          final movie = state.movie;
          // Save to history here
          if (!_savedToHistory) {
            _savedToHistory = true;
            context.read<HistoryCubit>().addMovie(
              Movie(
                id: movie.id,
                title: movie.title,
                rating: movie.rating,
                year: movie.year,
                mediumCoverImage: movie.mediumCoverImage,
              ),
            );
          }
          return _buildMovieDetails(
            context,
            movie: movie,
            suggestedMovies: state.suggestedMovies,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(color: AppColors.yellow),
          );
        }
      },
    );
  }

  SafeArea _buildMovieDetails(
    BuildContext context, {
    required Movie? movie,
    required List<Movie> suggestedMovies,
  }) {
    final List<String?> screenShots = [
      movie?.largeScreenshotImage1,
      movie?.largeScreenshotImage2,
      movie?.largeScreenshotImage3,
    ];
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          actions: _isGoogleLoggedIn
              ? [] // hide if Google logged in
              : [
                  BlocConsumer<FavouriteCubit, FavouriteStates>(
                    listener: (context, state) {
                      if (state is FavouriteAdded) {
                        setState(() => isFav = true);
                        context.showSnackBar("Added to favourites");
                      } else if (state is FavouriteRemoved) {
                        setState(() => isFav = false);
                        context.showSnackBar("Removed from favourites");
                      } else if (state is FavouriteError) {
                        context.showSnackBar(state.message, isError: true);
                      }
                    },
                    builder: (context, state) {
                      if (state is FavouriteLoading) {
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(color: Colors.white),
                        );
                      }
                      return IconButton(
                        onPressed: () {
                          if (isFav) {
                            context
                                .read<FavouriteCubit>()
                                .removeMovieFromFavourite(
                                  movieId: movie!.id.toString(),
                                );
                          } else {
                            context.read<FavouriteCubit>().addFavourite(
                              movieId: movie!.id.toString(),
                              name: movie.title ?? '',
                              rating: movie.rating ?? 0.0,
                              imageURL: movie.mediumCoverImage ?? '',
                              year: movie.year?.toString() ?? '',
                            );
                          }
                        },
                        icon: Icon(
                          Icons.bookmark,
                          color: isFav ? Colors.yellow : Colors.white,
                          size: 30,
                        ),
                      );
                    },
                  ),
                ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MovieDetailsImageSection(movie: movie),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomButton(
                      text: 'Watch',
                      onClick: () {
                        if (movie?.url != null) {
                          _launchMovieUrl(movie!.url!);
                        }
                      },
                      backgroundColor: AppColors.red,
                      borderColor: AppColors.red,
                      textColor: AppColors.white,
                    ),
                    SizedBox(height: context.height * 0.03),
                    _buildReactsWidget(movie),
                    SizedBox(height: context.height * 0.01),

                    /// Screen Shots
                    MovieSections(
                      title: 'Screen Shots',
                      widget: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: screenShots.length,
                        itemBuilder: (context, index) {
                          return ScreenShotContainer(image: screenShots[index]);
                        },
                      ),
                    ),

                    /// Similar Movies
                    MovieSections(
                      title: 'Similar',
                      widget: CustomGrideView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        movie: suggestedMovies,
                      ),
                    ),

                    /// Summary
                    MovieSections(
                      title: "Summary",
                      widget: Text(
                        movie?.descriptionFull?.isEmpty ?? true
                            ? 'No description available'
                            : movie!.descriptionFull!,
                        style: AppTextStyles.whiteRegular16,
                        softWrap: true,
                      ),
                    ),

                    /// Cast
                    MovieSections(
                      title: 'Cast',
                      widget: _buildCastSection(movie!),
                    ),

                    /// Genres
                    MovieSections(
                      title: 'Genres',
                      widget: _buildMovieGenresSection(movie),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _buildReactsWidget(Movie? movie) {
    return SizedBox(
      height: context.height * 0.06,
      child: Row(
        spacing: 6,
        children: [
          MovieDetailsNumbers(
            text: movie?.likeCount?.toString() ?? '',
            image: AppAssets.love,
          ),
          MovieDetailsNumbers(
            text: movie?.runtime?.toString() ?? '',
            image: AppAssets.timer,
          ),
          MovieDetailsNumbers(
            text: movie?.rating?.toDouble().toString() ?? '',
            image: AppAssets.negma,
          ),
        ],
      ),
    );
  }

  Future<void> _launchMovieUrl(String url) async {
    if (!mounted) return;
    context.showLoading();
    final Uri uri = Uri.parse(url);
    if (!mounted) return;
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        context.showSnackBar("Could not launch the link", isError: true);
      }
    }
  }

  ListView _buildCastSection(Movie movie) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: movie.cast?.length ?? 0,
      itemBuilder: (context, index) {
        final cast = movie.cast![index];
        return Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.darkGrey,
          ),
          child: Row(
            spacing: 10,
            children: [
              Container(
                width: context.width * 0.15,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.network(
                  cast.urlSmallImage ?? AppAssets.defaultPersonImage,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Text(
                      'Name : ${cast.name}',
                      style: AppTextStyles.whiteRegular16,
                    ),
                    Text(
                      'Character : ${cast.characterName}',
                      style: AppTextStyles.whiteRegular16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMovieGenresSection(Movie movie) {
    return Wrap(
      spacing: 10, // horizontal spacing between items
      runSpacing: 16, // vertical spacing between rows
      children:
          movie.genres?.map((genre) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.darkGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                genre,
                style: AppTextStyles.whiteRegular16,
                overflow: TextOverflow
                    .ellipsis, // just in case text is still too long
              ),
            );
          }).toList() ??
          [],
    );
  }
}
