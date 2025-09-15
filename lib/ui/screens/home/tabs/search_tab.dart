import 'package:movies_app/core/utils/constants/imports.dart';

import '../../../../l10n/app_localizations.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key, });

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;
  List<Movie> filteredMovies = [];
  List<Movie>? movies ;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
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
                    controller: _searchController,
                    hint: loc.search,
                    prefixIcon: Image.asset(
                      AppAssets.searchIcon,
                      width: context.width * 0.08,
                    ),
                    onChanged: (value) {
                      _onSearchChanged(value);
                    },
                  ),
                ),
              ],
            ),
            FutureBuilder(
              future: MovieRepository.searchForMovies(
                query: _searchController.text,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    child: Center(
                      child: CircularProgressIndicator(color: AppColors.yellow),
                    ),
                  );
                } else if (snapshot.hasData) {
                  movies = snapshot.data?.data?.movies;
                  return Expanded(
                    child: _searchController.text.isEmpty
                        ? Center(child: Image.asset(AppAssets.emptyList))
                        : CustomGrideView(movie: filteredMovies),
                  );
                } else {
                  return Text('Error : ${snapshot.error}');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  //الفانكشن ديه مهمه عشان مايفضلش يستدعى كذا مرة ف يكون الاداء احسن
  void _onSearchChanged(String value) {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      if(movies != null){
        setState(() {
        filteredMovies = movies!.where((movie)=> movie.title!.toLowerCase().trim().startsWith(value.toLowerCase().trim())).toList();
        ///___________________
        // searchedMovies = MovieRepository.addSearchedValueToSearchedList(
        //   searchedMovie: value,
        //   movies: widget.movie,
        // );
      });
      }
      
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }
}
