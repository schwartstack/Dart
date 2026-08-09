import 'package:distle/game_state.dart';
import 'package:flutter/material.dart';

import 'package:distle/widgets/popups/loss_popup.dart';
import 'package:distle/widgets/popups/win_popup.dart';

class ResultsButton extends StatelessWidget {
  final double size;
  final GameResult gameResult;
  final int puzzleNum;
  final String answer;
  final List<String> guesses;
  const ResultsButton({
    super.key,
    required this.size,
    required this.gameResult,
    required this.puzzleNum,
    required this.answer,
    required this.guesses,
  });

  @override
  Widget build(BuildContext context) {
    if (gameResult != GameResult.playing) {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size,
              child: ElevatedButton(
                onPressed: () => guesses.last == answer
                    ? showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return WinPopup(
                            puzzleNum: puzzleNum,
                            answer: answer,
                            guesses: guesses,
                          );
                        },
                      )
                    : showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return LossPopup(
                            puzzleNum: puzzleNum,
                            answer: answer,
                            guesses: guesses,
                          );
                        },
                      ),
                child: Text(
                  "See results",
                  style: TextStyle(fontSize: size / 2),
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
