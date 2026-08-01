import 'package:flutter/material.dart';

import 'package:distle/game_state.dart';
import 'package:distle/widgets/popups/stats_popup.dart';

class StatsButton extends StatelessWidget {
  final GameState gameState;
  const StatsButton({super.key, required this.gameState});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.bar_chart),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatsPopup(gameState: gameState);
          },
        );
      },
    );
  }
}
