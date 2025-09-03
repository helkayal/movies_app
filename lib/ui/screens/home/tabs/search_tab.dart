import 'package:flutter/material.dart';
import 'package:movies_app/model/movie_dm.dart';
import 'package:movies_app/ui/widgets/custom_gride_view.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/context_extension.dart';
import 'package:movies_app/ui/widgets/custom_text_field.dart';

class SearchTab extends StatelessWidget {
  final List<Movies> movie;
  const SearchTab({super.key, required this.movie,});

  @override
  Widget build(BuildContext context) {
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
                child: CustomGrideView(movie: movie)
              ),
            ],
          ),
        ),
      );
  }
}
