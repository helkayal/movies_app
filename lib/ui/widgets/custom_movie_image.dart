import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../core/utils/constants/app_assets.dart';
import '../../core/theme/app_colors.dart';

class CustomMovieImage extends StatelessWidget {
  final double? width;
  final double? height;
  final String image;
  final String rating;
  final EdgeInsetsGeometry? margin;
  const CustomMovieImage({
    super.key,
    required this.image,
    required this.rating,
    this.width,
    this.height,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      imageBuilder: (context, imageProvider) => Container(
        clipBehavior: Clip.antiAlias,
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
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
      ),
      placeholder: (context, url) => Center(child: Padding(
        padding: const EdgeInsets.all(20),
        child: CircularProgressIndicator(color: AppColors.yellow,),
      )),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
