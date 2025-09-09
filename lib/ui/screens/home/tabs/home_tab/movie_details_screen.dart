// import 'package:movies_app/core/utils/constants/imports.dart';
// import 'package:url_launcher/url_launcher.dart';

// class MovieDetailsScreen extends StatefulWidget {
//   final int movieId;
//   const MovieDetailsScreen({super.key, required this.movieId});

//   @override
//   State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
// }

// class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
//   @override
//   void initState() {
//     context.read<MovieBloc>().add(GetMovieDetails(movieId: widget.movieId));

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<MovieBloc, MovieState>(
//       builder: (context, state) {
//         if (state is MovieError) {
//           return Center(
//             child: Text(state.message, style: AppTextStyles.whiteBold20),
//           );
//         } else if (state is MovieDetailsSuccess) {
//           return _buildMovieDetails(
//             context,
//             movie: state.movie,
//             suggestedMovies: state.suggestedMovies,
//           );
//         } else {
//           return Center(
//             child: CircularProgressIndicator(color: AppColors.yellow),
//           );
//         }
//       },
//     );
//   }

//   SafeArea _buildMovieDetails(
//     BuildContext context, {
//     required Movie? movie,
//     required List<Movie> suggestedMovies,
//   }) {
//     final List<String?> screenShots = [
//       movie?.largeScreenshotImage1,
//       movie?.largeScreenshotImage2,
//       movie?.largeScreenshotImage3,
//     ];
//     return SafeArea(
//       child: Scaffold(
//         extendBodyBehindAppBar:
//             true, // 🔥 دي اللي هتخلي الكونتينر يبدا من ورا الاب بار
//         appBar: AppBar(
//           backgroundColor: Colors.transparent, // شفاف عشان يبان وراه
//           elevation: 0, // يشيل الظل
//           leading: IconButton(
//             onPressed: () {
//               // context.read<MovieBloc>().add(FetchMoviesEvent());
//               Navigator.pop(context);
//             },
//             icon: Icon(Icons.arrow_back_ios, color: Colors.white),
//           ),
//           actions: [
//             IconButton(
//               onPressed: () {},
//               icon: Icon(Icons.bookmark, color: Colors.white, size: 30),
//             ),
//           ],
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               MovieDetailsImageSection(movie: movie),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CustomButton(
//                       text: 'watch',
//                       onClick: () {
//                         if(movie!.url != null){
//                           _launchMovieUrl(movie.url!);
//                         }
//                       },
//                       backgroundColor: AppColors.red,
//                       borderColor: AppColors.red,
//                       textColor: AppColors.white,
//                     ),
//                     SizedBox(height: context.height * 0.03),
//                     _buildReactsWidget(movie),
//                     SizedBox(height: context.height * 0.01),
//                     MovieSections(
//                       title: 'Screen Shots',
//                       widget: ListView.builder(
//                         padding: EdgeInsets.zero,
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: screenShots.length,
//                         itemBuilder: (context, index) {
//                           return ScreenShotContainer(image: screenShots[index]);
//                         },
//                       ),
//                     ),
//                     MovieSections(
//                       title: 'Similar',
//                       widget: CustomGrideView(
//                         padding: EdgeInsets.zero,
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         movie: suggestedMovies,
//                       ),
//                     ),
//                     MovieSections(
//                       title: "Summary",
//                       widget: Text(
//                         movie!.descriptionFull!.isEmpty
//                             ? 'No description available'
//                             : movie.descriptionFull!,
//                         style: AppTextStyles.whiteRegular16,
//                         softWrap: true, // يخلي النص يكسر السطر تلقائي
//                       ),
//                     ),
//                     MovieSections(
//                       title: 'Cast',
//                       widget: _buildCastSection(movie),
//                     ),
//                     MovieSections(
//                       title: 'Genres',
//                       widget: _buildMovieGenresSection(movie),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   SizedBox _buildReactsWidget(Movie? movie) {
//     return SizedBox(
//       height: context.height * 0.06,
//       child: Row(
//         spacing: 6,
//         children: [
//           MovieDetailsNumbers(
//             text: movie?.likeCount.toString() ?? '',
//             image: AppAssets.love,
//           ),
//           MovieDetailsNumbers(
//             text: movie?.runtime.toString() ?? '',
//             image: AppAssets.timer,
//           ),
//           MovieDetailsNumbers(
//             text: movie?.rating!.toDouble().toString() ?? '',
//             image: AppAssets.negma,
//           ),
//         ],
//       ),
//     );
//   }
//   Future<void> _launchMovieUrl(String url)async{
//     context.showLoading();
//     final Uri uri = Uri.parse(url);
//     if(await canLaunchUrl(uri)){
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     }else{
//       context.showSnackBar("Could not launch the link",isError: true);
//     }
//   }

//   ListView _buildCastSection(Movie movie) {
//     return ListView.builder(
//       padding: EdgeInsets.zero,
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: movie.cast?.length,
//       itemBuilder: (context, index) {
//         final cast = movie.cast![index];
//         return Container(
//           padding: EdgeInsets.all(10),
//           margin: EdgeInsets.only(bottom: 8),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             color: AppColors.darkGrey,
//           ),
//           child: Row(
//             spacing: 10,
//             children: [
//               Container(
//                 width: context.width * 0.15,
//                 clipBehavior: Clip.antiAlias,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Image.network(
//                   cast.urlSmallImage ?? AppAssets.defaultPersonImage,
//                 ),
//               ),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   spacing: 10,
//                   children: [
//                     Text(
//                       'Name : ${cast.name}',
//                       style: AppTextStyles.whiteRegular16,
//                     ),
//                     Text(
//                       'Character : ${cast.characterName}',
//                       style: AppTextStyles.whiteRegular16,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   GridView _buildMovieGenresSection(Movie movie) {
//     List<String> getMovieGenres(Movie movie) {
//       final List<String> genresList = [];
//       for (String genre in movie.genres!) {
//         genresList.add(genre);
//       }
//       return genresList;
//     }

//     return GridView.builder(
//       padding: EdgeInsets.zero,
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         mainAxisSpacing: 10,
//         crossAxisSpacing: 16,
//         childAspectRatio: 2.5,
//       ),
//       itemCount: getMovieGenres(movie).length,
//       itemBuilder: (BuildContext context, int index) {
//         return Container(
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             color: AppColors.darkGrey,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Text(
//             getMovieGenres(movie)[index],
//             style: AppTextStyles.whiteRegular16,
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:movies_app/core/utils/constants/imports.dart'
    hide MovieDetailsSuccess, GetMovieDetails;
import 'package:movies_app/ui/screens/home/bloc/movie_details_bloc/movie_details_bloc.dart';
import 'package:movies_app/ui/screens/home/bloc/movie_details_bloc/movie_details_state.dart';
import 'package:movies_app/ui/screens/home/bloc/movie_details_bloc/movie_details_event.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void initState() {
    context.read<MovieDetailsBloc>().add(
      GetMovieDetails(movieId: widget.movieId),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      builder: (context, state) {
        if (state is MovieDetailsError) {
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
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.bookmark, color: Colors.white, size: 30),
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
    context.showLoading();
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      context.showSnackBar("Could not launch the link", isError: true);
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

  GridView _buildMovieGenresSection(Movie movie) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 16,
        childAspectRatio: 2.5,
      ),
      itemCount: movie.genres?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.darkGrey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            movie.genres![index],
            style: AppTextStyles.whiteRegular16,
          ),
        );
      },
    );
  }
}
