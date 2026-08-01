import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'package:share_plus/share_plus.dart';

import 'package:distle/config/constants.dart';
import 'package:distle/config/user_data.dart';
import 'package:distle/helpers.dart';

class ShareButton extends StatelessWidget {
  final int puzzleNum;
  final String answer;
  final List<String> guesses;
  const ShareButton({
    super.key,
    required this.puzzleNum,
    required this.answer,
    required this.guesses,
  });

  Future<void> _share() async {
    final bool won = guesses.last == answer;

    final bytes = await ShareImageGenerator().build(
      answer: answer,
      guesses: guesses,
    );

    await SharePlus.instance.share(
      ShareParams(
        title:
            "distle #${puzzleNum + 1} ${won ? guesses.length : "X"}/$numRows${UserData.hardMode ? "*" : ""}",
        files: [
          XFile.fromData(bytes, mimeType: "image/png", name: "share.png"),
        ],
        text: "http://distle.xyz",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: _share,
      icon: const Icon(Icons.share),
      label: const Text("Share"),
    );
  }
}

class ShareImageGenerator {
  Future<Uint8List> build({
    required String answer,
    required List<String> guesses,
  }) async {
    const double boxSize = 30.0;
    const double borderSize = 10.0;
    const double canvasWidth = (boxSize * 5) + (2 * borderSize);
    final double canvasHeight = (boxSize * guesses.length) + (2 * borderSize);

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, canvasWidth, canvasHeight),
      Paint()..color = UserData.darkMode ? Colors.black : Colors.white,
    );

    double pointerX = borderSize;
    double pointerY = borderSize;

    for (int i = 0; i < guesses.length; i++) {
      pointerY = borderSize + (boxSize * i);
      String guess = guesses[i];
      for (int j = 0; j < guess.length; j++) {
        pointerX = borderSize + (boxSize * j);
        canvas.drawRect(
          Rect.fromLTWH(pointerX, pointerY, boxSize, boxSize),
          Paint()..color = getBackgroundColor(guess[j], answer[j]),
        );
        canvas.drawRect(
          Rect.fromLTWH(pointerX, pointerY, boxSize, boxSize),
          Paint()
            ..color = UserData.darkMode ? Colors.white : Colors.black
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1,
        );
        if (guess[j] == answer[j]) {
          canvas.drawCircle(
            ui.Offset(pointerX + boxSize / 2, pointerY + boxSize / 2),
            0.7 * boxSize / 2,
            Paint()
              ..color = UserData.darkMode ? Colors.white : Colors.black
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1,
          );
        }
      }
    }

    final picture = recorder.endRecording();

    final image = await picture.toImage(
      (canvasWidth) as int,
      (canvasHeight) as int,
    );

    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }
}
