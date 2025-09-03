import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/ui/screens/home/bloc/change_bg_image_bloc/change_bg_image_bloc.dart';
import '../../../../core/utils/context_extension.dart';
import '../../../../data/model/movie_dm.dart';
import '../../../widgets/custom_movie_image.dart';

class CarouselSliderSection extends StatelessWidget {
  final List<Movies>? movie;
  const CarouselSliderSection({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: movie?.length,
      itemBuilder: (context, index, realIndex) {
        return InkWell(
          onTap: () {},
          child: CustomMovieImage(
            image: movie?[index].mediumCoverImage ?? '',
            rating: movie?[index].rating.toString() ?? '',
          ),
        );
      },
      options: CarouselOptions(
        onPageChanged: (index, reason) {
          context.read<ChangeBgImageBloc>().add(ChangeBgImage(movie![index].mediumCoverImage ?? ''));
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
