import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter_game/game/bullet.dart';
import 'package:flutter_game/game/enemy.dart';
import 'package:flutter_game/game_manager.dart';
import 'package:flutter_game/game/player.dart';
import '../common/background.dart';
import 'explosion.dart';

class Raptor extends Component with HasGameRef<GameManager> {
  late Player _player;
  late TextComponent _playerScore;
  static const int playerLevelByScore = 20;
  late Timer enemySpawner;
  late Timer bulletSpawner;
  int score = 0;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    enemySpawner = Timer(.5, onTick: _spawnEnemy, repeat: true);
    bulletSpawner = Timer(.3, onTick: _spawnBullet, repeat: true);
    add(Background());

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

    _player = Player(_onPlayerTouch);
    add(_player);
  }

  void _spawnBullet() {
    var bullet = Bullet();
    var bullet2 = Bullet();
    bullet.position = _player.position.clone() + Vector2(15, -10);
    bullet2.position = _player.position.clone() + Vector2(-15, -10);
    add(bullet);
    add(bullet2);
  }

  void _spawnEnemy() {
    for (int i = 0; i <= min(score ~/ playerLevelByScore, 1); i++) {
      add(Enemy(_onEnemyTouch));
    }
  }

  void _onPlayerTouch() {
    gameRef.endGame(score);
  }

  void _onEnemyTouch(Vector2 position) {
    var explosion = Explosion();
    explosion.position = position;
    add(explosion);
    score++;
    _playerScore.text = "Score : $score";

    // if (score % playerLevelByScore == 0) {
    //   bulletSpawner.stop();
    //   bulletSpawner = Timer(
    //       min(1 / (score ~/ playerLevelByScore), 1).toDouble(),
    //       onTick: _spawnBullet,
    //       repeat: true);
    // }
  }

  void onPanUpdate(DragUpdateInfo info) {
    if (isMounted) {
      _player.move(info.delta.game);
    }
  }

  @override
  void onMount() {
    super.onMount();
    enemySpawner.start();
    bulletSpawner.start();
  }

  @override
  void update(double dt) {
    super.update(dt);
    enemySpawner.update(dt);
    bulletSpawner.update(dt);
  }

  @override
  void onRemove() {
    super.onRemove();
    enemySpawner.stop();
    bulletSpawner.stop();
  }
}
