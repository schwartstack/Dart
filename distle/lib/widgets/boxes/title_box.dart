import 'package:flutter/material.dart';

import 'package:distle/config/constants.dart';
import 'package:distle/game_state.dart';

class TitleBox extends StatelessWidget {
  final double height;
  final Holiday? holiday;
  const TitleBox({super.key, required this.height, required this.holiday});

  String reverseString(String input) {
    return input.split("").reversed.join("");
  }

  @override
  Widget build(BuildContext context) {
    String leftEmojis;
    String rightEmojis;
    switch (holiday) {
      case Holiday.newYear:
        leftEmojis = "🎆🎇";
        rightEmojis = "🎇🎆";
      case Holiday.brittany:
        leftEmojis = "🎁🎂";
        rightEmojis = "🎂🎁";
      case Holiday.valentines:
        leftEmojis = "💖🌹";
        rightEmojis = "🌹💖";
      case Holiday.halloween:
        leftEmojis = "🕸️🕷️🎃";
        rightEmojis = "🎃🕷️🕸️";
      case Holiday.thanksgiving:
        leftEmojis = "🥧🦃";
        rightEmojis = "🦃🥧";
      case Holiday.xmas:
        leftEmojis = "🎅🎄";
        rightEmojis = "🎄🎅";
      case null:
        leftEmojis = "";
        rightEmojis = "";
    }
    return Center(
      child: Text(
        "$leftEmojis $title $rightEmojis",
        style: TextStyle(fontSize: height * 3 / 4),
      ),
    );
  }
}
