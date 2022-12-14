import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter_game/game_manager.dart';
import 'package:flame_audio/flame_audio.dart';

import '../game/game.dart';

class Explosion extends SpriteAnimationComponent with HasGameRef<GameManager> {
  @override
  Future<void>? onLoad() async {
    var spriteSheet = SpriteSheet(
        image: await Images().load('explosion.png'),
        srcSize: Vector2(32.0, 32.0));

    animation = spriteSheet.createAnimation(row: 0, stepTime: 0.1, loop: false);
    animation!.onComplete = _onComplete;
    width = 40;
    height = 40;
    anchor = Anchor.center;
    FlameAudio.play('explosion.mp3');
  }

  void _onComplete() {
    removeFromParent();
  }
}
