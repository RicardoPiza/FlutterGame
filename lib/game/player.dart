import 'package:flame/components.dart';

class Player extends SpriteComponent {
  Player({
    Sprite? sprite,
    Vector2? position,
    Vector2? size,
  }) : super(
          sprite: sprite,
          position: position,
          size: size,
        );

  void addToScore(int killPoint) {}
}
// Image planeImage = await images.load('player.png');
    // var planeAnimation = SpriteAnimation.fromFrameData(
    //     planeImage,
    //     SpriteAnimationData.sequenced(
    //         amount: 1, stepTime: 0.1, textureSize: Vector2(250, 250)));
    // player = SpriteAnimationComponent()
    //   ..anchor = Anchor.center
    //   ..animation = planeAnimation
    //   ..size = Vector2(80, 80) * 1.0
    //   ..position = Vector2(150, 300);
    // player.anchor = Anchor.center;
    // add(player);