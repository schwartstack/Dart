import 'package:distle/config/data.dart';
import 'package:flutter/material.dart';

import 'package:distle/config/constants.dart';

class TitleBox extends StatelessWidget {
  final double height;
  final Holiday? holiday;
  const TitleBox({super.key, required this.height, required this.holiday});

  String reverseString(String input) {
    return input.split("").reversed.join("");
  }

  @override
  Widget build(BuildContext context) {
    Object leftEmojis = holidayMap[holiday]?["leftEmojis"] ?? "";
    Object rightEmojis = holidayMap[holiday]?["rightEmojis"] ?? "";
    return Center(
      child: Text(
        "$leftEmojis $title $rightEmojis",
        style: TextStyle(fontSize: height * 3 / 4),
      ),
    );
  }
}
