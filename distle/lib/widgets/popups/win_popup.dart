import 'package:flutter/material.dart';

import 'package:distle/config/user_data.dart';
import 'package:distle/game_state.dart';
import 'package:distle/widgets/buttons/share_button.dart';
import 'package:distle/widgets/charts/bar_chart.dart';
import 'package:distle/widgets/charts/line_chart.dart';
import 'package:distle/widgets/popups/settings_popup.dart';
import 'package:distle/widgets/scrollable_widget.dart';

class WinPopup extends StatelessWidget {
  final GameState gameState;
  const WinPopup({super.key, required this.gameState});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Expanded(child: Text("Congratulations!")),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      content: ScrollableWidget(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "🎉 You won in ${gameState.todaysGuesses.length} guess${gameState.todaysGuesses.length == 1 ? "" : "es"}! 🎉",
            ),
            if (!UserData.hardModeNextGame &&
                gameState.todaysGuesses.length == 2) ...[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20),
                  Text("Nicely done."),
                  Text("Turn on hard mode for more of a challenge?"),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AnimatedBuilder(
                            animation: gameState,
                            builder: (context, child) {
                              return SettingsPopup(gameState: gameState);
                            },
                          );
                        },
                      );
                    },
                    child: Text(
                      "Open Settings",
                      style: TextStyle(
                        color: gameState.darkMode ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            if (gameState.currentStreak > 1) ...[
              SizedBox(height: 20),
              Text("${gameState.currentStreak} day streak!"),
            ],
            if (gameState.todaysGuesses.length > 1) ...[
              SizedBox(height: 20),
              LineChart(
                guesses: gameState.todaysGuesses,
                answer: gameState.answer,
              ),
            ],
            SizedBox(height: 20),
            BarChart(),
          ],
        ),
      ),
      actions: [
        ShareButton(
          puzzleNum: gameState.puzzleNum,
          answer: gameState.answer,
          guesses: gameState.todaysGuesses,
        ),
      ],
    );
  }
}
