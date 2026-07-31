import 'dart:math';

import 'package:flutter/material.dart';

import 'package:distle/config/data.dart';

class GameState extends ChangeNotifier {
  late String answer;
  bool playing = true;
  String currentGuess = "";
  List<String> pastGuesses = [];
  String? infoBoxText;
  int invalidGuessCount = 1;
  bool darkMode = true;
  bool hardMode = false;

  void setDarkMode(bool value) {
    if (darkMode == value) return;
    darkMode = value;
    notifyListeners();
  }

  void setHardMode(bool value) {
    if (hardMode == value) return;
    hardMode = value;
    notifyListeners();
  }

  GameState() {
    answer = _generateAnswer();
    currentGuess = currentGuess;
    pastGuesses = pastGuesses;
    infoBoxText = infoBoxText;
    invalidGuessCount = invalidGuessCount;
    darkMode = darkMode;
    hardMode = hardMode;
  }

  String _generateAnswer() {
    final random = Random();
    int randomIndex = random.nextInt(possibleAnswers.length);
    return possibleAnswers[randomIndex];
  }
}
