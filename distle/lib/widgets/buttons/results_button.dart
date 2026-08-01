import 'package:flutter/material.dart';

import 'package:distle/widgets/popups/loss_popup.dart';
import 'package:distle/widgets/popups/win_popup.dart';

class ResultsButton extends StatelessWidget {
  final int puzzleNum;
  final String answer;
  final List<String> guesses;
  const ResultsButton({
    super.key,
    required this.puzzleNum,
    required this.answer,
    required this.guesses,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
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
            child: const Text("See results"),
          ),
        ],
      ),
    );
  }
}
