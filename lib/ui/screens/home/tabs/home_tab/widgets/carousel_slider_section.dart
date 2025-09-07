
import 'package:movies_app/core/utils/constants/imports.dart';

class CarouselSliderSection extends StatelessWidget {
  final List<Movies> movie;
  const CarouselSliderSection({super.key, required this.movie, });
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: movie.length,
      itemBuilder: (context, index, realIndex) {
        return CustomMovieImage(
          movieDetails: movie[index],
          image: movie[index].mediumCoverImage ?? '',
          rating: movie[index].rating.toString(),
        );
      },
      options: CarouselOptions(
        onPageChanged: (index, reason) {
          context.read<ChangeBgImageBloc>().add(ChangeBgImage(movie[index].mediumCoverImage ?? ''));
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
