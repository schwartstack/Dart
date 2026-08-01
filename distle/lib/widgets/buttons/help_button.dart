import 'package:flutter/material.dart';

import 'package:distle/widgets/popups/help_popup.dart';

class HelpButton extends StatelessWidget {
  const HelpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.help),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return HelpPopup();
          },
        );
      },
    );
  }
}
