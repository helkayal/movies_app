// import 'package:movies_app/core/utils/shared_prefs_utils.dart';
// import 'package:movies_app/data/datasources/Api/history_api_service.dart';
// import 'package:movies_app/data/datasources/history/history_datasource.dart';

// class HistoryDataSourceImpl implements HistoryDataSource {
//   final HistoryApiService apiService;

//   HistoryDataSourceImpl(this.apiService);

//   @override
//   Future<Map<String, dynamic>> getMovieById(String id) async {
//     return apiService.getMovieById(id);
//   }

//   @override
//   Future<List<int>> getMovieIds() async {
//     final history = SharedPrefsUtils.getString("history");
//     if (history == null || history.isEmpty) {
//       return [];
//     }
//     return history.split(",").map((e) => int.parse(e)).toList();
//   }
// }
import 'package:movies_app/data/datasources/history/history_service.dart';
import 'package:movies_app/data/model/movie_data_model.dart';
import 'history_datasource.dart';

class HistoryDataSourceImpl implements HistoryDataSource {
  @override
  Future<List<Movie>> getHistoryMovies() async {
    return await HistoryService.getHistory();
  }

  @override
  Future<void> addMovie(Movie movie) async {
    await HistoryService.addToHistory(movie);
  }

  @override
  Future<void> clearHistory() async {
    await HistoryService.clearHistory();
  }
}
