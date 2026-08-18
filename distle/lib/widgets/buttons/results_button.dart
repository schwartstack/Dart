import 'package:distle/game_state.dart';
import 'package:flutter/material.dart';

import 'package:distle/widgets/popups/loss_popup.dart';
import 'package:distle/widgets/popups/win_popup.dart';

class ResultsButton extends StatelessWidget {
  final double size;
  final GameState gameState;
  const ResultsButton({super.key, required this.size, required this.gameState});

  @override
  Widget build(BuildContext context) {
    if (gameState.gameResult != GameResult.playing) {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
                onPressed: () =>
                    gameState.todaysGuesses.last == gameState.answer
                    ? showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return WinPopup(gameState: gameState);
                        },
                      )
                    : showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return LossPopup(
                            puzzleNum: gameState.puzzleNum,
                            answer: gameState.answer,
                            guesses: gameState.todaysGuesses,
                          );
                        },
                      ),
                child: Text(
                  "See results",
                  style: TextStyle(
                    fontSize: size / 2,
                    color: gameState.darkMode ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return SizedBox(height: size);
    }
  }
}
