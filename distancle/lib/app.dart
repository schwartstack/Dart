import 'dart:math';

import 'package:flutter/material.dart';

import 'package:distancle/config/constants.dart';
import 'package:distancle/config/data.dart';
import 'package:distancle/widgets/game_board.dart';
import 'package:distancle/widgets/keyboard.dart';
import 'package:distancle/widgets/title_box.dart';

class GameState {
  bool playing = true;
  late String answer;
  String currentGuess = "";
  List<String> pastGuesses = [];

  GameState() {
    answer = _generateAnswer();
    currentGuess = currentGuess;
    pastGuesses = pastGuesses;
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
      setState(() {
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

  void _handleWin() {
    widget.gameState.playing = false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("You Win!"),
          content: Text(
            "Congratulations! You won in ${widget.gameState.pastGuesses.length} guess${widget.gameState.pastGuesses.length == 1 ? "" : "es"}.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Yay!"),
            ),
          ],
        );
      },
    );
  }

  void _handleLoss() {
    widget.gameState.playing = false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Game Over"),
          content: Text("The secret word was ${widget.gameState.answer}."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Bummer"),
            ),
          ],
        );
      },
    );
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
