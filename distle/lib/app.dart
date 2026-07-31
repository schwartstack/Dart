import 'dart:math';

import 'package:flutter/material.dart';

import 'package:distle/config/constants.dart';
import 'package:distle/config/data.dart';
import 'package:distle/helpers.dart';
import 'package:distle/widgets/boxes/game_board.dart';
import 'package:distle/widgets/boxes/info_box.dart';
import 'package:distle/widgets/boxes/keyboard.dart';
import 'package:distle/widgets/boxes/title_box.dart';
import 'package:distle/widgets/buttons/results_button.dart';
import 'package:distle/widgets/popups/loss_popup.dart';
import 'package:distle/widgets/popups/win_popup.dart';

class GameState {
  late String answer;
  bool playing = true;
  String currentGuess = "";
  List<String> pastGuesses = [];
  String? infoBoxText;
  int invalidGuessCount = 1;

  GameState() {
    answer = _generateAnswer();
    currentGuess = currentGuess;
    pastGuesses = pastGuesses;
    infoBoxText = infoBoxText;
    invalidGuessCount = invalidGuessCount;
  }

  void reset() {
    answer = _generateAnswer();
    playing = true;
    currentGuess = "";
    pastGuesses.clear();
    infoBoxText = null;
    invalidGuessCount = 1;
  }

  String _generateAnswer() {
    final random = Random();
    int randomIndex = random.nextInt(possibleAnswers.length);
    return possibleAnswers[randomIndex];
  }
}

class MyApp extends StatelessWidget {
  final GameState gameState;
  const MyApp({super.key, required this.gameState});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(gameState: gameState),
    );
  }
}

class HomePage extends StatefulWidget {
  final GameState gameState;
  const HomePage({super.key, required this.gameState});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _handleKeyPress(String letter) {
    if (widget.gameState.playing && widget.gameState.currentGuess.length < 5) {
      setState(() {
        widget.gameState.currentGuess += letter;
      });
    }
  }

  void _handleEnterPressed() {
    if (widget.gameState.playing && widget.gameState.currentGuess.length == 5) {
      if (allowableGuesses.contains(widget.gameState.currentGuess)) {
        _handleValidGuess();
      } else {
        _handleInvalidGuess();
      }
    }
  }

  void _handleValidGuess() {
    final String totalDistance = calculateDistance(
      widget.gameState.currentGuess,
      widget.gameState.answer,
    ).toStringAsFixed(2);
    setState(() {
      widget.gameState.infoBoxText =
          "Total distance of last guess: $totalDistance key widths";
      widget.gameState.pastGuesses.add(widget.gameState.currentGuess);
      widget.gameState.currentGuess = "";
    });
    if (widget.gameState.pastGuesses.last == widget.gameState.answer) {
      _handleWin();
    } else {
      if (widget.gameState.pastGuesses.length == numRows) {
        _handleLoss();
      }
    }
  }

  void _handleInvalidGuess() {
    setState(() {
      widget.gameState.invalidGuessCount++;
      widget.gameState.infoBoxText = "Word not found in dictionary";
    });
  }

  void _handleWin() {
    widget.gameState.playing = false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WinPopup(
          answer: widget.gameState.answer,
          guesses: widget.gameState.pastGuesses,
        );
      },
    );
  }

  void _handleLoss() {
    widget.gameState.playing = false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LossPopup(
          answer: widget.gameState.answer,
          guesses: widget.gameState.pastGuesses,
        );
      },
    );
  }

  void _handleDeletePressed() {
    if (widget.gameState.playing && widget.gameState.currentGuess.isNotEmpty) {
      setState(() {
        widget.gameState.currentGuess = widget.gameState.currentGuess.substring(
          0,
          widget.gameState.currentGuess.length - 1,
        );
      });
    }
  }

  Widget _buildLetterBoxRow(int rowNumber) {
    if (widget.gameState.pastGuesses.length > rowNumber) {
      return LetterBoxRow(
        guess: widget.gameState.pastGuesses[rowNumber],
        answer: widget.gameState.answer,
        isSubmitted: true,
      );
    }
    if (widget.gameState.pastGuesses.length == rowNumber) {
      return LetterBoxRow(
        guess: widget.gameState.currentGuess,
        answer: widget.gameState.answer,
        isSubmitted: false,
      );
    }
    return LetterBoxRow(
      guess: "",
      answer: widget.gameState.answer,
      isSubmitted: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  TitleBox(),
                  for (int i = 0; i < numRows; i++) ...[
                    const SizedBox(height: 5),
                    _buildLetterBoxRow(i),
                  ],
                  widget.gameState.playing
                      ? InfoBox(
                          info: widget.gameState.infoBoxText,
                          shakeId: widget.gameState.invalidGuessCount,
                        )
                      : ResultsButton(
                          answer: widget.gameState.answer,
                          guesses: widget.gameState.pastGuesses,
                        ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Keyboard(
                onKeyPressed: _handleKeyPress,
                onEnterPressed: _handleEnterPressed,
                onDeletePressed: _handleDeletePressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
