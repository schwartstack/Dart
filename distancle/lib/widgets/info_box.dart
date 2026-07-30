import 'package:flutter/material.dart';

import 'package:distancle/config/constants.dart';

class InfoBox extends StatelessWidget {
  const InfoBox({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: const Center(child: Text(title, style: TextStyle(fontSize: 75))),
    );
  }
}
