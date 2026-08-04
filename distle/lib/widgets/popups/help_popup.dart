import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:distle/config/constants.dart';

class HelpPopup extends StatefulWidget {
  const HelpPopup({super.key});

  @override
  State<HelpPopup> createState() => _HelpPopupState();
}

class _HelpPopupState extends State<HelpPopup> {
  final PageController _controller = PageController();
  final FocusNode _focusNode = FocusNode();

  int _page = 0;
  static const int _numPages = 3;

  void _next() {
    if (_page < _numPages - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previous() {
    if (_page > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }
  }

  void _close() {
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Widget _page1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Distle is a daily word guessing game"),
        const SizedBox(height: 20),
        const Text(
          "When you guess a word, each letter gets a color representing how far away that letter is from the target letter on a standard U.S. keyboard. ",
        ),
        const SizedBox(height: 20),
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                text: "Green",
                style: TextStyle(
                  color: Colors.white,
                  backgroundColor: green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(text: " means close.\n\n"),
              const TextSpan(
                text: "Red",
                style: TextStyle(
                  color: Colors.white,
                  backgroundColor: red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(text: " means far away.\n\n"),
              TextSpan(
                text: "Brownish",
                style: TextStyle(
                  color: Colors.white,
                  backgroundColor: Color.lerp(green, red, .5),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(text: " means somewhere inbetween."),
            ],
          ),
        ),
      ],
    );
  }

  Widget _page2() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(image: AssetImage('assets/images/circle.png')),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                "If a letter in your guessed word is correct, it will be surrounded by a circle like this.",
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(image: AssetImage('assets/images/arrow.png')),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                "If a letter in your guessed word is not correct, it will have an arrow pointing in the direction of the correct letter (on a standard U.S. keyboard).",
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(image: AssetImage('assets/images/gear.png')),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                "You can remove the arrows by turning on Hard Mode in the settings menu. (Click on the gear icon in the top-right of the main screen.)",
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _page3() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Let's take a look at an example guess"),
        SizedBox(height: 20),
        Image(image: AssetImage('assets/images/guess.png')),
        SizedBox(height: 20),
        Text(
          "After guessing \"LAUGH\", we know for sure that in the target word, letter #2 is \"A\" and letter #5 is \"H\".",
        ),
        SizedBox(height: 20),
        Text(
          "We also know that letter #1 is pretty far away from the \"L\" key and in the top row of the keyboard (because the arrow is pointing to the left and slightly up).",
        ),
        SizedBox(height: 20),
        Text(
          "Letter #3 is sort of close-ish and directly to the left of the \"U\" key.",
        ),
        SizedBox(height: 20),
        Text(
          "Letter #4 is very close and is up and to the left of the \"G\" key.",
        ),
        SizedBox(height: 20),
        Text("Given all of these clues, can you guess the secret word?"),
      ],
    );
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
          case LogicalKeyboardKey.arrowRight || LogicalKeyboardKey.space:
            _next();
            return KeyEventResult.handled;

          case LogicalKeyboardKey.arrowLeft ||
              LogicalKeyboardKey.delete ||
              LogicalKeyboardKey.backspace:
            _previous();
            return KeyEventResult.handled;

          case LogicalKeyboardKey.escape:
            _close();
            return KeyEventResult.handled;

          case LogicalKeyboardKey.enter || LogicalKeyboardKey.numpadEnter:
            if (_page == _numPages - 1) {
              _close();
              return KeyEventResult.handled;
            } else {
              _next();
              return KeyEventResult.handled;
            }
        }

        return KeyEventResult.ignored;
      },
      child: AlertDialog(
        title: Row(
          children: [
            const Expanded(child: Text("How to Play")),
            IconButton(icon: const Icon(Icons.close), onPressed: _close),
          ],
        ),
        content: SizedBox(
          width: 400,
          height: 400,
          child: PageView(
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (page) {
              setState(() {
                _page = page;
              });
            },
            children: [_page1(), _page2(), _page3()],
          ),
        ),
        actions: [
          Row(
            children: [
              if (_page > 0)
                ElevatedButton(
                  onPressed: _previous,
                  child: const Icon(Icons.arrow_back),
                )
              else
                const SizedBox.shrink(),

              const Spacer(),

              if (_page < _numPages - 1)
                ElevatedButton(
                  onPressed: _next,
                  child: const Icon(Icons.arrow_forward),
                )
              else
                ElevatedButton(onPressed: _close, child: const Text("OK")),
            ],
          ),
        ],
      ),
    );
  }
}
