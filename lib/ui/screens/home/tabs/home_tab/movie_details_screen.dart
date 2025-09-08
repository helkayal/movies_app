import 'package:movies_app/core/utils/constants/imports.dart';
import 'package:movies_app/data/model/movie_details_model.dart';
import 'package:movies_app/ui/screens/home/tabs/home_tab/widgets/cast_section.dart';
import 'package:movies_app/ui/screens/home/tabs/home_tab/widgets/movie_details_image_section.dart';
import 'package:movies_app/ui/screens/home/tabs/home_tab/widgets/movie_details_numbers.dart';
import 'package:movies_app/ui/screens/home/tabs/home_tab/widgets/movie_genres_section.dart';
import 'package:movies_app/ui/screens/home/tabs/home_tab/widgets/screen_shot_container.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;
  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    context.read<MovieBloc>().add(GetMovieDetails(movieId: movieId));
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieError) {
          return Center(
            child: Text(state.message, style: AppTextStyles.whiteBold20),
          );
        } else if (state is MovieDetailsSuccess) {
          return _buildMovieDetails(context, movie: state.movie);
        } else {
          return Center(
            child: CircularProgressIndicator(color: AppColors.yellow),
          );
        }
      },
    );
  }

  SafeArea _buildMovieDetails(BuildContext context, {required Movie? movie}) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar:
            true, // 🔥 دي اللي هتخلي الكونتينر يبدا من ورا الاب بار
        appBar: AppBar(
          backgroundColor: Colors.transparent, // شفاف عشان يبان وراه
          elevation: 0, // يشيل الظل
          leading: IconButton(
            onPressed: () {
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
                    // ===== Similar =====
                    Text("Similar", style: AppTextStyles.whiteBold24),
                    CustomGrideView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      movie: [
                        Movies(
                          mediumCoverImage:
                              'https://wallpapercave.com/wp/wp1945933.jpg',
                          rating: 7.9,
                        ),
                        Movies(
                          mediumCoverImage:
                              'https://wallpapercave.com/wp/wp1945933.jpg',
                          rating: 1.5,
                        ),
                        Movies(
                          mediumCoverImage:
                              'https://wallpapercave.com/wp/wp1945933.jpg',
                          rating: 7.5,
                        ),
                        Movies(
                          mediumCoverImage:
                              'https://wallpapercave.com/wp/wp1945933.jpg',
                          rating: 5.2,
                        ),
                      ],
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
