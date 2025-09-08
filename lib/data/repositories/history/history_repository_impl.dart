import 'package:movies_app/data/datasources/history/history_datasource.dart';
import 'package:movies_app/data/model/list_movies_model.dart';
import 'package:movies_app/data/repositories/history/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryDataSource dataSource;
  HistoryRepositoryImpl(this.dataSource);

  @override
  Future<Map<String, dynamic>> getMovieById(String id) {
    return dataSource.getMovieById(id);
  }

  @override
  Future<List<Movies>> getHistoryMovies() async {
    // final ids = await dataSource.getMovieIds();
    final ids = [10, 333, 8473, 99];
    List<Movies> movies = [];

    for (final id in ids) {
      final response = await dataSource.getMovieById(id.toString());
      final movieJson = response["data"]["movie"];
      movies.add(Movies.fromJson(movieJson));
    }

    return movies;
  }
}
