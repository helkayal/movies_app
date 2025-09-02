import 'package:flutter/material.dart';
import 'package:movies_app/model/movie_dm.dart';
import 'package:movies_app/ui/widgets/custom_movie_image.dart';

class CustomGrideView extends StatelessWidget {
  final List<Movies>? movie;
  final int rowItemCount;
  const CustomGrideView({super.key, required this.movie,  this.rowItemCount = 2});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: rowItemCount,
        mainAxisSpacing: 8,
        crossAxisSpacing: 20,
        childAspectRatio: 4 / 6,
      ),
      itemCount: movie?.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            //ToDO: go to movie details
            // Navigator.pushNamed(context, MovieDetailsRouteName, arguments: index);
          },
          child: CustomMovieImage(
            image: movie?[index].mediumCoverImage ?? '',
            rating:movie?[index].rating.toString() ?? '',));
      },
    );
  }
}
