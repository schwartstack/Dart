import 'package:flutter/material.dart';

import 'package:distle/config/constants.dart';
import 'package:distle/game_state.dart';
import 'package:distle/widgets/boxes/game_board.dart';
import 'package:distle/widgets/boxes/info_box.dart';
import 'package:distle/widgets/boxes/keyboard.dart';
import 'package:distle/widgets/boxes/title_box.dart';
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

  Widget _buildLetterBoxRow(int rowNumber) {
    if (gameState.todaysGuesses.length > rowNumber) {
      return LetterBoxRow(
        guess: gameState.todaysGuesses[rowNumber],
        answer: gameState.answer,
        isSubmitted: true,
      );
    }
    if (gameState.todaysGuesses.length == rowNumber) {
      return LetterBoxRow(
        guess: gameState.currentGuess,
        answer: gameState.answer,
        isSubmitted: false,
      );
    }
    return LetterBoxRow(
      guess: "",
      answer: gameState.answer,
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
                  SizedBox(
                    width: double.infinity,
                    height: titleBoxHeight,
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
                        TitleBox(),
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
                    _buildLetterBoxRow(i),
                  ],
                  InfoBox(
                    info: gameState.infoBoxText,
                    shakeId: gameState.invalidGuessCount,
                  ),
                  if (gameState.gameResult != GameResult.playing) ...[
                    ResultsButton(
                      puzzleNum: gameState.puzzleNum,
                      answer: gameState.answer,
                      guesses: gameState.todaysGuesses,
                    ),
                  ],
                ],
              ),
            ),
            Expanded(flex: 1, child: Keyboard(gameState: gameState)),
          ],
        ),
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
