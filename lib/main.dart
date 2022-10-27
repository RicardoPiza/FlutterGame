import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';

import 'game/game.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  final game = Raptor();
  runApp(
    GameWidget(
      game: game,
    ),
  );
}
