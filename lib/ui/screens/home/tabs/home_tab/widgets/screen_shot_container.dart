import 'package:movies_app/core/utils/constants/imports.dart';

class ScreenShotContainer extends StatelessWidget {
  final String image;
  const ScreenShotContainer({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(16),
        child: Image.network(image),
      ),
    );
  }
}
