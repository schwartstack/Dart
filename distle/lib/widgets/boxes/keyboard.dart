import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:distle/game_state.dart';

class Keyboard extends StatelessWidget {
  final double keyWidth;
  final GameState gameState;

  const Keyboard({super.key, required this.keyWidth, required this.gameState});

  Widget _buildLetterKey(String letter) {
    return LetterButton(
      keyWidth: keyWidth,
      letter: letter,
      gameState: gameState,
    );
  }

  Widget _buildRow1() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildLetterKey("Q"),
        _buildLetterKey("W"),
        _buildLetterKey("E"),
        _buildLetterKey("R"),
        _buildLetterKey("T"),
        _buildLetterKey("Y"),
        _buildLetterKey("U"),
        _buildLetterKey("I"),
        _buildLetterKey("O"),
        _buildLetterKey("P"),
      ],
    );
  }

  Widget _buildRow2() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: keyWidth / 4),
        _buildLetterKey("A"),
        _buildLetterKey("S"),
        _buildLetterKey("D"),
        _buildLetterKey("F"),
        _buildLetterKey("G"),
        _buildLetterKey("H"),
        _buildLetterKey("J"),
        _buildLetterKey("K"),
        _buildLetterKey("L"),
      ],
    );
  }

  Widget _buildRow3() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: keyWidth * 3 / 4),
        _buildLetterKey("Z"),
        _buildLetterKey("X"),
        _buildLetterKey("C"),
        _buildLetterKey("V"),
        _buildLetterKey("B"),
        _buildLetterKey("N"),
        _buildLetterKey("M"),
        EnterButton(keyWidth: keyWidth, gameState: gameState),
        DeleteButton(keyWidth: keyWidth, gameState: gameState),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onKeyEvent: (_, event) {
        if (event is! KeyDownEvent) {
          return KeyEventResult.ignored;
        }
        final char = event.character?.toUpperCase();

        if (char != null && RegExp(r'^[A-Z]$').hasMatch(char)) {
          gameState.handleKeyPress(char);
          return KeyEventResult.handled;
        }

        switch (event.logicalKey) {
          case LogicalKeyboardKey.enter:
          case LogicalKeyboardKey.numpadEnter:
            gameState.handleEnterPress();
            return KeyEventResult.handled;

          case LogicalKeyboardKey.backspace:
          case LogicalKeyboardKey.delete:
            gameState.handleDeletePress();
            return KeyEventResult.handled;
        }

        return KeyEventResult.ignored;
      },
      child: SizedBox(
        width: double.infinity,
        child: Align(
          alignment: Alignment.center,
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [_buildRow1(), _buildRow2(), _buildRow3()],
            ),
          ),
        ),
      ),
    );
  }
}

class LetterButton extends StatelessWidget {
  final double keyWidth;
  final GameState gameState;
  final String letter;

  const LetterButton({
    super.key,
    required this.keyWidth,
    required this.letter,
    required this.gameState,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => gameState.handleKeyPress(letter),
      style: ElevatedButton.styleFrom(
        fixedSize: Size(keyWidth, keyWidth),
        padding: EdgeInsets.zero,
        minimumSize: Size.zero, // Removes default minimum size constraints
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(),
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      child: Text(
        letter,
        style: TextStyle(fontSize: keyWidth / 2, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class EnterButton extends StatelessWidget {
  final double keyWidth;
  final GameState gameState;

  const EnterButton({
    super.key,
    required this.keyWidth,
    required this.gameState,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => gameState.handleEnterPress(),
      style: ElevatedButton.styleFrom(
        fixedSize: Size(keyWidth, keyWidth),
        padding: EdgeInsets.zero,
        minimumSize: Size.zero, // Removes default minimum size constraints
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(),
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      child: Icon(Icons.keyboard_return, size: keyWidth * 3 / 5),
    );
  }
}

class DeleteButton extends StatelessWidget {
  final double keyWidth;
  final GameState gameState;

  const DeleteButton({
    super.key,
    required this.keyWidth,
    required this.gameState,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => gameState.handleDeletePress(),
      style: ElevatedButton.styleFrom(
        fixedSize: Size(keyWidth, keyWidth),
        padding: EdgeInsets.zero,
        minimumSize: Size.zero, // Removes default minimum size constraints
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(),
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      child: Icon(Icons.backspace_outlined, size: keyWidth * 3 / 5),
    );
  }
}
