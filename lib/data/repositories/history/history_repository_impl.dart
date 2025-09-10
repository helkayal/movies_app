import 'package:movies_app/data/datasources/history/history_datasource.dart';
import 'package:movies_app/data/model/movie_data_model.dart';
import 'package:movies_app/data/repositories/history/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryDataSource dataSource;
  HistoryRepositoryImpl(this.dataSource);

  @override
  Future<void> addMovie(Movie movie) {
    return dataSource.addMovie(movie);
  }

  @override
  Future<void> clearHistory() {
    return dataSource.clearHistory();
  }

  @override
  Future<List<Movie>> getHistoryMovies() {
    return dataSource.getHistoryMovies();
  }
}
