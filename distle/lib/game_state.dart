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
  late List<String> gameHistory = UserData.gameHistory;
  late int currentStreak = UserData.currentStreak;
  late int longestStreak = UserData.longestStreak;
  late int puzzleNum;
  late String answer;
  late List<String> todaysGuesses;
  late int potentialNextStreak;
  String currentGuess = "";
  int invalidGuessCount = 1;
  String? infoBoxText;

  GameState() {
    puzzleNum = _generatePuzzleNum();
    answer = _generateAnswer(puzzleNum);

    final lastPlayed = UserData.latestPuzzlePlayed;
    final lastCompleted = UserData.latestCompletedPuzzle;

    if (lastCompleted != null &&
        lastCompleted + 1 == puzzleNum &&
        lastPlayed != puzzleNum) {
      potentialNextStreak = currentStreak + 1;
    } else {
      potentialNextStreak = 1;
    }

    if (lastPlayed != puzzleNum) {
      UserData.latestPuzzlePlayed = puzzleNum;
      UserData.gameResult = GameResult.playing;
      UserData.todaysGuesses = [];
      UserData.save();
    }

    gameResult = UserData.gameResult;
    todaysGuesses = UserData.todaysGuesses;
  }

  int _generatePuzzleNum() {
    initializeTimeZones();
    final PacificTimeLocation = getLocation("America/Los_Angeles");
    final TZDateTime dateInPacificTime = TZDateTime.now(PacificTimeLocation);

    // final DateTime testDate = DateTime(2026, 8, 25);
    // final duration = testDate.difference(startDate);

    final duration = dateInPacificTime.difference(startDate);
    return duration.inDays;
  }

  String _generateAnswer(int puzzleNum) {
    return possibleAnswers[puzzleNum % possibleAnswers.length];
  }

  void setDarkMode(bool value) {
    if (darkMode == value) return;

    UserData.darkMode = value;
    UserData.save();

    darkMode = UserData.darkMode;
    notifyListeners();
  }

  void setHardMode(bool value) {
    if (hardMode == value) return;

    UserData.hardMode = value;
    UserData.save();

    hardMode = UserData.hardMode;
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
    if (todaysGuesses.length == 1) {
      UserData.currentStreak = 0;
      UserData.gameHistory.add("X");
      currentStreak = UserData.currentStreak;
      gameHistory = UserData.gameHistory;
    }
    UserData.save();
    currentGuess = "";
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
    switch (todaysGuesses.length) {
      case 1:
        infoBoxText = "Nostradamus!";
      case 2:
        infoBoxText = "Incredible!";
      case 3:
        infoBoxText = "Amazing!";
      case 4:
        infoBoxText = "Very nice!";
      case 5:
        infoBoxText = "Well done!";
      case 6:
        infoBoxText = "Phew!";
    }

    UserData.gameResult = GameResult.won;
    UserData.latestCompletedPuzzle = puzzleNum;

    UserData.currentStreak = potentialNextStreak;

    if (UserData.currentStreak > UserData.longestStreak) {
      UserData.longestStreak = UserData.currentStreak;
    }

    UserData.gameHistory.removeLast();
    UserData.gameHistory.add("${todaysGuesses.length}");

    UserData.save();

    gameResult = UserData.gameResult;
    currentStreak = UserData.currentStreak;
    longestStreak = UserData.longestStreak;
    gameHistory = UserData.gameHistory;

    notifyListeners();
  }

  void handleLoss() {
    UserData.gameResult = GameResult.lost;
    UserData.latestCompletedPuzzle = puzzleNum;

    UserData.save();

    gameResult = UserData.gameResult;
    notifyListeners();
  }

  void handleDeletePress() {
    if (gameResult == GameResult.playing && currentGuess.isNotEmpty) {
      currentGuess = currentGuess.substring(0, currentGuess.length - 1);
    }
    notifyListeners();
  }

  int getAttempts() {
    if (gameResult == GameResult.playing) {
      if (todaysGuesses.isEmpty) {
        return gameHistory.length;
      } else {
        return gameHistory.length - 1;
      }
    } else {
      return gameHistory.length;
    }
  }

  int getWins() {
    int wins = 0;
    for (int i = 0; i < gameHistory.length; i++) {
      if (gameHistory[i] != "X") {
        wins++;
      }
    }
    return wins;
  }

  String getWinPercentage() {
    double attempts = getAttempts() as double;
    if (attempts == 0) {
      return "0%";
    }
    double wins = getWins() as double;
    double winProportion = wins / attempts;
    return "${(winProportion * 100).toStringAsFixed(2)}%";
  }
}
