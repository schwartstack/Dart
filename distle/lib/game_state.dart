import 'package:flutter/material.dart';

import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart';

import 'package:distle/config/constants.dart';
import 'package:distle/config/data.dart';
import 'package:distle/config/user_data.dart';
import 'package:distle/helpers.dart';

enum GameResult { playing, won, lost }

class GameState extends ChangeNotifier {
  late GameResult gameResult = UserData.gameResult;
  late bool darkMode = UserData.darkMode;
  late bool hardMode = UserData.hardMode;
  late int puzzleNum;
  late String answer;
  late List<String> todaysGuesses;
  String currentGuess = "";
  String? infoBoxText;
  int invalidGuessCount = 1;

  GameState() {
    puzzleNum = _generatePuzzleNum();
    answer = _generateAnswer(puzzleNum);
    if (UserData.latestPuzzleWorkedOn != puzzleNum) {
      UserData.gameResult = GameResult.playing;
      UserData.latestPuzzleWorkedOn = puzzleNum;
      UserData.todaysGuesses = [];
      UserData.save();
    }
    todaysGuesses = UserData.todaysGuesses;
  }

  int _generatePuzzleNum() {
    initializeTimeZones();
    final PacificTimeLocation = getLocation("America/Los_Angeles");
    final TZDateTime dateInPacificTime = TZDateTime.now(PacificTimeLocation);

    final DateTime testDate = DateTime(2026, 8, 2);
    final duration = testDate.difference(startDate);

    // final duration = dateInPacificTime.difference(startDate);
    return duration.inDays;
  }

  String _generateAnswer(int puzzleNum) {
    return possibleAnswers[puzzleNum];
  }

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

  void handleKeyPress(String letter) {
    if (gameResult == GameResult.playing && currentGuess.length < 5) {
      currentGuess += letter;
      notifyListeners();
    }
  }

  void handleEnterPress() {
    if (gameResult == GameResult.playing && currentGuess.length == 5) {
      if (allowableGuesses.contains(currentGuess)) {
        handleValidGuess();
      } else {
        handleInvalidGuess();
      }
    }
  }

  void handleValidGuess() {
    final String totalDistance = calculateDistance(
      currentGuess,
      answer,
    )!.toStringAsFixed(2);
    infoBoxText = "Total distance of last guess: $totalDistance key widths";
    UserData.todaysGuesses.add(currentGuess);
    todaysGuesses = UserData.todaysGuesses;
    currentGuess = "";
    UserData.save();
    notifyListeners();
    if (todaysGuesses.last == answer) {
      handleWin();
    } else {
      if (todaysGuesses.length == numRows) {
        handleLoss();
      }
    }
  }

  void handleInvalidGuess() {
    invalidGuessCount++;
    infoBoxText = "Word not found in dictionary";
    notifyListeners();
  }

  void handleWin() {
    UserData.gameResult = GameResult.won;
    gameResult = UserData.gameResult;
    UserData.save();
    notifyListeners();
  }

  void handleLoss() {
    UserData.gameResult = GameResult.lost;
    gameResult = UserData.gameResult;
    UserData.save();
    notifyListeners();
  }

  void handleDeletePress() {
    if (gameResult == GameResult.playing && currentGuess.isNotEmpty) {
      currentGuess = currentGuess.substring(0, currentGuess.length - 1);
    }
    notifyListeners();
  }
}
