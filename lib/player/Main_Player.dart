import 'package:bonfire/bonfire.dart';

import '../GreenNinjaGame.dart';

class Kinght extends SimplePlayer {

  Kinght(Vector2 position)
      : super(
    position: position,
    size: Vector2(tiledSize,tiledSize),
    animation: PlayerSpriteSheet2.simpleDirectionAnimation,
    life: 200,
    speed: 100,
    initDirection: Direction.down,
  );
}



class PlayerSpriteSheet2 {

  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
    "knight_idle.png",
    SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.1,
      textureSize: Vector2(16, 16),
    ),
  );

  static Future<SpriteAnimation> get idleLeft => SpriteAnimation.load(
    "knight_idle_left.png",
    SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.1,
      textureSize: Vector2(16, 16),
    ),
  );

  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
    "knight_run.png",
    SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.1,
      textureSize: Vector2(16, 16),
    ),
  );

  static Future<SpriteAnimation> get runLeft => SpriteAnimation.load(
    "knight_run_left.png",
    SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.1,
      textureSize: Vector2(16, 16),
    ),
  );

  static SimpleDirectionAnimation get simpleDirectionAnimation =>
      SimpleDirectionAnimation(
        idleRight: idleRight,
        idleLeft: idleLeft,
        runRight: runRight,
        runLeft: runLeft,
      );
}