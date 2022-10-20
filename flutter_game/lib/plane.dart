import 'package:flame/collisions.dart';
import 'package:flame/events.dart';
import 'package:flame/image_composition.dart';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter_game/bullet.dart';

void main(List<String> args) {
  final game = Plane();
  runApp(GameWidget(game: game));
}

class Plane extends FlameGame with HasDraggables, TapDetector, PanDetector {
  late SpriteAnimationComponent plane;
  late final JoystickComponent joystick;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    SpriteComponent background = SpriteComponent()
      ..sprite = await loadSprite('background.png')
      ..size = size;
    add(background);

    Image planeImage = await images.load('Ship6.png');
    var planeAnimation = SpriteAnimation.fromFrameData(
        planeImage,
        SpriteAnimationData.sequenced(
            amount: 1, stepTime: 0.1, textureSize: Vector2(120, 120)));
    plane = SpriteAnimationComponent()
      ..anchor = Anchor.center
      ..animation = planeAnimation
      ..size = Vector2(80, 80) * 1.0
      ..position = Vector2(225, 500);
    add(plane);

    final knobPaint = BasicPalette.lightRed.withAlpha(50).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(50).paint();
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 30, paint: knobPaint),
      background: CircleComponent(radius: 50, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );
    add(joystick);
  }

  @override
  void update(double dt) {
    super.update(dt);
    plane.position.add(joystick.relativeDelta * 300 * dt);
  }
}
