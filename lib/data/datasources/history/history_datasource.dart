import 'package:movies_app/data/model/movie_details_model.dart';

abstract class HistoryDataSource {
  Future<List<Movie>> getHistoryMovies();
  Future<void> addMovie(Movie movie);
  Future<void> clearHistory();
}
