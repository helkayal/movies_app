
import 'package:movies_app/core/utils/constants/imports.dart';

class CategoryTab extends StatefulWidget {
  List<Movies> movie;
  CategoryTab({super.key, required this.movie});

  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  int selecteButton = 0;
  List<Movies> movieByGenre = [];
  @override
  void initState() {
    super.initState();
    //علشان خاطر اجيب اول فئه كان لازم اعمل init state بتحددلى ان اول عنصر هو 0 
    //خصوصا ان الليست فاضيه فى الاول ولما ادوس على زرار الفئه الفانكشن الى بتجيب الافلام تشتغل مع كل زرار 
    // عملت ليسته جديده عشان دى الى هتخزن الافلام حسب الفئه 
    //ولما اقفل وافتح التابه دى هتبقى اول قيمة هى الى selected طبعا عشان ال0 
    movieByGenre = MovieRepository.getMoviesByGenres(
      genre: MovieRepository.getGenres(movies: widget.movie)[0],
      movies: widget.movie,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> genersList = MovieRepository.getGenres(movies: widget.movie);
    return Column(
      spacing: 8,
      children: [
        Container(
          margin: EdgeInsets.only(left: 8, top: 16),
          height: context.height * 0.06,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: genersList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    selecteButton = index;
                    movieByGenre = MovieRepository.getMoviesByGenres(
                      genre: genersList[index],
                      movies: widget.movie,
                    );
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    color: selecteButton == index
                        ? AppColors.yellow
                        : Colors.transparent,
                    border: Border.all(color: AppColors.yellow, width: 2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    genersList[index],
                    style: selecteButton == index
                        ? AppTextStyles.blackBold20
                        : AppTextStyles.yelowBold20,
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: CustomGrideView(movie: movieByGenre),
          ),
        ),
      ],
    );
  }
}
