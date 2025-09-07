import 'package:movies_app/core/utils/constants/imports.dart';
import 'package:movies_app/ui/screens/home/tabs/home_tab/widgets/movie_details_image_section.dart';
import 'package:movies_app/ui/screens/home/tabs/home_tab/widgets/movie_details_numbers.dart';

class MovieDetails extends StatelessWidget {
  final int movieId;
  const MovieDetails({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    context.read<MovieBloc>().add(GetMovieDetails(movieId: movieId));
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieError) {
          return Center(
            child: Text(state.message, style: AppTextStyles.whiteBold20),
          );
        } else if (state is MovieDetailsSuccess) {
          return _buildMovieDetails(context, movie: state.movie!);
        } else {
          return Center(
            child: CircularProgressIndicator(color: AppColors.yellow),
          );
        }
      },
    );
  }

  SafeArea _buildMovieDetails(BuildContext context, {required Movies? movie}) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar:
            true, // 🔥 دي اللي هتخلي الكونتينر يبدا من ورا الاب بار
        appBar: AppBar(
          backgroundColor: Colors.transparent, // شفاف عشان يبان وراه
          elevation: 0, // يشيل الظل
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.bookmark, color: Colors.white,size: 30,),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MovieDetailsImageSection(movie: movie,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    CustomButton(
                      text: 'watch',
                      onClick: () {},
                      backgroundColor: AppColors.red,
                      borderColor: AppColors.red,
                      textColor: AppColors.white,
                    ),
                    SizedBox(height: context.height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MovieDetailsNumbers(
                          text: movie?.likeCount.toString() ?? '',
                          image: AppAssets.love,
                        ),
                        MovieDetailsNumbers(
                          text: movie?.runtime.toString() ?? '',
                          image: AppAssets.timer,
                        ),
                        MovieDetailsNumbers(
                          text: movie?.rating!.toDouble().toString() ?? '',
                          image: AppAssets.star,
                        ),
                      ],
                    ),
                    SizedBox(height: context.height * 0.03),
                    // ===== Screen Shots =====
                    Text("Screen Shots", style: AppTextStyles.whiteBold24),
                    
                    SizedBox(
                      height: context.height * 0.45, // 👈 قللتها بدل 0.7
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: context.height * 0.02),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                "assets/images/screen${index + 1}.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: context.height * 0.015), // 👈 قللت المسافة
                    // ===== Similar =====
                    Padding(
                      padding: EdgeInsets.only(right: context.width * 0.7),
                      child: Text(
                        "Similar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    
                    SizedBox(height: context.height * 0.01), // 👈 قللت المسافة
                    
                    CustomGrideView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      movie: [
                        Movies(mediumCoverImage: AppAssets.pic1, rating: 7.9),
                        Movies(mediumCoverImage: AppAssets.pic1, rating: 1.5),
                        Movies(mediumCoverImage: AppAssets.pic2, rating: 7.5),
                        Movies(mediumCoverImage: AppAssets.pic2, rating: 5.2),
                      ],
                    ),
                    
                    // ===== Summary =====
                    Text("Summary", style: AppTextStyles.whiteBold24),
                    const SizedBox(height: 12),
                    Text(
                      movie?.descriptionFull ?? '',
                      style: AppTextStyles.whiteRegular16,
                      softWrap: true, // 👈 يخلي النص يكسر السطر تلقائي
                      overflow: TextOverflow.visible, // يظهر كله بدون قص
                    ),
                    const SizedBox(height: 30),
                    CastSection(),
                    const SizedBox(height: 30),
                    // ===== Genres =====
                    const Text(
                      "Genres",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // أول صف 3 Genres
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildGenreContainer("Action"),
                        _buildGenreContainer("Sci-Fi"),
                        _buildGenreContainer("Adventure"),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // تاني صف 2 Genres
                    Row(
                      children: [
                        _buildGenreContainer("Fantasy"),
                        const SizedBox(width: 12),
                        _buildGenreContainer("Horror"),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

// ===== ويدجيت الكونتينر بتاع Genres =====
Widget _buildGenreContainer(String genre) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.grey[900],
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      genre,
      style: const TextStyle(color: Colors.white, fontSize: 14),
    ),
  );
}

class CastSection extends StatelessWidget {
  const CastSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Cast",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Container(
                    width: context.width * 0.7,
                    height: context.height * 0.07,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.darkGrey,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(AppAssets.char1),
                        ),
                        Column(
                          children: [
                            Text(
                              'Name : Hayley Atwell',
                              style: AppTextStyles.whiteRegular16,
                            ),
                            Text(
                              'Character : Captain Carter',
                              style: AppTextStyles.whiteRegular16,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

// ===== ويدجيت أيكونات Like, Rate, Time =====
// Widget _buildIconContainer(IconData icon, String label) {
//   return Container(
//     width: 80,
//     height: 80,
//     decoration: BoxDecoration(
//       color: Colors.grey[900],
//       borderRadius: BorderRadius.circular(16),
//     ),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(icon, color: Colors.white, size: 28),
//         const SizedBox(height: 8),
//         Text(label, style: const TextStyle(color: Colors.white, fontSize: 14)),
//       ],
//     ),
//   );
// }
