import 'dart:math';
import 'package:flame/cache.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';
import 'package:flutter_game/game/player.dart';
import 'bullet.dart';
import 'game.dart';
import '../game_manager.dart';

class Enemy extends SpriteAnimationComponent
    with HasGameRef<GameManager>, GestureHitboxes, CollisionCallbacks {
  final double _speed = 250;

  final Function(Vector2) onTouch;
  var rectanglehitbox = RectangleHitbox();

  Enemy(this.onTouch);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    var spriteSheet = SpriteSheet(
        image: await Images().load('enemy.png'), srcSize: Vector2(16.0, 16));
    animation = spriteSheet.createAnimation(row: 0, stepTime: 0.2);
    var size = 35.0;
    position = Vector2(
        Random()
            .nextInt((gameRef.size.toRect().width - size).toInt())
            .toDouble(),
        size);
    width = size;
    height = size;
    anchor = Anchor.center;

    add(rectanglehitbox);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Bullet) {
      removeFromParent();
      remove(rectanglehitbox);
      onTouch.call(other.position);
    }
  }

  void move(Vector2 delta) {
    position.add(delta);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += Vector2(0, 1) * _speed * dt;
    if (position.y > gameRef.size.y) {
      removeFromParent();
      remove(rectanglehitbox);
    }
  }
}
