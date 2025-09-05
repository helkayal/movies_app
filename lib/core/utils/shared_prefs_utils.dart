import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsUtils {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Save string
  static Future<void> saveString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  /// Get string
  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  /// Save bool
  static Future<void> saveBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  /// Get bool
  static bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  /// Save int
  static Future<void> saveInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  /// Get int
  static int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  /// Save double
  static Future<void> saveDouble(String key, double value) async {
    await _prefs?.setDouble(key, value);
  }

  /// Get double
  static double? getDouble(String key) {
    return _prefs?.getDouble(key);
  }

  /// Save list of strings
  static Future<void> saveStringList(String key, List<String> value) async {
    await _prefs?.setStringList(key, value);
  }

  /// Get list of strings
  static List<String>? getStringList(String key) {
    return _prefs?.getStringList(key);
  }

  /// Delete a key
  static Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  /// Clear all saved data
  static Future<void> clear() async {
    await _prefs?.clear();
  }
}
