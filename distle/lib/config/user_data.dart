import "dart:convert";

import "package:shared_preferences/shared_preferences.dart";

class UserData {
  static late bool darkMode;
  static late bool hardMode;
  static late Map<int, int> gameHistory;

  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    darkMode = prefs.getBool("darkMode") ?? false;
    hardMode = prefs.getBool("hardMode") ?? false;
    final json = prefs.getString("gameHistory");
    if (json == null) {
      gameHistory = {};
    } else {
      final decoded = jsonDecode(json) as Map<String, dynamic>;
      gameHistory = decoded.map((k, v) => MapEntry(int.parse(k), v as int));
    }
  }

  static Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("darkMode", darkMode);
    await prefs.setBool("hardMode", hardMode);
    final json = jsonEncode(
      gameHistory.map((k, v) => MapEntry(k.toString(), v)),
    );
    await prefs.setString("gameHistory", json);
  }
}
