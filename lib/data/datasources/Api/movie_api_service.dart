import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/data/datasources/Api/api_constants.dart';
import 'package:movies_app/data/model/movie_details_model.dart';
import 'package:movies_app/data/model/list_movies_model.dart';

class ApiService {
  //Get All movies
  static Future<ListMoviesModel> getMovies() async {
    try {
      var response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.movie}'),
      );
      var json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        ListMoviesModel myResponse = ListMoviesModel.fromJson(json);
        return myResponse;
      } else {
        throw Exception('Failed to recieve data: ${response.statusCode}');
      }
    } on Exception catch (e) {
      if (e.toString().contains('ClientException')) {
        throw 'Failed to connect';
      }
      throw Exception('catch error: ${e.toString()}');
    }
  }

  //get movie details
  static Future<MovieDetailsModel> getMovieDetails({required int movieId,}) async {
    try {
      var response = await http.get(
        Uri.parse(
          '${ApiConstants.baseUrl}${ApiConstants.movieDetails}?movie_id=$movieId&with_cast=true&with_images=true',
        ),
      );
      print(
        '🌐 Request URL: ${ApiConstants.baseUrl}${ApiConstants.movieDetails}?movie_id=$movieId',
      );
      // نظهر الـ response عشان نشوف المشكلة
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      // نتأكد أن الـ response مش فاضي
      if (response.body.isEmpty) {
        throw Exception('Empty response from server');
      }
      var json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final MovieDetailsModel myResponse = MovieDetailsModel.fromJson(json);
        if (myResponse.data?.movie != null) {
          return myResponse;
        } else {
          throw Exception('movie details can not be found');
        }
      } else {
        throw Exception('Failed to recieve data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('catch erro: ${e.toString()}');
    }
  }
}
