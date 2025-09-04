class FavouriteMovieDataModel {
  final String movieId;
  final String name;
  final double rating;
  final String imageURL;
  final String year;

  FavouriteMovieDataModel({
    required this.movieId,
    required this.name,
    required this.rating,
    required this.imageURL,
    required this.year,
  });

  factory FavouriteMovieDataModel.fromJson(Map<String, dynamic> json) {
    return FavouriteMovieDataModel(
      movieId: json['movieId'] ?? '',
      name: json['name'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      imageURL: json['imageURL'] ?? '',
      year: json['year'] ?? '',
    );
  }
}
