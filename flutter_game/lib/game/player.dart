import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' hide Image;

import 'package:flame/components.dart';

class Player extends FlameGame {
  late SpriteAnimationComponent plane;

  showPlane() {
    Image planeImage = images.load('Ship6.png') as Image;
    var planeAnimation = SpriteAnimation.fromFrameData(
        planeImage,
        SpriteAnimationData.sequenced(
            amount: 1, stepTime: 0.1, textureSize: Vector2(120, 120)));
    return plane = SpriteAnimationComponent()
      ..anchor = Anchor.center
      ..animation = planeAnimation
      ..size = Vector2(80, 80) * 1.0
      ..position = Vector2(150, 300);
  }

  void addToScore(int killPoint) {}
}
