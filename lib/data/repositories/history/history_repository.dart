import 'package:movies_app/data/model/movie_dm.dart';

abstract class HistoryRepository {
  Future<Map<String, dynamic>> getMovieById(String id);
  Future<List<Movies>> getHistoryMovies();
}
