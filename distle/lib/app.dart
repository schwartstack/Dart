import 'package:flutter/material.dart';
import 'dart:math';

import 'package:distle/config/constants.dart';
import 'package:distle/game_state.dart';
import 'package:distle/widgets/boxes/game_board.dart';
import 'package:distle/widgets/boxes/info_box.dart';
import 'package:distle/widgets/boxes/keyboard.dart';
import 'package:distle/widgets/boxes/title_box.dart';
import 'package:distle/widgets/boxes/timer_box.dart';
import 'package:distle/widgets/buttons/help_button.dart';
import 'package:distle/widgets/buttons/info_button.dart';
import 'package:distle/widgets/buttons/results_button.dart';
import 'package:distle/widgets/buttons/settings_button.dart';
import 'package:distle/widgets/buttons/stats_button.dart';
import 'package:distle/widgets/popups/help_popup.dart';
import 'package:distle/widgets/popups/loss_popup.dart';
import 'package:distle/widgets/popups/win_popup.dart';

class MyApp extends StatelessWidget {
  final GameState gameState;

  const MyApp({super.key, required this.gameState});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: gameState,
      builder: (context, child) {
        return MaterialApp(
          title: title,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.teal,
              brightness: Brightness.dark,
            ),
          ),
          themeMode: gameState.darkMode ? ThemeMode.dark : ThemeMode.light,
          home: HomePageScreen(gameState: gameState),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  final GameState gameState;
  const HomePage({super.key, required this.gameState});

  Widget _buildLetterBoxRow(double size, int rowNumber) {
    if (gameState.todaysGuesses.length > rowNumber) {
      return LetterBoxRow(
        size: size,
        guess: gameState.todaysGuesses[rowNumber],
        answer: gameState.answer,
        isSubmitted: true,
      );
    }
    if (gameState.todaysGuesses.length == rowNumber) {
      return LetterBoxRow(
        size: size,
        guess: gameState.currentGuess,
        answer: gameState.answer,
        isSubmitted: false,
      );
    }
    return LetterBoxRow(
      size: size,
      guess: "",
      answer: gameState.answer,
      isSubmitted: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double titleHeight = constraints.maxHeight / 12;
          final double letterBoxSize = constraints.maxHeight / 11;
          final double maxLetterBoxSize = constraints.maxWidth / 5;
          final double infoBoxHeight = constraints.maxHeight * 1 / 28;
          final double resultsButtonHeight = constraints.maxHeight * 1 / 28;
          final double timerBoxHeight = constraints.maxHeight * 1 / 28;
          final double maxKeyboardHeight = constraints.maxHeight * 2 / 11;
          final double maxKeyboardWidth = constraints.maxWidth;
          final double keyWidth = min(
            maxKeyboardHeight / 3,
            maxKeyboardWidth / 10,
          );
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: titleHeight,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  HelpButton(),
                                  InfoButton(darkMode: gameState.darkMode),
                                ],
                              ),
                            ),
                            TitleBox(height: titleHeight),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  StatsButton(gameState: gameState),
                                  SettingsButton(gameState: gameState),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      for (int i = 0; i < numRows; i++) ...[
                        const SizedBox(height: 5),
                        _buildLetterBoxRow(
                          min(letterBoxSize, maxLetterBoxSize),
                          i,
                        ),
                      ],
                      InfoBox(
                        size: infoBoxHeight,
                        info: gameState.infoBoxText,
                        shakeId: gameState.invalidGuessCount,
                      ),
                      ResultsButton(
                        size: resultsButtonHeight,
                        gameResult: gameState.gameResult,
                        puzzleNum: gameState.puzzleNum,
                        answer: gameState.answer,
                        guesses: gameState.todaysGuesses,
                      ),
                      TimerBox(
                        size: timerBoxHeight,
                        gameResult: gameState.gameResult,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Keyboard(keyWidth: keyWidth, gameState: gameState),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class HomePageScreen extends StatefulWidget {
  final GameState gameState;

  const HomePageScreen({super.key, required this.gameState});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  bool _dialogShown = false;

  @override
  void initState() {
    super.initState();
    widget.gameState.addListener(_onGameStateChanged);
    if (widget.gameState.gameHistory.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return HelpPopup();
          },
        );
      });
    }
  }

  @override
  void dispose() {
    widget.gameState.removeListener(_onGameStateChanged);
    super.dispose();
  }

  void _onGameStateChanged() {
    if (widget.gameState.gameResult == GameResult.won && !_dialogShown) {
      _dialogShown = true;

      showDialog(
        context: context,
        builder: (_) => WinPopup(
          puzzleNum: widget.gameState.puzzleNum,
          answer: widget.gameState.answer,
          guesses: widget.gameState.todaysGuesses,
        ),
      );
    }

    if (widget.gameState.gameResult == GameResult.lost && !_dialogShown) {
      _dialogShown = true;

      showDialog(
        context: context,
        builder: (_) => LossPopup(
          puzzleNum: widget.gameState.puzzleNum,
          answer: widget.gameState.answer,
          guesses: widget.gameState.todaysGuesses,
        ),
      );
    }

    if (widget.gameState.gameResult == GameResult.playing) {
      _dialogShown = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.gameState,
      builder: (context, _) {
        return HomePage(gameState: widget.gameState);
      },
    );
  }
}
