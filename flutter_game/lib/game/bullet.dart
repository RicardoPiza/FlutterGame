import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_game/game_manager.dart';

import 'enemy.dart';

class Bullet extends SpriteComponent
    with CollisionCallbacks, GestureHitboxes, HasGameRef<GameManager> {
  final double _speed = 400;
  var shape = RectangleHitbox();

  Vector2 direction = Vector2(0, -1);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('shot4_5.png');
    width = 80;
    height = 120;

    anchor = Anchor.center;
    add(shape);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Enemy) {
      removeFromParent();
      remove(shape);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += direction * _speed * dt;

    if (position.y < 0) {
      removeFromParent();
      remove(shape);
    }
  }
}
