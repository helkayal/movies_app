import 'package:movies_app/core/utils/constants/imports.dart';

class MovieDetailsNumbers extends StatelessWidget {
  final String text;
  final String image;
  const MovieDetailsNumbers({
    super.key,
    required this.text,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // width: context.width * 0.28,
        // height: context.height * 0.07,
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: AppColors.darkGrey,
        ),
        child: Row(
          spacing: 14,
          children: [
            Expanded(child: Image.asset(image)),
            Text(text, style: AppTextStyles.whiteBold20),
          ],
        ),
      ),
    );
  }
}
