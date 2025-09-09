import 'package:movies_app/core/utils/constants/imports.dart';

class ScreenShotContainer extends StatelessWidget {
  final String image;
  const ScreenShotContainer({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        height: context.height * 0.3,
        width: context.width,
      clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.cover,
          ),
        ),
      )
    );
  }
}
