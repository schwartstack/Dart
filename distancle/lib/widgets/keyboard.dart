import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:distancle/config/constants.dart';

class Keyboard extends StatelessWidget {
  final void Function(String) onKeyPressed;
  final void Function() onDeletePressed;
  final void Function() onEnterPressed;

  const Keyboard({
    super.key,
    required this.onKeyPressed,
    required this.onDeletePressed,
    required this.onEnterPressed,
  });

  Widget _buildLetterKey(String letter) {
    return LetterButton(letter: letter, onKeyPressed: onKeyPressed);
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
        EnterButton(onEnterPressed: onEnterPressed),
        DeleteButton(onDeletePressed: onDeletePressed),
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
          onKeyPressed(char);
          return KeyEventResult.handled;
        }

        switch (event.logicalKey) {
          case LogicalKeyboardKey.enter:
          case LogicalKeyboardKey.numpadEnter:
            onEnterPressed();
            return KeyEventResult.handled;

          case LogicalKeyboardKey.backspace:
          case LogicalKeyboardKey.delete:
            onDeletePressed();
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
  final void Function(String) onKeyPressed;

  const LetterButton({
    super.key,
    required this.letter,
    required this.onKeyPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onKeyPressed(letter),
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(keySize, keySize),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(),
        ),
        padding: const EdgeInsets.all(0),
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
  final void Function() onEnterPressed;

  const EnterButton({super.key, required this.onEnterPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onEnterPressed(),
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(keySize, keySize),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(),
        ),
        padding: const EdgeInsets.all(0),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      child: Icon(Icons.keyboard_return, size: keySize * 3 / 5),
    );
  }
}

class DeleteButton extends StatelessWidget {
  final void Function() onDeletePressed;

  const DeleteButton({super.key, required this.onDeletePressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onDeletePressed(),
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(keySize, keySize),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(),
        ),
        padding: const EdgeInsets.all(0),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      child: Icon(Icons.backspace_outlined, size: keySize * 3 / 5),
    );
  }
}
