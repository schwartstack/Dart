import 'package:flutter/material.dart';

import 'package:distle/widgets/popups/info_popup.dart';

class InfoButton extends StatelessWidget {
  const InfoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.symmetric(horizontal: 5),
      constraints: const BoxConstraints(),
      icon: Icon(Icons.info),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return InfoPopup();
          },
        );
      },
    );
  }
}
