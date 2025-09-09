import 'package:movies_app/data/datasources/Api/favourite_api_service.dart';
import 'package:movies_app/data/datasources/favourite/favourite_data_source.dart';

class FavouriteDataSourceImpl extends FavouriteDataSource {
  final FavouriteApiService apiService;

  FavouriteDataSourceImpl(this.apiService);

  @override
  Future<Map<String, dynamic>> fetchFavourites() async {
    return await apiService.fetchFavourites();
  }

  @override
  Future<Map<String, dynamic>> addFavourite({
    required String movieId,
    required String name,
    required double rating,
    required String imageURL,
    required String year,
  }) {
    return apiService.addFavourite({
      "movieId": movieId,
      "name": name,
      "rating": rating,
      "imageURL": imageURL,
      "year": year,
    });
  }

  @override
  Future<Map<String, dynamic>> isMovieFavourite({required String movieId}) {
    return apiService.isMovieFavourite(movieId: movieId);
  }

  @override
  Future<Map<String, dynamic>> removeMovieFromFavourite({
    required String movieId,
  }) async {
    return apiService.removeMovieFromFavourite(movieId: movieId);
  }
}
