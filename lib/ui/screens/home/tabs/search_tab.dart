
import 'package:movies_app/core/utils/constants/imports.dart';
import 'package:movies_app/data/model/movie_details_model.dart';

class SearchTab extends StatefulWidget {
  final List<Movie> movie;
  const SearchTab({super.key, required this.movie});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;
  List<Movie> searchedMovies = [];

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
                    controller: _searchController,
                    hint: 'Search',
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
            Expanded(
              child: searchedMovies.isEmpty
                  ? Center(child: Image.asset(AppAssets.emptyList))
                  : CustomGrideView(movie: searchedMovies),
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
      setState(() {
        searchedMovies = MovieRepository.addSearchedValueToSearchedList(
          searchedMovie: value,
          movies: widget.movie,
        );
      });
    });
  }
  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }
}
