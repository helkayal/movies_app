import 'package:movies_app/data/datasources/favourite/favourite_data_source.dart';
import 'package:movies_app/data/repositories/favourite/favourite_repository.dart';

class FavouriteRepositoryImpl implements FavouriteRepository {
  final FavouriteDataSource dataSource;

  FavouriteRepositoryImpl(this.dataSource);

  @override
  Future<Map<String, dynamic>> fetchFavourites() async {
    return await dataSource.fetchFavourites();
  }

  @override
  Future<Map<String, dynamic>> addFavourite({
    required String movieId,
    required String name,
    required double rating,
    required String imageURL,
    required String year,
  }) {
    return dataSource.addFavourite(
      movieId: movieId,
      name: name,
      rating: rating,
      imageURL: imageURL,
      year: year,
    );
  }

  @override
  Future<Map<String, dynamic>> isMovieFavourite({required String movieId}) {
    return dataSource.isMovieFavourite(movieId: movieId);
  }

  @override
  Future<Map<String, dynamic>> removeMovieFromFavourite({
    required String movieId,
  }) async {
    return dataSource.removeMovieFromFavourite(movieId: movieId);
  }
}
