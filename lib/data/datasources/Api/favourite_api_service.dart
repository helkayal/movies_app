import 'package:http/http.dart' as http;
import 'package:movies_app/core/services/common/common.dart';

class FavouriteApiService {
  final String token;

  FavouriteApiService({required this.token});

  final String _baseUrl = 'https://route-movie-apis.vercel.app';

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  Future<Map<String, dynamic>> fetchFavourites() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/favorites/all'),
      headers: _headers,
    );
    return handleResponse(response);
  }
}
