import 'package:flutter/material.dart';

class HelpPopup extends StatelessWidget {
  const HelpPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text("How to Play"),
      content: SelectableText("""
Distle is a daily word guessing game.

When you guess a word, the color underneath the guessed letter represents how far away the letter is from the target letter on a standard U.S. keyboard.

Red means far away, green means close, brownish yellow means somewhere inbetween far and close.

When the guessed letter is exactly the same as the target letter, there will also be a circle around the letter in order to distinguish the difference between \"as green as it can possibly be\" (which means the guessed letter is correct) and \"almost as green as it can possibly be\" (which means the guessed letter is close but not correct). In other words, in order to win, you must guess a word where all 5 letters are surrounded by circles.

In normal mode, there will also be an arrow around the guessed letter pointing in the direction of the target letter from the perspective of the guessed letter. In hard mode, there are no arrows. You only know the distance not the direction.

To toggle hard mode on and off, click the settings button in the top right of the main screen.
"""),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Icon(Icons.close),
        ),
      ],
    );
  }
}
