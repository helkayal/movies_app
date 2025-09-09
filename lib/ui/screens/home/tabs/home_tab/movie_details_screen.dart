import 'package:movies_app/core/utils/constants/imports.dart';
import 'package:movies_app/data/model/movie_details_model.dart';
import 'package:movies_app/ui/screens/home/tabs/home_tab/widgets/cast_section.dart';
import 'package:movies_app/ui/screens/home/tabs/home_tab/widgets/movie_details_image_section.dart';
import 'package:movies_app/ui/screens/home/tabs/home_tab/widgets/movie_details_numbers.dart';
import 'package:movies_app/ui/screens/home/tabs/home_tab/widgets/movie_genres_section.dart';
import 'package:movies_app/ui/screens/home/tabs/home_tab/widgets/screen_shot_container.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void initState() {
    context.read<MovieBloc>().add(GetMovieDetails(movieId: widget.movieId));

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieError) {
          return Center(
            child: Text(state.message, style: AppTextStyles.whiteBold20),
          );
        } else if (state is MovieDetailsSuccess) {
          return _buildMovieDetails(
            context,
            movie: state.movie,
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
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar:
            true, // 🔥 دي اللي هتخلي الكونتينر يبدا من ورا الاب بار
        appBar: AppBar(
          backgroundColor: Colors.transparent, // شفاف عشان يبان وراه
          elevation: 0, // يشيل الظل
          leading: IconButton(
            onPressed: () {
              // context.read<MovieBloc>().add(FetchMoviesEvent());
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.bookmark, color: Colors.white, size: 30),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MovieDetailsImageSection(movie: movie),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomButton(
                      text: 'watch',
                      onClick: () {},
                      backgroundColor: AppColors.red,
                      borderColor: AppColors.red,
                      textColor: AppColors.white,
                    ),
                    SizedBox(height: context.height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MovieDetailsNumbers(
                          text: movie?.likeCount.toString() ?? '',
                          image: AppAssets.love,
                        ),
                        MovieDetailsNumbers(
                          text: movie?.runtime.toString() ?? '',
                          image: AppAssets.timer,
                        ),
                        MovieDetailsNumbers(
                          text: movie?.rating!.toDouble().toString() ?? '',
                          image: AppAssets.star,
                        ),
                      ],
                    ),
                    SizedBox(height: context.height * 0.03),
                    // ===== Screen Shots =====
                    Text("Screen Shots", style: AppTextStyles.whiteBold24),
                    ScreenShotContainer(
                      image: movie?.largeScreenshotImage1 ?? '',
                    ),
                    ScreenShotContainer(
                      image: movie?.largeScreenshotImage2 ?? '',
                    ),
                    ScreenShotContainer(
                      image: movie?.largeScreenshotImage3 ?? '',
                    ),
                    // ListView.builder(
                    //   itemCount: _screenShots.length,
                    //   itemBuilder: (BuildContext context, int index) {
                    //     return CachedNetworkImage(
                    //       imageUrl: _screenShots[index],
                    //       imageBuilder: (context, imageProvider) =>
                    //           ScreenShotContainer(image: imageProvider),

                    //       placeholder: (context, url) => Center(
                    //         child: Padding(
                    //           padding: const EdgeInsets.all(20),
                    //           child: CircularProgressIndicator(
                    //             color: AppColors.yellow,
                    //           ),
                    //         ),
                    //       ),
                    //       errorWidget: (context, url, error) => ScreenShotContainer(image: AssetImage(AppAssets.defaultScreenShotImage)),
                    //     );
                    //   },
                    // ),
                    // ===== Similar =====
                    Text("Similar", style: AppTextStyles.whiteBold24),
                    CustomGrideView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      movie: suggestedMovies,
                    ),
                    // ===== Summary =====
                    const SizedBox(height: 12),
                    Text("Summary", style: AppTextStyles.whiteBold24),
                    const SizedBox(height: 12),
                    Text(
                      movie!.descriptionFull!.isEmpty
                          ? 'No description available'
                          : movie.descriptionFull!,
                      style: AppTextStyles.whiteRegular16,
                      softWrap: true, // يخلي النص يكسر السطر تلقائي
                    ),
                    const SizedBox(height: 16),
                    CastSection(movie: movie),
                    const SizedBox(height: 16),
                    // ===== Genres =====
                    MovieGenresSection(movie: movie),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
