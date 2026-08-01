import 'package:distle/game_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:distle/config/constants.dart';

class Keyboard extends StatelessWidget {
  final GameState gameState;

  const Keyboard({super.key, required this.gameState});

  Widget _buildLetterKey(String letter) {
    return LetterButton(letter: letter, onKeyPress: gameState.handleKeyPress);
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
        SizedBox(width: keySize / 4),
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
        SizedBox(width: keySize * 3 / 4),
        _buildLetterKey("Z"),
        _buildLetterKey("X"),
        _buildLetterKey("C"),
        _buildLetterKey("V"),
        _buildLetterKey("B"),
        _buildLetterKey("N"),
        _buildLetterKey("M"),
        EnterButton(onEnterPress: gameState.handleEnterPress),
        DeleteButton(onDeletePress: gameState.handleDeletePress),
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
  final String letter;
  final void Function(String) onKeyPress;

  const LetterButton({
    super.key,
    required this.letter,
    required this.onKeyPress,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onKeyPress(letter),
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(keySize, keySize),
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
        style: TextStyle(fontSize: keySize / 2, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class EnterButton extends StatelessWidget {
  final void Function() onEnterPress;

  const EnterButton({super.key, required this.onEnterPress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onEnterPress(),
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(keySize, keySize),
        padding: EdgeInsets.zero,
        minimumSize: Size.zero, // Removes default minimum size constraints
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(),
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      child: Icon(Icons.keyboard_return, size: keySize * 3 / 5),
    );
  }
}

class DeleteButton extends StatelessWidget {
  final void Function() onDeletePress;

  const DeleteButton({super.key, required this.onDeletePress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onDeletePress(),
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(keySize, keySize),
        padding: EdgeInsets.zero,
        minimumSize: Size.zero, // Removes default minimum size constraints
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(),
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      child: Icon(Icons.backspace_outlined, size: keySize * 3 / 5),
    );
  }
}
