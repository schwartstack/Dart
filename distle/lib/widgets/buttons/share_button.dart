import 'package:flutter/material.dart';

import 'package:share_plus/share_plus.dart';

import 'package:distle/config/constants.dart';
import 'package:distle/config/user_data.dart';
import 'package:distle/helpers.dart';

class ShareButton extends StatelessWidget {
  final int puzzleNum;
  final String answer;
  final List<String> guesses;
  const ShareButton({
    super.key,
    required this.puzzleNum,
    required this.answer,
    required this.guesses,
  });

  Future<void> _share() async {
    final bool won = guesses.last == answer;

    final emojiString = await ShareEmojiGenerator().build(
      answer: answer,
      guesses: guesses,
    );

    await SharePlus.instance.share(
      ShareParams(
        text:
            "distle.xyz #${puzzleNum + 1} ${won ? guesses.length : "X"}/$numRows${UserData.hardMode ? "*" : ""}\n\n$emojiString",
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
  String _getEmoji(String guess, String answer) {
    final double distance = calculateDistance(guess, answer)!;
    final double distanceProp = distance / maxDistance;
    String emoji;
    switch (distanceProp) {
      case 0:
        emoji = "🟢";
      case < .2:
        emoji = "🟩";
      case < .5:
        emoji = "🟨";
      case < .8:
        emoji = "🟧";
      default:
        emoji = "🟥";
    }
    return emoji;
  }

  Future<String> build({
    required String answer,
    required List<String> guesses,
  }) async {
    String emojiString = "";
    for (int i = 0; i < guesses.length; i++) {
      for (int j = 0; j < guesses[i].length; j++) {
        emojiString += _getEmoji(guesses[i][j], answer[j]);
      }
      if (i != guesses.length - 1) {
        emojiString += "\n";
      }
    }
    return emojiString;
  }
}
