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
            return const Center(child: Text("Your Wish List is empty"));
          }
          return CustomGrideView(rowItemCount: 3, movie: state.favourites);
        } else if (state is FavouriteError) {
          return Center(child: Text("Error: ${state.message}"));
        }
        return const Center(child: Text("No data yet"));
      },
    );
  }
}
