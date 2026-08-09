import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart';

import 'package:distle/config/data.dart';

final String version = "1.2.2";

final DateTime startDate = DateTime(2026, 8, 1);
final PacificTimeLocation = getLocation("America/Los_Angeles");
const String title = "Distle";
const int numRows = 6;
const Color green = Color.fromRGBO(1, 154, 1, 1.0);
const Color red = Color.fromRGBO(255, 0, 1, 1.0);

final double maxDistance = locationMap["Q"]!.distanceTo(locationMap["P"]!);
