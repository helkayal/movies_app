import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/ui/screens/home/widgets/custom_movie_image.dart';
import 'package:movies_app/ui/utils/app_assets.dart';

class CarouselSliderSection extends StatelessWidget {
  const CarouselSliderSection({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    final List<String> images = [
      AppAssets.pic1,
      AppAssets.pic2,
      AppAssets.pic1,
      AppAssets.pic2,
      AppAssets.pic1,
      AppAssets.pic2,
      AppAssets.pic1,
      AppAssets.pic2,
      AppAssets.pic1,
      AppAssets.pic1,
    ];
    return CarouselSlider.builder(
      itemCount: images.length,
      itemBuilder: (context, index, realIndex) {
        return InkWell(
          onTap: () {},
          child: CustomMovieImage(image: images[index]),
        );
      },
      options: CarouselOptions(
        height: height * 0.5,
        viewportFraction: 0.53, //width
        // autoPlay: true,
        enlargeCenterPage: true,
        enlargeFactor: 0.4, // size of beside image
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
