import 'package:movies_app/core/utils/constants/imports.dart';

class MovieSections extends StatelessWidget {
  final String title;
  final Widget widget;
  const MovieSections({super.key, required this.title,required this.widget});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(title, style: AppTextStyles.whiteBold24),
        const SizedBox(height: 8),
        widget,
        const SizedBox(height: 16),
      ],
    );
  }

  
  
}
