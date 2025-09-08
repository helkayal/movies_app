import 'package:movies_app/core/utils/constants/imports.dart';
import 'package:movies_app/data/model/movie_details_model.dart';

class CastSection extends StatelessWidget {
  final Movie movie;
  const CastSection({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Cast",
          style: AppTextStyles.whiteBold24
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (context, index) {
            final cast = movie.cast![index];
            return 
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.darkGrey,
                  ),
                  child: Row(
                    spacing: 10,
                    children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Image.network(cast.urlSmallImage ?? AppAssets.defaultPersonImage),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10,
                        children: [
                          Text(
                            'Name : ${cast.name}',
                            style: AppTextStyles.whiteRegular16,
                          ),
                          Text(
                            'Character : ${cast.characterName}',
                            style: AppTextStyles.whiteRegular16,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
          },
        ),
      ],
    );
  }
}