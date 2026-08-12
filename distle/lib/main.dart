import 'package:flutter/material.dart';
import 'package:web/web.dart';

import 'package:distle/app.dart';
import 'package:distle/config/user_data.dart';
import 'package:distle/game_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserData.load();

  final viewport = document.querySelector('meta[name="viewport"]');

  viewport?.setAttribute(
    'content',
    '${viewport.getAttribute('content')}, viewport-fit=cover',
  );

  runApp(MyApp(gameState: GameState()));
}
