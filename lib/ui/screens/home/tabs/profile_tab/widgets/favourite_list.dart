// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:movies_app/ui/screens/home/tabs/profile_tab/cubit/favourite_cubit.dart';
// import 'package:movies_app/ui/screens/home/tabs/profile_tab/cubit/favourite_states.dart';
// import 'package:movies_app/ui/utils/app_colors.dart';
// import 'package:movies_app/ui/widgets/custom_gride_view.dart';

// class FavouriteList extends StatelessWidget {
//   const FavouriteList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => FavouriteCubit()..loadFavourites(),
//       child: BlocBuilder<FavouriteCubit, FavouriteStates>(
//         builder: (context, state) {
//           if (state is FavouriteLoading) {
//             return const Center(
//               child: CircularProgressIndicator(color: AppColors.yellow),
//             );
//           } else if (state is FavouriteLoaded) {
//             if (state.favourites.isEmpty) {
//               return const Center(child: Text("Your Wish List is empty"));
//             }
//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10),
//               child: CustomGrideView(rowItemCount: 3, movie: state.favourites),
//             );
//           } else if (state is FavouriteError) {
//             return Center(child: Text("Error: ${state.message}"));
//           }
//           return const Center(child: Text("No data yet"));
//         },
//       ),
//     );
//   }
// }
import 'package:movies_app/core/utils/constants/imports.dart';

class FavouriteList extends StatelessWidget {
  const FavouriteList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteCubit, FavouriteStates>(
      builder: (context, state) {
        if (state is FavouriteLoading) {
          return const Center(child: CircularProgressIndicator());
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
