import 'package:movies_app/core/utils/constants/imports.dart';

class HomeTab extends StatelessWidget {
  final List<Movies> movie;
  const HomeTab({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: BlocBuilder<ChangeBgImageBloc,ChangeBgImageState>(
                  builder: (context, state) {
                    String imagePath = movie[0].mediumCoverImage ?? ''; //default image => first image in api
                    if(state is ChangeBgImageSuccess){
                      imagePath = state.imagePath;
                    }
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.black.withValues(alpha: 0.8),
                              AppColors.black.withValues(alpha: 0.6),
                              AppColors.black,
                            ],
                          ),
                        ),
                        child: Column(
                          spacing: context.height * 0.01,
                          children: [
                            Image.asset(
                              AppAssets.availableNow,
                              height: context.height * 0.1,
                            ),
                            Expanded(
                              child: CarouselSliderSection(movie:movie,),
                            ),
                            Image.asset(
                              AppAssets.watchNow,
                              width: context.width * 0.76,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                ),
              ),
              SizedBox(
                height: context.height * 0.28,
                child: Column(
                  children: [
                    seeMoreSection(),
                    const SizedBox(height: 12),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: movie.length ,
                        itemBuilder: (context, index) {
                          return CustomMovieImage(
                            movieDetails: movie[index],
                            rating: movie[index].rating.toString(),
                            image: movie[index].mediumCoverImage ??'',
                            margin: EdgeInsets.only(left: 16),
                            width: context.width * 0.32,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
          SizedBox(height: context.height * 0.02),
        ],
      );
    }
  }

  Padding seeMoreSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            'Action',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () {},
            child: Text(
              'See More',
              style: TextStyle(
                color: AppColors.yellow,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(width: 2),
          Icon(Icons.arrow_forward_rounded, color: AppColors.yellow, size: 15),
        ],
      ),
    );
  }

