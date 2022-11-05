import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flutter_game/game/player.dart';
import 'package:flutter_game/game_manager.dart';
import 'dart:math';

class BulletAnimation extends SpriteAnimationComponent
    with HasGameRef<GameManager> {
  late Player _player;

  BulletAnimation();
  @override
  Future<void> onLoad() async {
    super.onLoad();

    var spriteSheetBullet = await Images().load('shotSheet.png');
    SpriteAnimationData spriteData = SpriteAnimationData.sequenced(
        amount: 13,
        stepTime: .1,
        textureSize: Vector2(100, 100),
        loop: false,
        amountPerRow: 3);
    var bulletDesign =
        SpriteAnimationComponent.fromFrameData(spriteSheetBullet, spriteData)
          ..x = _player.x + 30
          ..y = _player.y + 20
          ..angle = pi * 1.5
          ..size = Vector2(150, 150);
    var bulletDesign2 =
        SpriteAnimationComponent.fromFrameData(spriteSheetBullet, spriteData)
          ..x = _player.x
          ..y = _player.y + 20
          ..angle = pi * 1.5
          ..size = Vector2(150, 150);

    add(bulletDesign);
    add(bulletDesign2);
  }
}
