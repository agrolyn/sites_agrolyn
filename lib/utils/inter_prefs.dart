import 'package:shared_preferences/shared_preferences.dart';

class InterPrefs {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String getPrefs(String key) => _prefs.getString(key) ?? '';

  static void setPrefs(String key, String value) =>
      _prefs.setString(key, value);
}
