
import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:bonfire_flutter_game/Enemy/Boss_Ninja.dart';
import 'package:bonfire_flutter_game/decorations/Items.dart';
import 'package:bonfire_flutter_game/player/Main_Player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../MainGame.dart';
import '../decorations/die_Decoration.dart';
import 'Bringer.dart';
bool isobserve = false ;
Vector2 sizeSkull = Vector2(64, 64);
double damage = 10 ;
int die_Skull = 0 ;
class Skull extends SimpleEnemy with ObjectCollision , AutomaticRandomMovement ,UseBarLife{

  Skull(Vector2 position )
      : super(
    position: position,
    size: Vector2(64,64),
    animation:  PlayerSpriteSheet.simpleDirectionAnimation ,
    life: 80,
    speed: 50,
    initDirection: Direction.down,
  )
  {
    setupBarLife(
      barLifePosition: BarLifePorition.top,
      showLifeText: false,
      size: Vector2(10, 1),
      borderWidth: 0,


    );
    setupCollision(
      CollisionConfig(collisions: [
        CollisionArea.rectangle(
          size: Vector2(16, 16),
          align: Vector2(16, 16),
        ),
      ]),
    );

  }
  @override
  void receiveDamage(AttackFromEnum attacker, double damage, identify) {
    // FlameAudio.play(Globals.explosionSound);
    showDamage(
      damage,
      config: TextStyle(fontSize: width / 3, color: Colors.red,fontWeight: FontWeight.bold),
    );

    super.receiveDamage(attacker, damage, identify);
  }
  @override
  Future<void> die() async {
    if (die_Skull == 8)
    {
      gameRef.add(Bringer(Vector2(1140,270)));
    }
    else
    {
      die_Skull++ ;
    }
    removeFromParent();
    lastDirectionHorizontal == Direction.right ? gameRef.add(Skull_Die(position: position)) : gameRef.add(Skull_Die_L(position: position)) ;
    super.die();
  }


  void update(double dt) {

    if (!gameRef.sceneBuilderStatus.isRunning)
    {
      isobserve = false ;
      seeAndMoveToPlayer(
        closePlayer: (Player) {
          if (!Player.isDead)
          {
            simpleAttackMelee(
              withPush: false,
              damage: damage ,
              size: size,
             animationRight: PlayerSpriteSheet.FXhit(),
            );
          }
        },
        observed: () {
          isobserve = true ;
        },
        radiusVision:150,
      );

    }
    super.update(dt);
  }

}



class PlayerSpriteSheet {

  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
    "Enemy/Skull/Skull_Fly.png",
    SpriteAnimationData.sequenced(
      amount:8,
      stepTime: 0.2,
      textureSize:sizeSkull,
    ),
  );
  static Future<SpriteAnimation> get runLeft => SpriteAnimation.load(
    "Enemy/Skull/Skull_Fly_L.png",
    SpriteAnimationData.sequenced(
      amount:8,
      stepTime: 0.2,
      textureSize: sizeSkull,
    ),
  );

  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
    "Enemy/Skull/Skull_Idle.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.2,
      textureSize: sizeSkull,
    ),
  );
  static Future<SpriteAnimation> get idleLeft => SpriteAnimation.load(
    "Enemy/Skull/Skull_Idle_L.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.2,
      textureSize: sizeSkull,
    ),
  );

  static Future<SpriteAnimation>  FXhit() => SpriteAnimation.load(
    "Effects/SP.png",
    SpriteAnimationData.sequenced(
      amount: 7,
      stepTime: 0.1,
      textureSize: Vector2(67, 32),
    ),
  );





  //////////////////////////////////////
  static SimpleDirectionAnimation get simpleDirectionAnimation =>
      SimpleDirectionAnimation(
        idleRight: idleRight,
        idleLeft: idleLeft,
        runRight: runRight,
        runLeft: runLeft,
      );
}
