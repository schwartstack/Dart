import "package:shared_preferences/shared_preferences.dart";

class UserData {
  static late List<String> favorites;

  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    favorites = prefs.getStringList("favorites") ?? <String>[];
  }

  static Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("favorites", favorites);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    favorites.clear();
    save();
  }
}
