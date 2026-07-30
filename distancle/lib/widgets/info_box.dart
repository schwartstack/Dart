import 'dart:math';

import 'package:flutter/material.dart';

import 'package:distancle/config/constants.dart';

class InfoBox extends StatefulWidget {
  final String? info;
  final int shakeId;

  const InfoBox({super.key, this.info, required this.shakeId});

  @override
  State<InfoBox> createState() => _InfoBoxState();
}

class _InfoBoxState extends State<InfoBox> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _startShake();
  }

  void _startShake() {
    _controller
      ..stop()
      ..reset()
      ..forward();
  }

  @override
  void didUpdateWidget(covariant InfoBox oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.shakeId != widget.shakeId) {
      _startShake();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: infoBoxHeight,
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final t = _controller.value;
            final dx = sin(t * pi * 10) * (1 - t) * 12;

            return Transform.translate(offset: Offset(dx, 0), child: child);
          },
          child: Text(
            widget.info ?? "",
            style: const TextStyle(fontSize: infoBoxHeight / 5),
          ),
        ),
      ),
    );
  }
}
