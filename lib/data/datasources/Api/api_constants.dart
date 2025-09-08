class ApiConstants {
  //https:yts.mx/api/v2/list_movies.json?quality=3D
  //'https://yts.mx/api/v2/movie_details.json?movie_id=$movieId'
  static const String baseUrl = 'https://yts.mx/api/v2';
  static const String dioClientBaseUrl = "https://route-movie-apis.vercel.app/";
//Endpoints
  static const movie = '/list_movies.json';
  static const movieDetails = '/movie_details.json';
  static const movieSuggestions = '/movie_suggestions.json';

  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String forgetPassword = "auth/forgot-password";
  static const String resetpassword = "auth/reset-password";
}