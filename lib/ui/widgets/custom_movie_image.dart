import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/core/utils/constants/app_assets.dart';
import 'package:movies_app/core/utils/context_extension.dart';
import 'package:movies_app/data/model/movie_data_model.dart';
import 'package:movies_app/ui/screens/home/bloc/movie_details_bloc/movie_details_bloc.dart';
import 'package:movies_app/ui/screens/home/bloc/movie_details_bloc/movie_details_event.dart';
import 'package:movies_app/ui/screens/home/tabs/home_tab/movie_details_screen.dart';
import 'package:movies_app/ui/screens/home/tabs/profile_tab/cubit/history_cubit.dart';

class CustomMovieImage extends StatelessWidget {
  final double? width;
  final double? height;
  final Movie movieDetails;
  final EdgeInsetsGeometry? margin;
  const CustomMovieImage({
    super.key,
    this.width,
    this.height,
    this.margin,
    required this.movieDetails,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _onMoviePressed(context, movieDetails);
      },
      child: CachedNetworkImage(
        imageUrl: movieDetails.mediumCoverImage ?? '',
        imageBuilder: (context, imageProvider) => Container(
          clipBehavior: Clip.antiAlias,
          width: width,
          height: height,
          margin: margin,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: context.width * 0.15,
              height: context.height * 0.04,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.black.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Text(
                    movieDetails.rating.toString(),
                    style: TextStyle(color: AppColors.white, fontSize: 16),
                  ),
                  Expanded(child: Image.asset(AppAssets.star)),
                ],
              ),
            ),
          ),
        ),
        placeholder: (context, url) => Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: CircularProgressIndicator(color: AppColors.yellow),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          clipBehavior: Clip.antiAlias,
          width: width,
          height: height,
          margin: margin,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: AssetImage(AppAssets.defaultImage),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}

//THE FUNCTION THAT WILL TAKE THE MOVIE ID AND NAVIGATE
// i ADDED HERE CAUSE IT'S THE MAIN WIDGET NOT GRIDE VIEW OR LIST VIEW
void _onMoviePressed(BuildContext context, Movie movie) {
  final historyCubit = context.read<HistoryCubit>();

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (_) =>
            MovieDetailsBloc()..add(GetMovieDetails(movieId: movie.id!)),
        child: MovieDetailsScreen(movieId: movie.id!),
      ),
    ),
  ).then((_) {
    // Reload history when back
    historyCubit.loadHistory();
  });
}
