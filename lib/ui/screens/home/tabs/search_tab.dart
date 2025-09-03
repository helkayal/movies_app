import 'package:flutter/material.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/data/repositories/home_repository/movie_repository.dart';
import '../../../../data/model/movie_dm.dart';
import '../../../widgets/custom_gride_view.dart';
import '../../../../core/utils/constants/app_assets.dart';
import '../../../../core/utils/context_extension.dart';
import '../../../widgets/custom_text_field.dart';

class SearchTab extends StatefulWidget {
  final List<Movies> movie;
  const SearchTab({super.key, required this.movie,});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  List<Movies> recievedMovies = [];
  final TextEditingController _searchController = TextEditingController();

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
              
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      hint: 'Search',
                      prefixIcon: Image.asset(
                        AppAssets.searchIcon,
                        width: context.width * 0.08,
                      ),
                      // onTap: (value) {
                      //   recievedMovies = MovieRepository.searchForMovie(movieName: value, movies: widget.movie);
                      // },
                    ),
                  ),
                  IconButton(onPressed: (){
                setState(() {
                recievedMovies = MovieRepository.searchForMovie(movieName: _searchController.text, movies: widget.movie);
                  print(recievedMovies);
                });
              }, icon: Icon(Icons.send_rounded,color: AppColors.white,)),

                ],
              ),
              if (recievedMovies.isEmpty)
                Expanded(
                  child: Center(child: Image.asset(AppAssets.emptyList)),
                )
              else
                Expanded(
                  child: CustomGrideView(movie: recievedMovies),
                ),
              
            ],
          ),
        ),
      );
  }
}
