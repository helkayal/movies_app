import 'package:movies_app/data/model/list_movies_model.dart';

abstract class HistoryRepository {
  Future<Map<String, dynamic>> getMovieById(String id);
  Future<List<Movies>> getHistoryMovies();
}
