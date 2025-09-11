// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:movies_app/data/datasources/Api/api_constants.dart';
// import 'package:movies_app/data/model/movie_details_model.dart';

// class ApiService {
//   //Get All movies
//   static Future<MovieDataModel> getMovies({
//     int limit = 50,
//     int page = 1,
//     String sortedBy = 'rating',
//   }) async {
//     try {
//       var response = await http.get(
//         Uri.parse(
//           '${ApiConstants.baseUrl}${ApiConstants.movie}?limit=$limit&sort_by=$sortedBy&page=$page',
//         ),
//       );
//       var json = jsonDecode(response.body);
//       if (response.statusCode == 200) {
//         MovieDataModel myResponse = MovieDataModel.fromJson(json);
//         return myResponse;
//       } else {
//         throw Exception('Failed to recieve data: ${response.statusCode}');
//       }
//     } on Exception catch (e) {
//       if (e.toString().contains('ClientException')) {
//         throw 'Failed to connect';
//       }
//       throw Exception('catch error: ${e.toString()}');
//     }
//   }

//   //get movie details
//   static Future<MovieDataModel> getMovieDetails({
//     required int movieId,
//   }) async {
//     try {
//       var response = await http.get(
//         Uri.parse(
//           '${ApiConstants.baseUrl}${ApiConstants.movieDetails}?movie_id=$movieId&with_cast=true&with_images=true',
//         ),
//       );
//       if (response.body.isEmpty) {
//         throw Exception('Empty response from server');
//       }
//       var json = jsonDecode(response.body);
//       if (response.statusCode == 200) {
//         final MovieDataModel myResponse = MovieDataModel.fromJson(json);
//         if (myResponse.data?.movie != null) {
//           return myResponse;
//         } else {
//           throw Exception('movie details can not be found');
//         }
//       } else {
//         throw Exception('Failed to recieve data: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('catch erro: ${e.toString()}');
//     }
//   }

//   //get movie suggestions
//   static Future<MovieDataModel> getMovieSuggestions({
//     required int movieId,
//   }) async {
//     try {
//       var response = await http.get(
//         Uri.parse(
//           '${ApiConstants.baseUrl}${ApiConstants.movieSuggestions}?movie_id=$movieId',
//         ),
//       );
//       if (response.body.isEmpty) {
//         throw Exception('Empty response from server');
//       }
//       var json = jsonDecode(response.body);
//       if (response.statusCode == 200) {
//         final MovieDataModel myResponse = MovieDataModel.fromJson(json);
//         if (myResponse.data?.movies != null) {
//           return myResponse;
//         } else {
//           throw Exception('movie details can not be found');
//         }
//       } else {
//         throw Exception('Failed to recieve data: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('catch erro: ${e.toString()}');
//     }
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/data/datasources/Api/api_constants.dart';
import 'package:movies_app/data/model/movie_data_model.dart';

class ApiService {
  // Get all movies (unchanged)
  static Future<MovieDataModel> getMovies({
    int limit = 100,
    int page = 1,
    String sortedBy = 'rating',
  }) async {
    try {
      var response = await http.get(
        Uri.parse(
          '${ApiConstants.baseUrl}${ApiConstants.movie}?limit=$limit&sort_by=$sortedBy&page=$page',
        ),
      );
      var json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        MovieDataModel myResponse = MovieDataModel.fromJson(json);
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

  // ✅ Get movie details (returns Movie)
  static Future<Movie> getMovieDetails({required int movieId}) async {
    try {
      var response = await http.get(
        Uri.parse(
          '${ApiConstants.baseUrl}${ApiConstants.movieDetails}?movie_id=$movieId&with_cast=true&with_images=true',
        ),
      );

      if (response.body.isEmpty) {
        throw Exception('Empty response from server');
      }

      var json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final MovieDataModel myResponse = MovieDataModel.fromJson(json);

        if (myResponse.data?.movie != null) {
          return myResponse.data!.movie!; // ✅ return Movie
        } else {
          throw Exception('Movie details not found');
        }
      } else {
        throw Exception('Failed to recieve data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('catch error: ${e.toString()}');
    }
  }

  // ✅ Get movie suggestions (returns List<Movie>)
  static Future<List<Movie>> getMovieSuggestions({required int movieId}) async {
    try {
      var response = await http.get(
        Uri.parse(
          '${ApiConstants.baseUrl}${ApiConstants.movieSuggestions}?movie_id=$movieId',
        ),
      );

      if (response.body.isEmpty) {
        throw Exception('Empty response from server');
      }

      var json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final MovieDataModel myResponse = MovieDataModel.fromJson(json);

        if (myResponse.data?.movies != null) {
          return myResponse.data!.movies!; // ✅ return List<Movie>
        } else {
          throw Exception('Movie suggestions not found');
        }
      } else {
        throw Exception('Failed to recieve data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('catch error: ${e.toString()}');
    }
  }
}
