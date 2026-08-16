import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart';

import 'package:distle/config/data.dart';

final String version = "3.1.2";

final DateTime startDate = DateTime(2026, 8, 1);
final pacificTimeLocation = getLocation("America/Los_Angeles");
const String title = "Distle";
const int numRows = 6;
const Color red = Color.fromRGBO(255, 0, 1, 1.0);
const Color orange = Color.fromRGBO(250, 120, 1, 1.0);
const Color yellow = Color.fromRGBO(255, 242, 0, 1);
const Color green = Color.fromRGBO(1, 154, 1, 1.0);
const List<double> colorBreaks = [.4, .8];

final double maxDistance = locationMap["Q"]!.distanceTo(locationMap["P"]!);
