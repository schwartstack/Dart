import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsPopup extends StatefulWidget {
  final bool darkMode;
  final bool hardMode;
  final void Function(bool value) onDarkModeSwitched;
  final void Function(bool value) onHardModeSwitched;

  const SettingsPopup({
    super.key,
    required this.darkMode,
    required this.hardMode,
    required this.onDarkModeSwitched,
    required this.onHardModeSwitched,
  });

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
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile.adaptive(
              title: const Text("Dark mode"),
              value: widget.darkMode,
              onChanged: widget.onDarkModeSwitched,
            ),
            SwitchListTile.adaptive(
              title: const Text("Hard mode"),
              value: widget.hardMode,
              onChanged: widget.onHardModeSwitched,
            ),
          ],
        ),
      ),
    );
  }
}
