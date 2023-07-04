


import 'package:bonfire/bonfire.dart';


class Bat_death extends GameDecoration {
  Bat_death({required Vector2 position})
      : super.withAnimation(animation: SpriteAnimation.load(

    "Enemy/Bats/Bat_Death.png",
    SpriteAnimationData([
      SpriteAnimationFrameData(srcPosition: Vector2(192, 0),
          srcSize: Vector2(64, 64),
          stepTime: 0.1),
      SpriteAnimationFrameData(
          srcPosition: Vector2(0, 64), srcSize: Vector2(64, 64), stepTime: 0.1),
      SpriteAnimationFrameData(srcPosition: Vector2(64, 64),
          srcSize: Vector2(64, 64),
          stepTime: 0.1),
      SpriteAnimationFrameData(srcPosition: Vector2(128, 64),
          srcSize: Vector2(64, 64),
          stepTime: 0.1),
      SpriteAnimationFrameData(srcPosition: Vector2(192, 64),
          srcSize: Vector2(64, 64),
          stepTime: 0.1),

      SpriteAnimationFrameData(srcPosition: Vector2(0, 128),
          srcSize: Vector2(64, 64),
          stepTime: 0.1),
      SpriteAnimationFrameData(srcPosition: Vector2(64, 128),
          srcSize: Vector2(64, 64),
          stepTime: 0.1),
      SpriteAnimationFrameData(srcPosition: Vector2(128, 128),
          srcSize: Vector2(64, 64),
          stepTime: 0.1),
    ], loop: false),

  ), position: position, size: Vector2.all(64.64));
}
