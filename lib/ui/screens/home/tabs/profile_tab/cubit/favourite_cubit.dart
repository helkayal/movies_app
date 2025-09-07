import 'package:movies_app/core/utils/constants/imports.dart';
import 'package:movies_app/core/utils/secure_storage_utils.dart';

class FavouriteCubit extends Cubit<FavouriteStates> {
  FavouriteRepositoryImpl? repository;

  FavouriteCubit() : super(FavouriteInitial());

  Future<void> loadFavourites() async {
    emit(FavouriteLoading());
    try {
      // get token asynchronously
      final token = await SecureStorageUtils().getToken();
      if (token == null) {
        throw Exception("No token found, please login again");
      }

      // init repository here
      final apiService = FavouriteApiService(token: token);
      final dataSource = FavouriteDataSourceImpl(apiService);
      repository = FavouriteRepositoryImpl(dataSource);

      final response = await repository!.fetchFavourites();

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
