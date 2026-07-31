import 'dart:math';

import 'package:distle/config/data.dart';

double calculateDistance(String string1, String string2) {
  double totalDistance = 0.0;
  for (int i = 0; i < string1.length; i++) {
    totalDistance += locationMap[string1[i]]!.distanceTo(
      locationMap[string2[i]]!,
    );
  }
  return totalDistance;
}

double? calculateAngle(String letter1, String letter2) {
  final Point p1 = locationMap[letter1]!;
  final Point p2 = locationMap[letter2]!;
  final num dy = p2.y - p1.y;
  final num dx = p2.x - p1.x;
  if (dy == 0 && dx == 0) return null;
  return atan2(dy, dx);
}
