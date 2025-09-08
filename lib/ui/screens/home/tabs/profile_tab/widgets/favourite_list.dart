import 'package:movies_app/core/utils/constants/imports.dart';

class FavouriteList extends StatelessWidget {
  const FavouriteList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteCubit, FavouriteStates>(
      builder: (context, state) {
        if (state is FavouriteLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.yellow),
          );
        } else if (state is FavouriteLoaded) {
          if (state.favourites.isEmpty) {
            return Center(child: Image.asset(AppAssets.emptyList));
          }
          return CustomGrideView(rowItemCount: 3, movie: state.favourites);
        } else if (state is FavouriteError) {
          return Center(child: Text("Error: ${state.message}"));
        }
        return Center(child: Image.asset(AppAssets.emptyList));
      },
    );
  }
}
