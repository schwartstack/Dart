import 'package:flutter/material.dart';

import 'package:distle/config/user_data.dart';

class BarChart extends StatelessWidget {
  Map<int, int> _getGameHistoryMap() {
    final Map<int, int> gameHistoryMap = {};
    for (String gameResult in UserData.gameHistory) {
      if (gameResult != "X") {
        gameHistoryMap[int.tryParse(gameResult)!] =
            (gameHistoryMap[int.tryParse(gameResult)!] ?? 0) + 1;
      }
    }
    return gameHistoryMap;
  }

  int _getMostCommonResultFrequency(Map<int, int> gameHistoryMap) {
    if (gameHistoryMap.isEmpty) {
      return 1;
    }
    MapEntry<int, int> mostCommonEntry = gameHistoryMap.entries.reduce(
      (a, b) => a.value > b.value ? a : b,
    );
    return mostCommonEntry.value;
  }

  @override
  Widget build(BuildContext context) {
    Map<int, int> gameHistoryMap = _getGameHistoryMap();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Guess Distribution"),
        SizedBox(
          width: 300,
          child: Column(
            children: List.generate(6, (index) {
              final int guessNumber = index + 1;
              final int count = gameHistoryMap[guessNumber] ?? 0;
              final int maxCount = _getMostCommonResultFrequency(
                gameHistoryMap,
              );
              return SizedBox(
                height: 24,
                child: Row(
                  children: [
                    SizedBox(
                      width: 24,
                      child: Text(
                        "$guessNumber",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final barWidth = maxCount == 0
                              ? 0.0
                              : constraints.maxWidth * count / maxCount;

                          return Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                              width: barWidth,
                              height: 18,
                              child: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 6),
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSecondaryContainer,
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Text(
                                  "${count > 0 ? count : ''}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: UserData.darkMode
                                        ? Theme.of(
                                            context,
                                          ).colorScheme.onPrimary
                                        : Theme.of(
                                            context,
                                          ).colorScheme.onSecondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
