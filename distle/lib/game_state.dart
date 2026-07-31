import 'package:distle/config/constants.dart';
import 'package:flutter/material.dart';

import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart';

import 'package:distle/config/data.dart';
import 'package:distle/config/user_data.dart';

class GameState extends ChangeNotifier {
  late int puzzleNum;
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
    puzzleNum = _generatePuzzleNum();
    answer = _generateAnswer(puzzleNum);
    currentGuess = currentGuess;
    pastGuesses = pastGuesses;
    infoBoxText = infoBoxText;
    invalidGuessCount = invalidGuessCount;
    darkMode = darkMode;
    hardMode = hardMode;
  }

  int _generatePuzzleNum() {
    initializeTimeZones();
    final PacificTimeLocation = getLocation("America/Los_Angeles");
    final TZDateTime dateInPacificTime = TZDateTime.now(PacificTimeLocation);
    final duration = dateInPacificTime.difference(startDate);
    return duration.inDays;
  }

  String _generateAnswer(int puzzleNum) {
    return possibleAnswers[puzzleNum];
  }
}
