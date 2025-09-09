import 'package:movies_app/data/model/movie_details_model.dart';

abstract class HistoryRepository {
  Future<Map<String, dynamic>> getMovieById(String id);
  Future<List<Movie>> getHistoryMovies();
}
