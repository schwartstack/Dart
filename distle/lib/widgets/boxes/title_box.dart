import 'package:flutter/material.dart';

import 'package:distle/config/constants.dart';

class TitleBox extends StatelessWidget {
  final double height;
  const TitleBox({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title, style: TextStyle(fontSize: height * 3 / 4)),
    );
  }
}
