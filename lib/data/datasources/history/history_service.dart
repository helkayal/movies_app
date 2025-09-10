import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movies_app/data/model/movie_details_model.dart'; // <-- your Movie class

class HistoryService {
  static const String _key = 'movie_history';

  static Future<void> addToHistory(Movie movie) async {
    final prefs = await SharedPreferences.getInstance();
    final String email = prefs.getString('email') ?? '';
    final String? existing = prefs.getString("${_key}_$email");
    List<Map<String, dynamic>> historyList = [];

    if (existing != null) {
      historyList = List<Map<String, dynamic>>.from(
        jsonDecode(existing) as List,
      );
    }

    // Remove if already exists
    historyList.removeWhere((item) => item['id'] == movie.id);

    // Insert at top
    historyList.insert(0, movie.toHistoryMap());

    // Keep max 20
    if (historyList.length > 20) {
      historyList = historyList.sublist(0, 20);
    }

    await prefs.setString("${_key}_$email", jsonEncode(historyList));
  }

  static Future<List<Movie>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String email = prefs.getString('email') ?? '';
    final String? data = prefs.getString("${_key}_$email");
    if (data == null) return [];

    final List<dynamic> decoded = jsonDecode(data);
    return decoded.map((map) => Movie.fromHistoryMap(map)).toList();
  }

  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String email = prefs.getString('email') ?? '';
    await prefs.remove("${_key}_$email");
  }
}
