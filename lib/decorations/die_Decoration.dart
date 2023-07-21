


import 'package:bonfire/bonfire.dart';
import 'package:flutter/cupertino.dart';

import '../Enemy/Skeleton.dart';
import '../Enemy/Skull.dart';
import '../MainGame.dart';


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

class YOUDEATH extends GameDecoration {
  YOUDEATH({required Vector2 position})
      : super.withAnimation(animation: SpriteAnimation.load(
    "follower/summonDeath.png",
    SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.15,
      textureSize: Vector2(50, 50),
      loop: false

    ),
  ), position: position, size: Vector2.all(32));
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
      : super.withSprite(sprite: Sprite.load(

    "Player/MainMovement/die.png",
    srcSize: Vector2(50, 37),

  ),position: position, size: Vector2.all(50.37));
}

class Dog_death extends GameDecoration {
  Dog_death({required Vector2 position})
      : super.withAnimation(animation: SpriteAnimation.load(

      "Enemy/Dogs/Canine_Black_Death_Right.png",
      SpriteAnimationData.sequenced(amount: 8, stepTime: 0.1, textureSize: Vector2(48, 32),loop: false )

  ), position: position, size: Vector2.all(tiledSize));
}
class Dog_death_L extends GameDecoration {
  Dog_death_L({required Vector2 position})
      : super.withAnimation(animation: SpriteAnimation.load(

      "Enemy/Dogs/Canine_Black_Death_Left.png",
      SpriteAnimationData.sequenced(amount: 8, stepTime: 0.1, textureSize: Vector2(48, 32),loop: false )

  ), position: position, size: Vector2.all(tiledSize));
}
class Dog_death2 extends GameDecoration {
  Dog_death2({required Vector2 position})
      : super.withAnimation(animation: SpriteAnimation.load(

      "Enemy/Dogs/Canine_Gray_Death.png",
      SpriteAnimationData.sequenced(amount: 8, stepTime: 0.1, textureSize: Vector2(48, 32),loop: false )

  ), position: position, size: Vector2.all(tiledSize));
}
class Dog_death_L2 extends GameDecoration {
  Dog_death_L2({required Vector2 position})
      : super.withAnimation(animation: SpriteAnimation.load(

      "Enemy/Dogs/Canine_Gray_Death_L.png",
      SpriteAnimationData.sequenced(amount: 8, stepTime: 0.1, textureSize: Vector2(48, 32),loop: false )

  ), position: position, size: Vector2.all(tiledSize));
}

class Skeleton_Death_R extends GameDecoration {
  Skeleton_Death_R({required Vector2 position})
      : super.withAnimation(animation: SpriteAnimation.load(

      "Enemy/Skeleton/Skeleton Dead.png",
      SpriteAnimationData.sequenced(amount: 15, stepTime: 0.1, textureSize: Vector2(33, 32),loop: false )

  ), position: position, size: Vector2.all(sizeS));
}
class Skeleton_Death_L extends GameDecoration {
  Skeleton_Death_L({required Vector2 position})
      : super.withAnimation(animation: SpriteAnimation.load(

      "Enemy/Skeleton/Skeleton_Dead_Left.png",
      SpriteAnimationData.sequenced(amount: 15, stepTime: 0.1, textureSize: Vector2(33, 32),loop: false )

  ), position: position, size: Vector2.all(sizeS));
}

class witch_death extends GameDecoration {
  witch_death({required Vector2 position})
      : super.withAnimation(animation: SpriteAnimation.load(

      "Enemy/Wizard/B_witch_death.png",
      SpriteAnimationData.sequenced(amount: 6, stepTime: 0.1, textureSize: Vector2(32, 32),loop: false )

  ), position: position, size: Vector2.all(sizeS));
}


class Skull_Die extends GameDecoration {
  Skull_Die({required Vector2 position})
      : super.withAnimation(animation: SpriteAnimation.load(

      "Enemy/Skull/Skull_Death.png",
      SpriteAnimationData.sequenced(amount: 10, stepTime: 0.1, textureSize: sizeSkull,loop: false )

  ), position: position, size: sizeSkull);
}
class Skull_Die_L extends GameDecoration {
  Skull_Die_L({required Vector2 position})
      : super.withAnimation(animation: SpriteAnimation.load(

      "Enemy/Skull/Skull_Death_L.png",
      SpriteAnimationData.sequenced(amount: 10, stepTime: 0.1, textureSize: sizeSkull,loop: false )

  ), position: position, size: sizeSkull);
}

