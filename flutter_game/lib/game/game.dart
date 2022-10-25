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
  late SpriteAnimationComponent plane;
  late final JoystickComponent joystick;
  late EnemyManager _enemyManager;
  SpriteAnimationComponent bulletDesign = SpriteAnimationComponent();
  late SpriteSheet spriteSheet;
  Random random = Random();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    ParallaxComponent _stars = await ParallaxComponent.load(
      [ParallaxImageData('background.png')],
      repeat: ImageRepeat.repeat,
      baseVelocity: Vector2(0, -60),
      velocityMultiplierDelta: Vector2(0, 1.5),
    );
    add(_stars);

    Image planeImage = await images.load('player.png');
    var planeAnimation = SpriteAnimation.fromFrameData(
        planeImage,
        SpriteAnimationData.sequenced(
            amount: 1, stepTime: 0.1, textureSize: Vector2(250, 250)));
    plane = SpriteAnimationComponent()
      ..anchor = Anchor.center
      ..animation = planeAnimation
      ..size = Vector2(80, 80) * 1.0
      ..position = Vector2(150, 300);
    plane.anchor = Anchor.center;
    add(plane);

    final knobPaint = BasicPalette.lightRed.withAlpha(100).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 30, paint: knobPaint),
      background: CircleComponent(radius: 50, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 25, bottom: 40),
    );
    add(joystick);

    // _enemyManager = EnemyManager(spriteSheet: spriteSheet);
    // add(_enemyManager);
  }

  @override
  Future<void> onTapDown(TapDownInfo info) async {
    super.onTapDown(info);
    var spriteSheet2 = await images.load('shotSheet.png');
    SpriteAnimationData spriteData = SpriteAnimationData.sequenced(
        amount: 13,
        stepTime: .1,
        textureSize: Vector2(100, 100),
        loop: false,
        amountPerRow: 3);
    var bulletDesign =
        SpriteAnimationComponent.fromFrameData(spriteSheet2, spriteData)
          ..x = plane.x + 5
          ..y = plane.y
          ..angle = pi * 1.5
          ..size = Vector2(150, 150);
    var bulletDesign2 =
        SpriteAnimationComponent.fromFrameData(spriteSheet2, spriteData)
          ..x = plane.x - 26
          ..y = plane.y
          ..angle = pi * 1.5
          ..size = Vector2(150, 150);

    spriteSheet = SpriteSheet.fromColumnsAndRows(
      image: images.fromCache('shotSheet.png'),
      columns: 13,
      rows: 1,
    );
    Bullet bullet = Bullet(
      sprite: await loadSprite('shot4_5.png'),
      position: plane.position,
      size: Vector2(100, 100),
    );
    bullet.anchor = Anchor.center;

    Bullet bullet2 = Bullet(
      sprite: await loadSprite('shot4_5.png'),
      position: plane.position - Vector2(20, 50),
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
    plane.position.add(joystick.relativeDelta * 400 * dt);
  }
}
