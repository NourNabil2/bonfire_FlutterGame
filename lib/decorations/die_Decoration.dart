


import 'package:bonfire/bonfire.dart';
import 'package:flutter/cupertino.dart';


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


class Rat_death extends GameDecoration {
  Rat_death({required Vector2 position})
      : super.withAnimation(animation: SpriteAnimation.load(

    "Enemy/Rats/Rat_Death.png",
    SpriteAnimationData.sequenced(amount: 5, stepTime: 0.1, textureSize: Vector2(64, 64),loop: false )

  ), position: position, size: Vector2.all(64.64));
}

class Player_death extends GameDecoration {
  Player_death({required Vector2 position})
      : super.withAnimation(animation: SpriteAnimation.load(

    "Player/MainMovement/die_L.png",
    SpriteAnimationData.sequenced(amount: 1, stepTime: 0.1, textureSize: Vector2(50, 37),loop: false ),

  ),position: position, size: Vector2.all(50.37));
}
class Player_death_R extends GameDecoration {
  Player_death_R({required Vector2 position})
      : super.withAnimation(animation: SpriteAnimation.load(

    "Player/MainMovement/die.png",
    SpriteAnimationData.sequenced(amount: 1, stepTime: 0.1, textureSize: Vector2(50, 37),loop: false ),

  ),position: position, size: Vector2.all(50.37));
}

