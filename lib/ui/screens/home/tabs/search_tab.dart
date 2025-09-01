import 'package:flutter/material.dart';
import 'package:movies_app/ui/widgets/custom_gride_view.dart';
import 'package:movies_app/ui/utils/app_assets.dart';
import 'package:movies_app/ui/utils/context_extension.dart';
import 'package:movies_app/ui/widgets/custom_text_field.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          spacing: 20,
          children: [
            CustomTextField(
              hint: 'Search',
              prefixIcon: Image.asset(
                AppAssets.searchIcon,
                width: context.width * 0.08,
              ),
            ),
            // Expanded(child: 
            // Center(child: Image.asset(AppAssets.emptyList),)
            // )
            Expanded(
              child: CustomGrideView(images: images)
            ),
          ],
        ),
      ),
    );
  }
}
