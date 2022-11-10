import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

import '../game_manager.dart';

class Background extends SpriteAnimationComponent with HasGameRef<GameManager> {
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
  }
}
