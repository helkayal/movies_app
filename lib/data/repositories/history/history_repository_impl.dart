import 'package:movies_app/data/datasources/history/history_datasource.dart';
import 'package:movies_app/data/model/movie_details_model.dart';
import 'package:movies_app/data/repositories/history/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryDataSource dataSource;
  HistoryRepositoryImpl(this.dataSource);

  @override
  Future<Map<String, dynamic>> getMovieById(String id) {
    return dataSource.getMovieById(id);
  }

  @override
  Future<List<Movie>> getHistoryMovies() async {
    // final ids = await dataSource.getMovieIds();
    final ids = [10, 333, 8473, 99];
    List<Movie> movies = [];

    for (final id in ids) {
      final response = await dataSource.getMovieById(id.toString());
      final movieJson = response["data"]["movie"];
      movies.add(Movie.fromJson(movieJson));
    }

    return movies;
  }
}
