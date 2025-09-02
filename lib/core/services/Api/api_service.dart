import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/core/services/Api/api_constants.dart';
import 'package:movies_app/model/movie_dm.dart';

class ApiService {
  static Future<MovieDataModel> getMovies() async {
    try {
      // Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.movie);
      var response = await http.get(Uri.parse('https://yts.mx/api/v2/list_movies.json'));
      var json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        MovieDataModel myResponse = MovieDataModel.fromJson(json);
        return myResponse;
      } else {
        throw Exception('Failed to load movies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('catch error: ${e.toString()}');
    }
  }
}
