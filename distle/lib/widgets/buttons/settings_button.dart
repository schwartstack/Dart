import 'package:flutter/material.dart';

import 'package:distle/game_state.dart';
import 'package:distle/widgets/popups/settings_popup.dart';

class SettingsButton extends StatelessWidget {
  final GameState gameState;
  const SettingsButton({super.key, required this.gameState});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.symmetric(horizontal: 5),
      constraints: const BoxConstraints(),
      icon: Icon(Icons.settings),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AnimatedBuilder(
              animation: gameState,
              builder: (context, child) {
                return SettingsPopup(
                  darkMode: gameState.darkMode,
                  hardMode: gameState.hardMode,
                  onDarkModeSwitched: gameState.setDarkMode,
                  onHardModeSwitched: gameState.setHardMode,
                  onKeySizeSwitched: gameState.setKeySize,
                );
              },
            );
          },
        );
      },
    );
  }
}
