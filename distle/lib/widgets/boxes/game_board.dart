import 'dart:math';

import 'package:distle/helpers.dart';
import 'package:flutter/material.dart';

import 'package:distle/config/constants.dart';

class LetterBoxRow extends StatelessWidget {
  final bool isSubmitted;
  final String guess;
  final String answer;

  const LetterBoxRow({
    super.key,
    required this.guess,
    required this.answer,
    required this.isSubmitted,
  });

  Widget _buildLetterBox(int index) {
    if (isSubmitted) {
      return LetterBox(
        letter: guess[index],
        distance: calculateDistance(guess[index], answer[index]),
        theta: calculateAngle(guess[index], answer[index]),
      );
    }
    if (guess.length > index) {
      return LetterBox(letter: guess[index]);
    }
    return LetterBox(letter: "");
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 5; i++) ...[
          _buildLetterBox(i),
          const SizedBox(width: 5),
        ],
      ],
    );
  }
}

class LetterBox extends StatelessWidget {
  final String letter;
  final double? distance;
  final double? theta;

  const LetterBox({super.key, required this.letter, this.distance, this.theta});

  @override
  Widget build(BuildContext context) {
    double? distanceProp = distance == null ? null : distance! / maxDistance;
    Color backgroundColor = distanceProp == null
        ? Colors.white
        : Color.lerp(Colors.green, Colors.red, distanceProp)!;

    return SizedBox.square(
      dimension: boxSize,
      child: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 4),
              color: backgroundColor,
            ),
          ),
          if (theta != null)
            CustomPaint(
              size: const Size.square(boxSize),
              painter: ArrowPainter(theta!),
            ),

          Positioned.fill(
            child: Center(
              child: Text(
                letter,
                style: const TextStyle(fontSize: boxSize / 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ArrowPainter extends CustomPainter {
  final double theta;

  ArrowPainter(this.theta);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    const margin = 10.0;
    final radius = size.width / 2 - margin;

    final tip = Offset(
      center.dx + radius * cos(theta),
      center.dy - radius * sin(theta),
    );

    final shaftLength = 0.0;

    final start = Offset(
      tip.dx - shaftLength * cos(theta),
      tip.dy + shaftLength * sin(theta),
    );

    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(start, tip, paint);

    const arrowHeadLength = 10.0;
    const arrowHeadAngle = pi / 4; // 30 degrees

    final leftPoint = Offset(
      tip.dx - arrowHeadLength * cos(theta - arrowHeadAngle),
      tip.dy + arrowHeadLength * sin(theta - arrowHeadAngle),
    );

    final rightPoint = Offset(
      tip.dx - arrowHeadLength * cos(theta + arrowHeadAngle),
      tip.dy + arrowHeadLength * sin(theta + arrowHeadAngle),
    );

    canvas.drawLine(tip, leftPoint, paint);
    canvas.drawLine(tip, rightPoint, paint);
  }

  @override
  bool shouldRepaint(covariant ArrowPainter oldDelegate) =>
      theta != oldDelegate.theta;
}
