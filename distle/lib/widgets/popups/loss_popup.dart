import 'package:flutter/material.dart';

import 'package:distle/game_state.dart';
import 'package:distle/widgets/buttons/share_button.dart';
import 'package:distle/widgets/charts/line_chart.dart';

class LossPopup extends StatelessWidget {
  final GameState gameState;
  const LossPopup({super.key, required this.gameState});

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
          Text("The secret word was \"${gameState.answer.toLowerCase()}.\""),
          SizedBox(height: 20),
          LineChart(guesses: gameState.todaysGuesses, answer: gameState.answer),
        ],
      ),
      actions: [ShareButton(gameState: gameState)],
    );
  }
}
