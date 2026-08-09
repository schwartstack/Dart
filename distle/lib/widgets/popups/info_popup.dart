import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hyperlink/hyperlink.dart';

import 'package:distle/config/constants.dart';

class InfoPopup extends StatefulWidget {
  final bool darkMode;

  const InfoPopup({super.key, required this.darkMode});

  @override
  State<InfoPopup> createState() => _InfoPopupState();
}

class _InfoPopupState extends State<InfoPopup> {
  final FocusNode _focusNode = FocusNode();
  final TextStyle linkStyle = TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

  void _close() {
    Navigator.of(context).pop();
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
          case LogicalKeyboardKey.escape ||
              LogicalKeyboardKey.enter ||
              LogicalKeyboardKey.numpadEnter:
            _close();
            return KeyEventResult.handled;
        }

        return KeyEventResult.ignored;
      },
      child: AlertDialog(
        scrollable: true,
        title: Row(
          children: [
            const Expanded(child: Text("Contact")),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            HyperLink(
              linkStyle: linkStyle,
              text:
                  "If you enjoy this game and you want to support it, you can [buy me a coffee](https://ko-fi.com/schwartstack).",
              textStyle: TextStyle(
                color: widget.darkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 20),
            HyperLink(
              linkStyle: linkStyle,
              text:
                  "To report a bug or for any other reason: [email me](mailto:jzs1986@gmail.com).",
              textStyle: TextStyle(
                color: widget.darkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Distle is a Flutter web app created by Jonathan Schwartz, a data scientist from San Jose, California.",
              style: TextStyle(
                color: widget.darkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 20),
            HyperLink(
              linkStyle: linkStyle,
              text:
                  "Check out my [website](http://schwartstack.github.io), my [LinkedIn](http://www.linkedin.com/in/schwartstack), and my [GitHub](https://github.com/schwartstack/).",
              textStyle: TextStyle(
                color: widget.darkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: SelectableText(
                style: TextStyle(color: Colors.grey, fontSize: 10),
                "version $version",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
