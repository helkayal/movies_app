import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/services/Api/api_service.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/data/bloc/movie_bloc/movie_bloc.dart';
import 'package:movies_app/model/movie_dm.dart';
import 'package:movies_app/ui/screens/home/widgets/filter_bar.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/ui/widgets/custom_gride_view.dart';

class CategoryTab extends StatefulWidget {
  final List<Movies> movie;
  const CategoryTab({super.key, required this.movie, });

  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
            spacing: 8,
            children: [
              FilterBar(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: CustomGrideView(movie: widget.movie),
                ),
              ),
            ],
          );
  }
}
