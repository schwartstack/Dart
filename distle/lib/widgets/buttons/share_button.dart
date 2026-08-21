import 'package:flutter/material.dart';

import 'package:share_plus/share_plus.dart';

import 'package:distle/config/constants.dart';
import 'package:distle/config/data.dart';
import 'package:distle/config/user_data.dart';
import 'package:distle/game_state.dart';
import 'package:distle/helpers.dart';

class ShareButton extends StatelessWidget {
  final GameState gameState;
  const ShareButton({super.key, required this.gameState});

  Future<void> _share() async {
    final bool won = gameState.todaysGuesses.last == gameState.answer;

    final emojiString = await ShareEmojiGenerator().build(
      answer: gameState.answer,
      guesses: gameState.todaysGuesses,
      holiday: gameState.holiday,
    );

    await SharePlus.instance.share(
      ShareParams(
        text:
            "distle.xyz #${gameState.puzzleNum + 1} ${won ? gameState.todaysGuesses.length : "X"}/$numRows${UserData.hardMode ? "*" : ""}\n\n$emojiString",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: _share,
      icon: const Icon(Icons.share),
      label: const Text("Share"),
    );
  }
}

class ShareEmojiGenerator {
  String _getEmoji(String guess, String answer, Holiday? holiday) {
    final double distance = calculateDistance(guess, answer)!;
    final double distanceProp = distance / maxDistance;
    if (distanceProp == 0) {
      Object result = holidayMap[holiday]?["winEmoji"] ?? "🟢";
      return result as String;
    } else if (distanceProp < (colorBreaks[0] * 2 / 3)) {
      return "🟩";
    } else if (distanceProp <
        colorBreaks[0] + (colorBreaks[1] - colorBreaks[0]) * 1 / 3) {
      return "🟨";
    } else if (distanceProp < colorBreaks[1]) {
      return "🟧";
    }
    return "🟥";
  }

  Future<String> build({
    required String answer,
    required List<String> guesses,
    Holiday? holiday,
  }) async {
    String emojiString = "";
    for (int i = 0; i < guesses.length; i++) {
      for (int j = 0; j < guesses[i].length; j++) {
        emojiString += _getEmoji(guesses[i][j], answer[j], holiday);
      }
      if (i != guesses.length - 1) {
        emojiString += "\n";
      }
    }
    return emojiString;
  }
}
