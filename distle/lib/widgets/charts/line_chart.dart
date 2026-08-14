import 'dart:math';

import 'package:flutter/material.dart';

import 'package:distle/config/user_data.dart';
import 'package:distle/helpers.dart';

class LineChart extends StatelessWidget {
  final List<String> guesses;
  final String answer;
  const LineChart({super.key, required this.guesses, required this.answer});

  @override
  Widget build(BuildContext context) {
    List<double> values = [];
    for (String guess in guesses) {
      values.add(calculateDistance(guess, answer)!);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Distance Per Guess"),
        SizedBox(
          width: 300,
          height: 200,
          child: CustomPaint(
            painter: LineChartPainter(context: context, values: values),
          ),
        ),
      ],
    );
  }
}

class LineChartPainter extends CustomPainter {
  final BuildContext context;
  final List<double> values;

  LineChartPainter({required this.values, required this.context});

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;

    const double leftPadding = 65;
    const double rightPadding = 20;
    const double topPadding = 20;
    const double bottomPadding = 50;
    final double chartWidth = size.width - leftPadding - rightPadding;
    final double chartHeight = size.height - topPadding - bottomPadding;
    double minY = values.reduce(min);
    double maxY = values.reduce(max);

    if (minY == maxY) {
      minY -= 1;
      maxY += 1;
    }

    final double yRange = maxY - minY;

    final axisPaint = Paint()
      ..color = UserData.darkMode ? Colors.white : Colors.black
      ..strokeWidth = 1;

    final linePaint = Paint()
      ..color = Theme.of(context).colorScheme.onSecondaryContainer
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()
      ..color = Theme.of(context).colorScheme.onSecondaryContainer
      ..style = PaintingStyle.fill;

    final textStyle = TextStyle(
      color: UserData.darkMode ? Colors.white : Colors.black,
      fontSize: 12,
    );

    Offset pointFor(int index, double value) {
      final double x = leftPadding + (index / (values.length - 1)) * chartWidth;
      final double normalizedY = (value - minY) / yRange;
      final double y = topPadding + (1 - normalizedY) * chartHeight;
      return Offset(x, y);
    }

    final double xAxisY = topPadding + chartHeight;
    final double yAxisX = leftPadding;

    canvas.drawLine(
      Offset(yAxisX, topPadding),
      Offset(yAxisX, xAxisY),
      axisPaint,
    );

    canvas.drawLine(
      Offset(yAxisX, xAxisY),
      Offset(leftPadding + chartWidth, xAxisY),
      axisPaint,
    );

    for (int i = 0; i < values.length; i++) {
      final double x = pointFor(i, values[i]).dx;
      canvas.drawLine(Offset(x, xAxisY), Offset(x, xAxisY + 5), axisPaint);
      final textPainter = TextPainter(
        text: TextSpan(text: '${i + 1}', style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(canvas, Offset(x - textPainter.width / 2, xAxisY + 8));
    }

    final xTitle = TextPainter(
      text: TextSpan(text: "guess number", style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout();

    xTitle.paint(
      canvas,
      Offset(
        leftPadding + chartWidth / 2 - xTitle.width / 2,
        size.height - xTitle.height,
      ),
    );

    const int numberOfYTicks = 5;

    for (int i = 0; i <= numberOfYTicks; i++) {
      final double fraction = i / numberOfYTicks;
      final double value = minY + fraction * yRange;
      final double y = topPadding + (1 - fraction) * chartHeight;
      canvas.drawLine(Offset(yAxisX - 5, y), Offset(yAxisX, y), axisPaint);
      final textPainter = TextPainter(
        text: TextSpan(text: value.toStringAsFixed(1), style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(
        canvas,
        Offset(yAxisX - textPainter.width - 8, y - textPainter.height / 2),
      );
    }

    final yTitle = TextPainter(
      text: TextSpan(text: "total distance", style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout();

    canvas.save();
    canvas.translate(15, topPadding + chartHeight / 2);
    canvas.rotate(-pi / 2);
    yTitle.paint(canvas, Offset(-yTitle.width / 2, -yTitle.height / 2));
    canvas.restore();

    if (values.length > 1) {
      final points = [
        for (int i = 0; i < values.length; i++) pointFor(i, values[i]),
      ];

      final path = Path()..moveTo(points[0].dx, points[0].dy);

      for (final point in points.skip(1)) {
        path.lineTo(point.dx, point.dy);
      }

      canvas.drawPath(path, linePaint);

      for (final point in points) {
        canvas.drawCircle(point, 4, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(LineChartPainter oldDelegate) {
    return oldDelegate.values != values;
  }
}
