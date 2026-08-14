import 'package:distle/widgets/charts/line_chart.dart';
import 'package:flutter/material.dart';

import 'package:distle/widgets/buttons/share_button.dart';

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
      title: Row(
        children: [
          const Expanded(child: Text("Game Over")),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("The secret word was \"${answer.toLowerCase()}.\""),
          SizedBox(height: 20),
          LineChart(guesses: guesses, answer: answer),
        ],
      ),
      actions: [
        ShareButton(puzzleNum: puzzleNum, answer: answer, guesses: guesses),
      ],
    );
  }
}
