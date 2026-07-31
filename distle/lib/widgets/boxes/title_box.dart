import 'package:flutter/material.dart';

import 'package:distle/config/constants.dart';
import 'package:distle/widgets/buttons/help_button.dart';
import 'package:distle/widgets/buttons/settings_button.dart';
import 'package:distle/widgets/buttons/stats_button.dart';

class TitleBox extends StatelessWidget {
  const TitleBox({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: titleBoxHeight,
      child: Stack(
        children: [
          Center(
            child: Text(
              title,
              style: TextStyle(fontSize: titleBoxHeight * 3 / 4),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [HelpButton(), StatsButton(), SettingsButton()],
            ),
          ),
        ],
      ),
    );
  }
}
