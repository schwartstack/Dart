import 'dart:math';

import 'package:distle/config/constants.dart';
import 'package:distle/config/data.dart';
import 'package:distle/config/user_data.dart';
import 'package:flutter/material.dart';

double? calculateDistance(String? string1, String string2) {
  if (string1 == null) {
    return null;
  }
  double totalDistance = 0.0;
  for (int i = 0; i < string1.length; i++) {
    totalDistance += locationMap[string1[i]]!.distanceTo(
      locationMap[string2[i]]!,
    );
  }
  return totalDistance;
}

double? calculateAngle(String? letter1, String letter2) {
  if (letter1 == null) {
    return null;
  }
  final Point p1 = locationMap[letter1]!;
  final Point p2 = locationMap[letter2]!;
  final num dy = p2.y - p1.y;
  final num dx = p2.x - p1.x;
  if (dy == 0 && dx == 0) return null;
  return atan2(dy, dx);
}

Color getColorFromProp(double prop) {
  Color fromColor;
  Color toColor;
  double lerpValue;
  if (prop < colorBreaks[0]) {
    fromColor = green;
    toColor = yellow;
    lerpValue = prop / colorBreaks[0];
  } else if (prop < colorBreaks[1]) {
    fromColor = yellow;
    toColor = orange;
    lerpValue = (prop - colorBreaks[0]) / (colorBreaks[1] - colorBreaks[0]);
  } else {
    fromColor = orange;
    toColor = red;
    lerpValue = (prop - colorBreaks[1]) / (1 - colorBreaks[1]);
  }
  return Color.lerp(fromColor, toColor, lerpValue)!;
}

Color getBackgroundColor(
  String? letter1,
  String letter2, {
  bool isSubmitted = true,
}) {
  if (letter1 == null || !isSubmitted) {
    if (UserData.darkMode) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }
  double distance = calculateDistance(letter1, letter2)!;
  double distanceProp = distance / maxDistance;
  return getColorFromProp(distanceProp);
}
