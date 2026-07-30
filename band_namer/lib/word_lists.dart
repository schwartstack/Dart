import "dart:convert";
import "dart:math";
import "package:flutter/services.dart";

final _random = Random();

class WordLists {
  static late List<String> formulas;
  static late Map<String, List<String>> words;
  static late List<String> keywords;
  static late Set<String> allWords;

  static Future<void> load() async {
    final formulasText = await rootBundle.loadString(
      "assets/data/formulas.txt",
    );
    formulas = const LineSplitter().convert(formulasText);
    final String wordsText = await rootBundle.loadString(
      "assets/data/words.json",
    );
    final decoded = jsonDecode(wordsText) as Map<String, dynamic>;
    words = decoded.map(
      (key, value) => MapEntry(key, List<String>.from(value)),
    );
    keywords = words.keys.toList();
    allWords = {};
    for (String keyword in keywords) {
      allWords = allWords.union(words[keyword]!.toSet());
    }
  }
}

String randomElement(List<String> list) {
  var element = list[_random.nextInt(list.length)];
  return element;
}
