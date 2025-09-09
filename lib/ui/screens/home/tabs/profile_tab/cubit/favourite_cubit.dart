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
        return Movie(
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

  Future<void> addFavourite({
    required String movieId,
    required String name,
    required double rating,
    required String imageURL,
    required String year,
  }) async {
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

      final response = await repository!.addFavourite(
        movieId: movieId,
        name: name,
        rating: rating,
        imageURL: imageURL,
        year: year,
      );

      // final List<dynamic> favouriteJson = response["data"];
      // final favourites = favouriteJson.map((e) {
      //   return Movie(
      //     id: int.tryParse(e['movieId'] ?? ''),
      //     title: e['name'],
      //     rating: (e['rating'] as num?)?.toDouble(),
      //     year: int.tryParse(e['year'] ?? ''),
      //     mediumCoverImage: e['imageURL'],
      //   );
      // }).toList();

      if (response["message"] == "Added to favourite successfully") {
        emit(FavouriteAdded());
      } else {
        emit(FavouriteError(response["message"]));
      }
    } catch (e) {
      emit(FavouriteError(e.toString()));
    }
  }

  Future<bool> isMovieFavourite({required String movieId}) async {
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

      final response = await repository!.isMovieFavourite(movieId: movieId);

      emit(isFavouriteLoaded());
      return response["data"];
    } catch (e) {
      return false;
    }
  }

  Future<void> removeMovieFromFavourite({required String movieId}) async {
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

      final response = await repository!.removeMovieFromFavourite(
        movieId: movieId,
      );

      if (response["message"] == "Removed from favourite successfully") {
        emit(FavouriteRemoved());
      } else {
        emit(FavouriteError(response["message"]));
      }
    } catch (e) {
      emit(FavouriteError(e.toString()));
    }
  }
}
