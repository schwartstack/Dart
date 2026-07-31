import 'dart:ui';

import 'package:distle/config/data.dart';
import 'package:flutter/material.dart';

const int puzzleNumber = 0;
const String title = "Distle";
const double titleBoxHeight = 50.0;
const double infoBoxHeight = 50.0;
const int numRows = 5;
const double boxSize = 64.0;
const double keySize = 38.0;
const Color green = Color.fromRGBO(1, 154, 1, 1.0);
const Color red = Color.fromRGBO(255, 0, 1, 1.0);

final double maxDistance = locationMap["Q"]!.distanceTo(locationMap["P"]!);
