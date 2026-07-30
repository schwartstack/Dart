import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {
  final String? info;

  const InfoBox({super.key, this.info});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Center(
        child: Text(info ?? "", style: const TextStyle(fontSize: 20)),
      ),
    );
  }
}
