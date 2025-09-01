import 'package:flutter/material.dart';
import 'package:movies_app/ui/screens/home/widgets/filter_bar.dart';
import 'package:movies_app/ui/utils/app_assets.dart';
import 'package:movies_app/ui/widgets/custom_gride_view.dart';

class CategoryTab extends StatefulWidget {
  const CategoryTab({super.key});

  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  @override
  Widget build(BuildContext context) {
    List<String> images = [
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
    List<String> ratings = [
      '7.0',
      '6.5',
      '8.0',
      '6.8',
      '8.2',
      '5.9',
      '4.4',
      '9.2',
      '8.8',
      '7.7',
    ];
    return Column(
      spacing: 8,
      children: [
        FilterBar(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: CustomGrideView(images: images, ratingd: ratings),
          ),
        ),
      ],
    );
  }
}
