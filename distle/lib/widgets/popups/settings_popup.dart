import 'package:distle/game_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsPopup extends StatefulWidget {
  final GameState gameState;

  const SettingsPopup({super.key, required this.gameState});

  @override
  State<SettingsPopup> createState() => _SettingsPopupState();
}

class _SettingsPopupState extends State<SettingsPopup> {
  final FocusNode _focusNode = FocusNode();

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
        title: Row(
          children: [
            const Expanded(child: Text("Settings")),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        content: SizedBox(
          width: 350,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwitchListTile.adaptive(
                title: const Text("Dark mode"),
                value: widget.gameState.darkMode,
                onChanged: widget.gameState.setDarkMode,
              ),
              SwitchListTile.adaptive(
                title: const Text("Hard mode"),
                value: widget.gameState.hardMode,
                onChanged: widget.gameState.setHardMode,
              ),

              if (widget.gameState.hardModeNextGame &&
                  !widget.gameState.hardMode) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "The next game you play will start in hard mode.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Hard mode can be turned off mid-game.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
