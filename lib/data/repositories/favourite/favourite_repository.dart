abstract class FavouriteRepository {
  Future<Map<String, dynamic>> fetchFavourites();
  Future<Map<String, dynamic>> addFavourite({
    required String movieId,
    required String name,
    required double rating,
    required String imageURL,
    required String year,
  });
  Future<Map<String, dynamic>> isMovieFavourite({required String movieId});
  Future<Map<String, dynamic>> removeMovieFromFavourite({
    required String movieId,
  });
}
