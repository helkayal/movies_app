import 'package:movies_app/core/utils/constants/imports.dart';

class MovieDetailsImageSection extends StatelessWidget {
  final Movie? movie;
  const MovieDetailsImageSection({super.key, this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: context.height * 0.66),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(movie?.largeCoverImage ?? ''),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.black.withValues(alpha: 0.2), AppColors.black],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: context.height * 0.28),
              child: Image.asset(AppAssets.video),
            ),
            SizedBox(height: context.height * 0.14),
            Text(
              movie?.title ?? '',
              style: AppTextStyles.whiteBold20,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 14),
            Text(
              movie?.year.toString() ?? '',
              style: AppTextStyles.whiteBold20.copyWith(
                color: Color(0xFFADADAD),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
