import 'package:movies_app/core/utils/constants/imports.dart';
import 'package:movies_app/data/model/movie_details_model.dart';

class CustomGrideView extends StatelessWidget {
  final List<Movie>? movie;
  final int rowItemCount;
  final bool shrinkWrap ;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  const CustomGrideView({
    super.key,
    required this.movie,
    this.rowItemCount = 2, this.shrinkWrap = false, this.physics, this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: padding,
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
        );
      },
    );
  }
}
