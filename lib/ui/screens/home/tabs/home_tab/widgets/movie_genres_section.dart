import 'package:movies_app/core/utils/constants/imports.dart';
import 'package:movies_app/data/model/movie_details_model.dart';

class MovieGenresSection extends StatelessWidget {
  final Movie movie;
  const MovieGenresSection({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Genres", style: AppTextStyles.whiteBold24),
        const SizedBox(height: 12),
        GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 16,
            childAspectRatio: 2.5,
          ),
          itemCount: _getMovieGenres(movie).length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.darkGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _getMovieGenres(movie)[index],
                style: AppTextStyles.whiteRegular16,
              ),
            );
          },
        ),
      ],
    );
  }

  List<String> _getMovieGenres(Movie movie) {
    final List<String> genresList = [];
    for (String genre in movie.genres!) {
      genresList.add(genre);
    }
    return genresList;
  }
}
