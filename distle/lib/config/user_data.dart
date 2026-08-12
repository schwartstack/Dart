import "package:distle/game_state.dart";
import "package:shared_preferences/shared_preferences.dart";

class UserData {
  static late int? latestPuzzlePlayed;
  static late int? latestCompletedPuzzle;
  static late int potentialNextStreak;
  static late bool darkMode;
  static late bool hardMode;
  static late List<String> todaysGuesses;
  static late List<String> gameHistory;
  static late int currentStreak;
  static late int longestStreak;
  static late GameResult gameResult;

  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    latestPuzzlePlayed = prefs.getInt("latestPuzzlePlayed");
    latestCompletedPuzzle = prefs.getInt("latestCompletedPuzzle");
    darkMode = prefs.getBool("darkMode") ?? false;
    hardMode = prefs.getBool("hardMode") ?? false;
    todaysGuesses = prefs.getStringList("todaysGuesses") ?? [];
    gameHistory = prefs.getStringList("gameHistory") ?? [];
    final resultName = prefs.getString("gameResult");
    currentStreak = prefs.getInt("currentStreak") ?? 0;
    potentialNextStreak = prefs.getInt("potentialNextStreak") ?? 1;
    longestStreak = prefs.getInt("longestStreak") ?? 0;
    gameResult = GameResult.values.firstWhere(
      (e) => e.name == resultName,
      orElse: () => GameResult.playing,
    );
  }

  static Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    if (latestPuzzlePlayed != null) {
      await prefs.setInt("latestPuzzlePlayed", latestPuzzlePlayed!);
    }
    if (latestCompletedPuzzle != null) {
      await prefs.setInt("latestCompletedPuzzle", latestCompletedPuzzle!);
    }
    await prefs.setBool("darkMode", darkMode);
    await prefs.setBool("hardMode", hardMode);
    await prefs.setStringList("todaysGuesses", todaysGuesses);
    await prefs.setStringList("gameHistory", gameHistory);
    await prefs.setInt("currentStreak", currentStreak);
    await prefs.setInt("potentialNextStreak", potentialNextStreak);
    await prefs.setInt("longestStreak", longestStreak);
    await prefs.setString("gameResult", gameResult.name);
  }
}
