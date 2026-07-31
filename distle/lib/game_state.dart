import 'dart:math';

import 'package:flutter/material.dart';

import 'package:distle/config/data.dart';
import 'package:distle/config/user_data.dart';

class GameState extends ChangeNotifier {
  late String answer;
  late bool darkMode = UserData.darkMode;
  late bool hardMode = UserData.hardMode;
  bool playing = true;
  String currentGuess = "";
  List<String> pastGuesses = [];
  String? infoBoxText;
  int invalidGuessCount = 1;

  void setDarkMode(bool value) {
    if (darkMode == value) return;
    UserData.darkMode = value;
    darkMode = UserData.darkMode;
    UserData.save();
    notifyListeners();
  }

  void setHardMode(bool value) {
    if (hardMode == value) return;
    UserData.hardMode = value;
    hardMode = UserData.hardMode;
    UserData.save();
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
