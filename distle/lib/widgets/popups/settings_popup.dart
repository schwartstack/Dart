import 'package:flutter/material.dart';

class SettingsPopup extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return AlertDialog(
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
            value: darkMode,
            onChanged: onDarkModeSwitched,
          ),
          SwitchListTile.adaptive(
            title: const Text("Hard mode"),
            value: hardMode,
            onChanged: onHardModeSwitched,
          ),
        ],
      ),
    );
  }
}
