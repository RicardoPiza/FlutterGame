import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame_audio/flame_audio.dart';
import 'game_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setPortrait();
  FlameAudio.bgm.initialize();
  FlameAudio.bgm.play('main-ost1.mp3', volume: .5);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Raptor: Call of the USF",
      debugShowCheckedModeBanner: false,
      home: GameWidget(game: GameManager()),
    );
  }
}
