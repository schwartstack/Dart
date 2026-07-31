import 'package:distle/widgets/buttons/share_button.dart';
import 'package:flutter/material.dart';

class LossPopup extends StatelessWidget {
  final int puzzleNum;
  final String answer;
  final List<String> guesses;
  const LossPopup({
    super.key,
    required this.puzzleNum,
    required this.answer,
    required this.guesses,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Game Over"),
      content: Text("The secret word was \"${answer.toLowerCase()}.\""),
      actions: [
        ShareButton(puzzleNum: puzzleNum, answer: answer, guesses: guesses),

        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Icon(Icons.close),
        ),
      ],
    );
  }
}
