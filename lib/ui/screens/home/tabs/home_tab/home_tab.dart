import 'package:movies_app/core/utils/constants/imports.dart';
import 'package:movies_app/core/l10n/app_localizations.dart';
import 'package:movies_app/ui/screens/home/tabs/home_tab/widgets/future_builder_pattern.dart';

class HomeTab extends StatelessWidget {
  final List<Movie> movies;
  const HomeTab({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    var loc = AppLocalizations.of(context)!;
    Future<MovieDataModel> popularMoviesList =
        MovieRepository.getMostPopularMovies();
    Future<MovieDataModel> actionMovies = MovieRepository.getSpecifiedMovies(
      genreName: "Action",
    );
    Future<MovieDataModel> animationMovies = MovieRepository.getSpecifiedMovies(
      genreName: "Animation",
    );
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: context.height * 0.64,
            child: BlocBuilder<ChangeBgImageBloc, ChangeBgImageState>(
              builder: (context, state) {
                String imagePath =
                    movies[0].mediumCoverImage ??
                    ''; //default image => first image in api
                if (state is ChangeBgImageSuccess) {
                  imagePath = state.imagePath;
                }
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.black.withValues(alpha: 0.8),
                          AppColors.black.withValues(alpha: 0.6),
                          AppColors.black,
                        ],
                      ),
                    ),
                    child: Column(
                      spacing: context.height * 0.01,
                      children: [
                        Image.asset(
                          AppAssets.availableNow,
                          height: context.height * 0.1,
                        ),
                        Expanded(child: CarouselSliderSection(movies: movies)),
                        Image.asset(
                          AppAssets.watchNow,
                          width: context.width * 0.76,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          FutureBuilderPattern(
            sectionName: loc.popular_movies,
            moviesList: popularMoviesList,
          ),
          SizedBox(height: context.height * 0.02),
          FutureBuilderPattern(
            sectionName: loc.action,
            moviesList: actionMovies,
          ),
          SizedBox(height: context.height * 0.02),
          FutureBuilderPattern(
            sectionName: loc.animation,
            moviesList: animationMovies,
          ),
          SizedBox(height: context.height * 0.05),
        ],
      ),
    );
  }
}
