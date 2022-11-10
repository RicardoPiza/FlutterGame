import 'dart:ui';

import 'package:flame/cache.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter_game/game/enemy.dart';

import '../game_manager.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef<GameManager>, GestureHitboxes, CollisionCallbacks {
  final VoidCallback onTouch;

  Player(this.onTouch);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    var spriteSheet = SpriteSheet(
      image: await Images().load('player_original.png'),
      srcSize: Vector2(32.0, 48.0),
    );
    animation = spriteSheet.createAnimation(row: 0, stepTime: 0.1);

    position = gameRef.size / 2;
    width = 50;
    height = 62;
    anchor = Anchor.center;

    add(RectangleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Enemy) {
      gameRef.camera.shake(duration: .05, intensity: 10);
      // onTouch.call();
    }
  }

  void move(Vector2 delta) {
    position.add(delta);
  }
}
