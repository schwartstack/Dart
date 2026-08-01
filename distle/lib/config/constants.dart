import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:distle/config/data.dart';

final DateTime startDate = DateTime(2026, 8, 1);

const String title = "Distle";
const double titleBoxHeight = 50.0;
const double infoBoxHeight = 50.0;
const int numRows = 6;
const double boxSize = 64.0;
const double keySize = 38.0;
const Color green = Color.fromRGBO(1, 154, 1, 1.0);
const Color red = Color.fromRGBO(255, 0, 1, 1.0);

final double maxDistance = locationMap["Q"]!.distanceTo(locationMap["P"]!);
