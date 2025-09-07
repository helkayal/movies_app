import 'package:movies_app/core/utils/constants/imports.dart';

class CustomGrideView extends StatelessWidget {
  final List<Movies>? movie;
  final int rowItemCount;
  final bool shrinkWrap ;
  final ScrollPhysics? physics;
  const CustomGrideView({
    super.key,
    required this.movie,
    this.rowItemCount = 2, this.shrinkWrap = false, this.physics,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: shrinkWrap,
      physics: physics,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: rowItemCount,
        mainAxisSpacing: 8,
        crossAxisSpacing: 20,
        childAspectRatio: 4 / 6,
      ),
      itemCount: movie?.length,
      itemBuilder: (context, index) {
        return CustomMovieImage(
          movieDetails: movie![index],
          image: movie?[index].mediumCoverImage ?? '',
          rating: movie?[index].rating.toString() ?? '',
        );
      },
    );
  }
}
