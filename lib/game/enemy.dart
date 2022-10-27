import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/particles.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/game/player.dart';
import '../models/command.dart';
import '../models/enemy_data.dart';
import 'bullet.dart';
import '../knows_game_size.dart';

class Enemy extends SpriteComponent
    with KnowsGameSize, CollisionCallbacks, HasGameRef {
  double _speed = 250;
  Vector2 moveDirection = Vector2(0, 1);
  late Timer _freezeTimer;
  final _random = Random();
  final EnemyData enemyData;
  int _hitPoints = 10;
  final _hpText = TextComponent(
    text: '10 HP',
    textRenderer: TextPaint(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontFamily: 'BungeeInline',
      ),
    ),
  );
  Vector2 getRandomVector() {
    return (Vector2.random(_random) - Vector2.random(_random)) * 500;
  }

  Vector2 getRandomDirection() {
    return (Vector2.random(_random) - Vector2(0.5, -1)).normalized();
  }

  Enemy({
    required Sprite? sprite,
    required this.enemyData,
    required Vector2? position,
    required Vector2? size,
  }) : super(sprite: sprite, position: position, size: size) {
    angle = pi;
    _speed = enemyData.speed;
    _hitPoints = enemyData.level * 10;
    _hpText.text = '$_hitPoints HP';
    _freezeTimer = Timer(2, onTick: () {
      _speed = enemyData.speed;
    });
    if (enemyData.hMove) {
      moveDirection = getRandomDirection();
    }
  }

  @override
  void onMount() {
    super.onMount();
    final shape = CircleHitbox.relative(
      0.8,
      parentSize: size,
      position: size / 2,
      anchor: Anchor.center,
    );
    add(shape);
    _hpText.angle = pi;
    _hpText.position = Vector2(50, 80);
    add(_hpText);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Bullet) {
      _hitPoints -= 10;
    } else if (other is Player) {
      destroy();
    }
  }

  void destroy() {
    removeFromParent();
    final command = Command<Player>(action: (player) {
      player.addToScore(enemyData.killPoint);
    });
    final particleComponent = ParticleSystemComponent(
      particle: Particle.generate(
        count: 20,
        lifespan: 0.1,
        generator: (i) => AcceleratedParticle(
          acceleration: getRandomVector(),
          speed: getRandomVector(),
          position: position.clone(),
          child: CircleParticle(
            radius: 2,
            paint: Paint()..color = Colors.white,
          ),
        ),
      ),
    );

    gameRef.add(particleComponent);
  }

  @override
  void update(double dt) {
    super.update(dt);
    _hpText.text = '$_hitPoints HP';
    if (_hitPoints <= 0) {
      destroy();
    }
    _freezeTimer.update(dt);
    position += moveDirection * _speed * dt;
    if (position.y > gameRef.size.y) {
      removeFromParent();
    } else if ((position.x < size.x / 2) ||
        (position.x > (gameRef.size.x - size.x / 2))) {
      moveDirection.x *= -1;
    }
  }

  void freeze() {
    _speed = 0;
    _freezeTimer.stop();
    _freezeTimer.start();
  }
}
