import 'package:flutter/material.dart';
import 'package:movies_app/ui/widgets/custom_movie_image.dart';

class CustomGrideView extends StatelessWidget {
  final List images;
  final List ratingd;
  final int rowItemCount;
  const CustomGrideView({
    super.key,
    required this.images,
    required this.ratingd,
    this.rowItemCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: rowItemCount,
        mainAxisSpacing: 8,
        crossAxisSpacing: 20,
        childAspectRatio: 4 / 6,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            //ToDO: go to movie details
            // Navigator.pushNamed(context, MovieDetailsRouteName, arguments: index);
          },
          child: CustomMovieImage(image: images[index], rating: ratingd[index]),
        );
      },
    );
  }
}
