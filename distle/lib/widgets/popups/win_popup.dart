import 'package:distle/widgets/buttons/share_button.dart';
import 'package:flutter/material.dart';

class WinPopup extends StatelessWidget {
  final int puzzleNum;
  final String answer;
  final List<String> guesses;
  final int streak;
  const WinPopup({
    super.key,
    required this.puzzleNum,
    required this.answer,
    required this.guesses,
    required this.streak,
  });

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
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "🎉 You won in ${guesses.length} guess${guesses.length == 1 ? "" : "es"}! 🎉",
          ),
          if (streak > 1) ...[
            SizedBox(height: 20),
            Text("$streak day streak!"),
          ],
        ],
      ),
      actions: [
        ShareButton(puzzleNum: puzzleNum, answer: answer, guesses: guesses),
      ],
    );
  }
}
