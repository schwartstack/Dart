import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart';

import 'package:distle/config/constants.dart';

class TimerBox extends StatefulWidget {
  const TimerBox({super.key});

  @override
  State<TimerBox> createState() => _TimerBoxState();
}

class _TimerBoxState extends State<TimerBox> {
  Timer? _timer;

  TZDateTime dateInPacificTime = TZDateTime.now(PacificTimeLocation);

  int hours = 23;
  int minutes = 59;
  int seconds = 60;

  String format(int timeElement) {
    return "${timeElement < 10 ? "0" : ""}$timeElement";
  }

  void updateTime() {
    dateInPacificTime = TZDateTime.now(PacificTimeLocation);

    hours = 23 - dateInPacificTime.hour;
    minutes = 59 - dateInPacificTime.minute;
    seconds = 60 - dateInPacificTime.second;
  }

  @override
  void initState() {
    super.initState();

    updateTime();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        updateTime();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Next puzzle drops in "
        "${format(hours)}:${format(minutes)}:${format(seconds)}",
      ),
    );
  }
}
