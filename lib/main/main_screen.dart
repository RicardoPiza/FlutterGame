import 'package:flame/components.dart';
import 'package:flame/src/gestures/events.dart';
import 'package:flutter_game/common/background.dart';
import 'package:flutter_game/game/game.dart';
import 'package:flutter/material.dart' show Colors, TextStyle;
import 'package:flutter_game/game_manager.dart';
import 'package:flutter_game/main/text.dart';

class MainScreen extends Component with HasGameRef<GameManager> {
  final Function _onStartClicked;
  late TextComponent _playerScore;

  MainScreen(this._onStartClicked);

  @override
  Future<void>? onLoad() {
    add(Background());
    add(Text());
    _playerScore = TextComponent(
        text: "Score : 0",
        position: Vector2(gameRef.size.toRect().width / 2, 10),
        anchor: Anchor.topCenter,
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 32.0,
            color: Colors.white,
          ),
        ));

    add(_playerScore);
  }

  void onPanStart(DragStartInfo info) {
    if (isMounted) _onStartClicked();
  }

  void setScore(int score) {
    _playerScore.text = "Score : $score";
  }
}
