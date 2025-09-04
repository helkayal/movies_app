import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/services/Api/favourite_api_service.dart';
import 'package:movies_app/data/datasources/favourite/favourite_data_source_impl.dart';
import 'package:movies_app/data/repositories/favourite/favourite_repository_impl.dart';
import 'package:movies_app/model/movie_dm.dart';
import 'package:movies_app/ui/screens/home/tabs/profile_tab/cubit/favourite_states.dart';

class FavouriteCubit extends Cubit<FavouriteStates> {
  late final FavouriteRepositoryImpl repository;

  FavouriteCubit() : super(FavouriteInitial()) {
    // final token = SharedPrefsUtils.getString("token") ?? "";
    final token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4YjhhMmQ0MTY3MDRjYzg5NWNhYzI0MyIsImVtYWlsIjoiaGVsa2F5YWxAZ21haWwuY29tIiwiaWF0IjoxNzU2OTMwNzc4fQ.HRGvVM_qBlIRsxezd_rgnB-cIo-D4N_QPWpmGmZzqhI";
    final apiService = FavouriteApiService(token: token);
    final dataSource = FavouriteDataSourceImpl(apiService);
    repository = FavouriteRepositoryImpl(dataSource);
  }

  Future<void> loadFavourites() async {
    emit(FavouriteLoading());
    try {
      final response = await repository.fetchFavourites();

      final List<dynamic> favouriteJson = response["data"];
      final favourites = favouriteJson.map((e) {
        return Movies(
          id: int.tryParse(e['movieId'] ?? ''),
          title: e['name'],
          rating: (e['rating'] as num?)?.toDouble(),
          year: int.tryParse(e['year'] ?? ''),
          mediumCoverImage: e['imageURL'],
        );
      }).toList();

      emit(FavouriteLoaded(favourites));
    } catch (e) {
      emit(FavouriteError(e.toString()));
    }
  }
}
