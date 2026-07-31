import 'package:distle/widgets/popups/loss_popup.dart';
import 'package:distle/widgets/popups/win_popup.dart';
import 'package:flutter/material.dart';

class ResultsButton extends StatelessWidget {
  final String answer;
  final List<String> guesses;
  const ResultsButton({super.key, required this.answer, required this.guesses});

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
                      return WinPopup(answer: answer, guesses: guesses);
                    },
                  )
                : showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return LossPopup(answer: answer, guesses: guesses);
                    },
                  ),
            child: const Text("See results"),
          ),
        ],
      ),
    );
  }
}
