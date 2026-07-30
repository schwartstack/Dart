import 'package:distancle/widgets/share_button.dart';
import 'package:flutter/material.dart';

class LossPopup extends StatelessWidget {
  final String answer;
  final List<String> guesses;
  const LossPopup({super.key, required this.answer, required this.guesses});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Game Over"),
      content: Text("The secret word was \"${answer.toLowerCase()}.\""),
      actions: [
        ShareButton(answer: answer, guesses: guesses),

        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Icon(Icons.close),
        ),
      ],
    );
  }
}
