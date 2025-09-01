import 'package:flutter/material.dart';
import 'package:movies_app/ui/utils/app_assets.dart';
import 'package:movies_app/ui/utils/app_colors.dart';

class CustomMovieImage extends StatelessWidget {
  final double? width;
  final double? height;
  final String image;
  final String rating;
  final EdgeInsetsGeometry? margin;
  const CustomMovieImage({
    super.key,
    required this.image,
    this.rating = '0.0',
    this.width,
    this.height,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.amber,
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          width: MediaQuery.sizeOf(context).width * 0.15,
          padding: EdgeInsets.all(4),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.black.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                rating,
                style: TextStyle(color: AppColors.white, fontSize: 16),
              ),
              const SizedBox(width: 4),
              Image.asset(AppAssets.star),
            ],
          ),
        ),
      ),
    );
  }
}
