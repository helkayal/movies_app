abstract class HistoryDataSource {
  Future<Map<String, dynamic>> getMovieById(String id);
  Future<List<int>> getMovieIds();
}
