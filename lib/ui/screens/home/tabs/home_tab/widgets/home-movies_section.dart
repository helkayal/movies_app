import 'package:movies_app/core/utils/constants/imports.dart';

class HomeMoviesSection extends StatelessWidget {
  const HomeMoviesSection({
    super.key,
    required this.movies,
    required this.sectionName,
  });
  final String sectionName;
  final List<Movie> movies;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.26,
      child: Column(
        children: [
          seeMoreSection(sectionName: sectionName),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return CustomMovieImage(
                  movieDetails: movies[index],
                  margin: EdgeInsets.only(left: 16),
                  width: context.width * 0.32,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Padding seeMoreSection({required String sectionName}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children: [
        Text(
          sectionName,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        const Spacer(),
        Text(
          'See More',
          style: TextStyle(
            color: AppColors.yellow,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(width: 2),
        Icon(Icons.arrow_forward_rounded, color: AppColors.yellow, size: 15),
      ],
    ),
  );
}