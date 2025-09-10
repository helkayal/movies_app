// import 'package:movies_app/core/utils/constants/imports.dart';
// import 'package:movies_app/ui/screens/home/tabs/profile_tab/cubit/history_cubit.dart';
// import 'package:movies_app/ui/screens/home/tabs/profile_tab/cubit/history_states.dart';

// class HistoryList extends StatelessWidget {
//   const HistoryList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HistoryCubit, HistoryStates>(
//       builder: (context, state) {
//         if (state is HistoryLoading) {
//           return const Center(
//             child: CircularProgressIndicator(color: AppColors.yellow),
//           );
//         } else if (state is HistoryLoaded) {
//           if (state.movies.isEmpty) {
//             return const Center(child: Text("Your History is empty"));
//           }
//           return CustomGrideView(rowItemCount: 3, movie: state.movies);
//         } else if (state is HistoryError) {
//           return Center(child: Text("Error: ${state.message}"));
//         }
//         return const Center(child: Text("No history yet"));
//       },
//     );
//   }
// }
import 'package:movies_app/core/utils/constants/imports.dart';
import 'package:movies_app/ui/screens/home/tabs/profile_tab/cubit/history_cubit.dart';
import 'package:movies_app/ui/screens/home/tabs/profile_tab/cubit/history_states.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryCubit, HistoryStates>(
      builder: (context, state) {
        if (state is HistoryLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.yellow),
          );
        } else if (state is HistoryLoaded) {
          final movies = state.movies;
          if (movies.isEmpty) {
            return Center(child: Image.asset(AppAssets.emptyList));
          }
          return CustomGrideView(rowItemCount: 3, movie: movies);
        } else if (state is HistoryError) {
          return Center(child: Text("Error: ${state.message}"));
        }
        return const Center(child: Text("No history yet"));
      },
    );
  }
}
