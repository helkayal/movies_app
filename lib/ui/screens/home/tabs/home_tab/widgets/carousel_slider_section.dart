import 'package:movies_app/core/utils/constants/imports.dart';

class CarouselSliderSection extends StatelessWidget {
  final List<Movie> movies;
  const CarouselSliderSection({super.key, required this.movies});
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: movies.length,
      itemBuilder: (context, index, realIndex) {
        return CustomMovieImage(movieDetails: movies[index]);
      },
      options: CarouselOptions(
        onPageChanged: (index, reason) {
          context.read<ChangeBgImageBloc>().add(
            ChangeBgImage(movies[index].mediumCoverImage ?? ''),
          );
        },
        height: context.height * 0.5,
        viewportFraction: 0.53, //width
        // autoPlay: true,
        enlargeCenterPage: true,
        enlargeFactor: 0.4, // size of beside image
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
