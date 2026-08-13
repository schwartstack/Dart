import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:distle/config/user_data.dart';
import 'package:distle/game_state.dart';
import 'package:distle/widgets/charts/bar_chart.dart';

class StatsPopup extends StatefulWidget {
  final GameState gameState;

  const StatsPopup({super.key, required this.gameState});

  @override
  State<StatsPopup> createState() => _StatsPopupState();
}

class _StatsPopupState extends State<StatsPopup> {
  final FocusNode _focusNode = FocusNode();

  void _close() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: (node, event) {
        if (event is! KeyDownEvent) {
          return KeyEventResult.ignored;
        }

        switch (event.logicalKey) {
          case LogicalKeyboardKey.escape ||
              LogicalKeyboardKey.enter ||
              LogicalKeyboardKey.numpadEnter:
            _close();
            return KeyEventResult.handled;
        }

        return KeyEventResult.ignored;
      },
      child: AlertDialog(
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
              "Win rate: ${widget.gameState.getWins()}/${widget.gameState.getAttempts()} (${widget.gameState.getWinPercentage()})",
            ),
            Text(
              "Current streak: ${widget.gameState.gameResult == GameResult.playing ? UserData.potentialNextStreak - 1 : widget.gameState.currentStreak}",
            ),
            Text("Longest streak: ${widget.gameState.longestStreak}"),
            SizedBox(height: 20),
            BarChart(),
          ],
        ),
      ),
    );
  }
}
