import 'package:flutter/material.dart';

class LossPopup extends StatelessWidget {
  final String answer;
  const LossPopup({super.key, required this.answer});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Game Over"),
      content: Text("The secret word was \"${answer.toLowerCase()}.\""),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Bummer"),
        ),
      ],
    );
  }
}
