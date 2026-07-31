import "package:shared_preferences/shared_preferences.dart";

class UserData {
  static late bool darkMode;
  static late bool hardMode;

  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    darkMode = prefs.getBool("darkMode") ?? false;
    hardMode = prefs.getBool("hardMode") ?? false;
  }

  static Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("darkMode", darkMode);
    await prefs.setBool("hardMode", hardMode);
  }
}
