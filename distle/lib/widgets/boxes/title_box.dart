import 'package:flutter/material.dart';

import 'package:distle/config/constants.dart';

class TitleBox extends StatelessWidget {
  const TitleBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title, style: TextStyle(fontSize: titleBoxHeight * 3 / 4)),
    );
  }
}
