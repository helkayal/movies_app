import 'package:movies_app/core/utils/constants/imports.dart';

class ScreenShotContainer extends StatelessWidget {
  final String? image;
  const ScreenShotContainer({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      height: context.height * 0.2,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: CachedNetworkImage(
        imageUrl: image ?? AppAssets.defaultScreenShotImage,
        fit: BoxFit.cover,
        placeholder: (context, url) => Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: CircularProgressIndicator(color: AppColors.yellow),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          height: context.height * 0.2,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: Image.network(AppAssets.defaultScreenShotImage,fit: BoxFit.cover,)
        ),
      ),
    );
  }
}
