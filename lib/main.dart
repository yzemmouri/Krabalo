import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/krabalo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

// Set fullscreen mode
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

// Lock to landscape orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);

  final game = Krabalo();
  runApp(GameWidget(game: game));
}
