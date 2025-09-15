import 'package:movies_app/core/utils/constants/imports.dart';
import 'package:movies_app/ui/screens/home/movie_details/widgets/home_movies_section.dart';

class FutureBuilderPattern extends StatelessWidget {
  const FutureBuilderPattern({
    super.key,
    required this.sectionName,
    required this.moviesList,
  });
  final String sectionName;
  final Future<MovieDataModel> moviesList;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: moviesList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(color: AppColors.yellow),
            ),
          );
        }
        if (snapshot.hasError) {
          return Text('Error : ${snapshot.error}');
        } else if (snapshot.hasData) {
          return HomeMoviesSection(
            movies: snapshot.data?.data?.movies ?? [],
            sectionName: sectionName,
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
