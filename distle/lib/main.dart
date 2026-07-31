import 'package:flutter/material.dart';

import 'package:distle/app.dart';
import 'package:distle/game_state.dart';
import 'package:distle/config/user_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserData.load();
  runApp(MyApp(gameState: GameState()));
}
