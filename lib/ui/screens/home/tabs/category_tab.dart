import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utils/constants/imports.dart';

class CategoryTab extends StatefulWidget {
  const CategoryTab({super.key});

  @override
  State<CategoryTab> createState() => _CategoryTabState();
}
//all comments are the old version of code

class _CategoryTabState extends State<CategoryTab> {
  int selecteButton = 0;
  // List<Movie> movieByGenre = [];
  late Future<MovieDataModel> movies;
  //   //علشان خاطر اجيب اول فئه كان لازم اعمل init state بتحددلى ان اول عنصر هو 0
  //   //خصوصا ان الليست فاضيه فى الاول ولما ادوس على زرار الفئه الفانكشن الى بتجيب الافلام تشتغل مع كل زرار
  //   // عملت ليسته جديده عشان دى الى هتخزن الافلام حسب الفئه
  //   //ولما اقفل وافتح التابه دى هتبقى اول قيمة هى الى selected طبعا عشان ال0
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    movies = MovieRepository.getSpecifiedMovies(genreName: genresMap(context).keys.first);
    
  }

  Future<MovieDataModel> _ontapGenre(String genreName) {
    return MovieRepository.getSpecifiedMovies(genreName: genreName);
  }

  Map<String, String> genresMap(BuildContext context) {
    return {
      "Animation": context.loc.animation,
      'Romance': context.loc.romance,
      'Adventure': context.loc.adventure,
      'Fantasy': context.loc.fantasy,
      'Horror': context.loc.horror,
      'Comedy': context.loc.comedy,
      'Family': context.loc.family,
      'Crime': context.loc.crime,
      'Thriller': context.loc.thriller,
      'Musical': context.loc.musical,
      'Drama': context.loc.drama,
      'Sci-Fi': context.loc.sciFi,
      'Documentary': context.loc.documentary,
      'Mystery': context.loc.mystery,
      'Talk-Show': context.loc.talkShow,
      'Sport': context.loc.sport,
    };
  }

  @override
  Widget build(BuildContext context) {
    // List<String> genresList = MovieRepository.getGenres(movies: widget.movie);
    return Column(
      spacing: 8,
      children: [
        Container(
          margin: EdgeInsets.only(left: 8, top: 16),
          height: 60.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: genresMap(context).length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    selecteButton = index;
                    movies = _ontapGenre(genresMap(context).keys.toList()[index]);
                    // movieByGenre = MovieRepository.getMoviesByGenres(
                    //   genre: genersList[index],
                    //   movies: widget.movie,
                    // );
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                  margin: EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    color: selecteButton == index
                        ? AppColors.yellow
                        : Colors.transparent,
                    border: Border.all(color: AppColors.yellow, width: 2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    genresMap(context).values.toList()[index],
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
            child: FutureBuilder(
              future: movies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: AppColors.yellow),
                  );
                } else if (snapshot.hasError) {
                  return Text("Error While fetching movies");
                } else if (snapshot.hasData) {
                  return CustomGrideView(
                    movie: snapshot.data?.data?.movies ?? [],
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
