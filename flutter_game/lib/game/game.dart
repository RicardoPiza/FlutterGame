import 'package:flame/image_composition.dart';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame/parallax.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter_game/game/bullet.dart';
import 'package:flutter_game/game/enemy.dart';
import 'package:flutter_game/knows_game_size.dart';
import 'package:flutter_game/game/player.dart';

import '../models/enemy_data.dart';
import 'enemy_manager.dart';

class Raptor extends FlameGame
    with HasDraggables, TapDetector, KnowsGameSize, ChangeNotifier {
  late SpriteComponent player;
  late final JoystickComponent joystick;
  late EnemyManager _enemyManager;
  SpriteAnimationComponent bulletDesign = SpriteAnimationComponent();
  Random random = Random();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    ParallaxComponent _stars = await ParallaxComponent.load(
      [
        ParallaxImageData('background.png'),
        ParallaxImageData('stars1.png'),
        ParallaxImageData('stars2.png'),
      ],
      repeat: ImageRepeat.repeat,
      baseVelocity: Vector2(0, -60),
      velocityMultiplierDelta: Vector2(0, 1.5),
    );
    add(_stars);

    player = Player(
      position: Vector2(180, 450),
      size: Vector2(80, 80),
      sprite: await loadSprite('player.png'),
    );
    add(player);

    final knobPaint = BasicPalette.lightRed.withAlpha(100).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 30, paint: knobPaint),
      background: CircleComponent(radius: 50, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 25, bottom: 40),
    );
    add(joystick);

    await images.load('enemySheet.png');
    late final spriteSheet = SpriteSheet.fromColumnsAndRows(
      image: images.fromCache('enemySheet.png'),
      columns: 2,
      rows: 1,
    );

    // _enemyManager = EnemyManager(spriteSheet: spriteSheet);
    // add(_enemyManager);
  }

  @override
  Future<void> onTapDown(TapDownInfo info) async {
    super.onTapDown(info);
    var spriteSheetBullet = await images.load('shotSheet.png');
    SpriteAnimationData spriteData = SpriteAnimationData.sequenced(
        amount: 13,
        stepTime: .1,
        textureSize: Vector2(100, 100),
        loop: false,
        amountPerRow: 3);
    var bulletDesign =
        SpriteAnimationComponent.fromFrameData(spriteSheetBullet, spriteData)
          ..x = player.x + 30
          ..y = player.y + 20
          ..angle = pi * 1.5
          ..size = Vector2(150, 150);
    var bulletDesign2 =
        SpriteAnimationComponent.fromFrameData(spriteSheetBullet, spriteData)
          ..x = player.x
          ..y = player.y + 20
          ..angle = pi * 1.5
          ..size = Vector2(150, 150);

    Bullet bullet = Bullet(
      sprite: await loadSprite('shot4_5.png'),
      position: player.position - Vector2(-25, 0),
      size: Vector2(100, 100),
    );
    bullet.anchor = Anchor.center;

    Bullet bullet2 = Bullet(
      sprite: await loadSprite('shot4_5.png'),
      position: player.position - Vector2(-5, 50),
      size: Vector2(100, 100),
    );
    bullet.anchor = Anchor.center;
    add(bulletDesign);
    add(bulletDesign2);
    add(bullet);
    add(bullet2);
  }

  @override
  void update(double dt) {
    super.update(dt);
    player.position.add(joystick.relativeDelta * 400 * dt);
  }
}
