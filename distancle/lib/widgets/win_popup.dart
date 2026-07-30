import 'package:distancle/widgets/share_button.dart';
import 'package:flutter/material.dart';

class WinPopup extends StatelessWidget {
  final String answer;
  final List<String> guesses;
  const WinPopup({super.key, required this.answer, required this.guesses});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("You Win!"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Congratulations! You won in ${guesses.length} guess${guesses.length == 1 ? "" : "es"}.",
          ),
        ],
      ),
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
