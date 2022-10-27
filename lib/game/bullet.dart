import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'enemy.dart';

class Bullet extends SpriteComponent with CollisionCallbacks {
  final double _speed = 650;

  Vector2 direction = Vector2(0, -1);

  Bullet({
    required Sprite? sprite,
    required Vector2? position,
    required Vector2? size,
  }) : super(sprite: sprite, position: position, size: size);

  @override
  void onMount() {
    super.onMount();

    final shape = CircleHitbox.relative(
      0.4,
      parentSize: size,
      position: size / 2,
      anchor: Anchor.center,
    );
    add(shape);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Enemy) {
      removeFromParent();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += direction * _speed * dt;

    if (position.y < 0) {
      removeFromParent();
    }
  }
}
