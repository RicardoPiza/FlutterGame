import 'package:flame/image_composition.dart';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart' hide Image;

void main(List<String> args) {
  final game = Plane();
  runApp(GameWidget(game: game));
}

class Plane extends FlameGame with HasDraggables {
  late SpriteAnimationComponent plane;
  late final JoystickComponent joystick;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    Image planeImage = await images.load('aeroplane-transport-svgrepo-com.png');
    var planeAnimation = SpriteAnimation.fromFrameData(
        planeImage,
        SpriteAnimationData.sequenced(
            amount: 14, stepTime: 0.1, textureSize: Vector2(32, 34)));
    plane = SpriteAnimationComponent()
      ..anchor = Anchor.center
      ..animation = null
      ..size = Vector2(30, 30) * 1.0
      ..position = Vector2(150, 300);
    add(plane);
    final knobPaint = BasicPalette.lightRed.withAlpha(100).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();
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
