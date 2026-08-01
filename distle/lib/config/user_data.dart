import "dart:convert";

import "package:distle/game_state.dart";
import "package:shared_preferences/shared_preferences.dart";

class UserData {
  static late int? latestPuzzleWorkedOn;
  static late bool darkMode;
  static late bool hardMode;
  static late GameResult gameResult;
  static late List<String> todaysGuesses;
  static late Map<int, int> gameHistory;

  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    latestPuzzleWorkedOn = prefs.getInt("latestPuzzleWorkedOn");
    darkMode = prefs.getBool("darkMode") ?? false;
    hardMode = prefs.getBool("hardMode") ?? false;
    final resultName = prefs.getString("gameResult");
    gameResult = GameResult.values.firstWhere(
      (e) => e.name == resultName,
      orElse: () => GameResult.playing,
    );
    todaysGuesses = prefs.getStringList("todaysGuesses") ?? [];
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
    await prefs.setInt("latestPuzzleWorkedOn", latestPuzzleWorkedOn!);
    await prefs.setBool("darkMode", darkMode);
    await prefs.setBool("hardMode", hardMode);
    await prefs.setString("gameResult", gameResult.name);
    await prefs.setStringList("todaysGuesses", todaysGuesses);
    final json = jsonEncode(
      gameHistory.map((k, v) => MapEntry(k.toString(), v)),
    );
    await prefs.setString("gameHistory", json);
  }
}
