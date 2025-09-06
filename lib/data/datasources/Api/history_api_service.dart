import 'package:http/http.dart' as http;
import 'package:movies_app/core/services/common/common.dart';

class HistoryApiService {
  HistoryApiService();

  Future<Map<String, dynamic>> getMovieById(String id) async {
    final response = await http.get(
      Uri.parse('https://yts.mx/api/v2/movie_details.json?movie_id=$id'),
    );
    return handleResponse(response);
  }
}
