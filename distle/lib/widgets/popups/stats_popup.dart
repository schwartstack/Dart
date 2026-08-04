import 'package:flutter/material.dart';

import 'package:distle/game_state.dart';

class StatsPopup extends StatelessWidget {
  final GameState gameState;

  const StatsPopup({super.key, required this.gameState});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Expanded(child: Text("Statistics")),
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
            "Win rate: ${gameState.getWins()}/${gameState.getAttempts()} (${gameState.getWinPercentage()})",
          ),
          Text(
            "Current streak: ${gameState.gameResult == GameResult.playing ? gameState.potentialNextStreak - 1 : gameState.currentStreak}",
          ),
          Text("Longest streak: ${gameState.longestStreak}"),
        ],
      ),
    );
  }
}
