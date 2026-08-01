import 'dart:math';

import 'package:flutter/material.dart';

import 'package:distle/config/constants.dart';
import 'package:distle/config/user_data.dart';
import 'package:distle/helpers.dart';

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
    return LetterBox(
      guessLetter: guess.length > index ? guess[index] : null,
      targetLetter: answer[index],
      isSubmitted: isSubmitted,
    );
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
  final String? guessLetter;
  final String targetLetter;
  final bool isSubmitted;

  const LetterBox({
    super.key,
    required this.guessLetter,
    required this.targetLetter,
    required this.isSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    double? theta = calculateAngle(guessLetter, targetLetter);
    return SizedBox.square(
      dimension: boxSize,
      child: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                color: UserData.darkMode ? Colors.white70 : Colors.black,
                width: 4,
              ),
              color: getBackgroundColor(
                guessLetter,
                targetLetter,
                isSubmitted: isSubmitted,
              ),
            ),
          ),

          if (isSubmitted && theta == null)
            CustomPaint(
              size: const Size.square(boxSize),
              painter: CirclePainter(UserData.darkMode),
            ),

          if (isSubmitted && theta != null && !UserData.hardMode)
            CustomPaint(
              size: const Size.square(boxSize),
              painter: ArrowPainter(theta, UserData.darkMode),
            ),

          Positioned.fill(
            child: Center(
              child: Text(
                guessLetter ?? "",
                style: const TextStyle(
                  fontSize: boxSize / 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ArrowPainter extends CustomPainter {
  final bool darkMode;
  final double theta;

  ArrowPainter(this.theta, this.darkMode);

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
      ..color = darkMode ? Colors.white70 : Colors.black
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

class CirclePainter extends CustomPainter {
  final bool darkMode;

  CirclePainter(this.darkMode);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    const margin = 10.0;
    final radius = size.width / 2 - margin;

    final paint = Paint()
      ..color = darkMode ? Colors.white70 : Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CirclePainter oldDelegate) => false;
}
