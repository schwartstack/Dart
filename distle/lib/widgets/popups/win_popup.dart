import 'package:distle/widgets/buttons/share_button.dart';
import 'package:flutter/material.dart';

class WinPopup extends StatelessWidget {
  final int puzzleNum;
  final String answer;
  final List<String> guesses;
  const WinPopup({
    super.key,
    required this.puzzleNum,
    required this.answer,
    required this.guesses,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Expanded(child: Text("You Won!")),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Congratulations! You won in ${guesses.length} guess${guesses.length == 1 ? "" : "es"}.",
          ),
        ],
      ),
      actions: [
        ShareButton(puzzleNum: puzzleNum, answer: answer, guesses: guesses),
      ],
    );
  }
}
