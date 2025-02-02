import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'src/krabalo.dart';

void main() {
  final game = Krabalo();
  runApp(GameWidget(game: game));
}
