
import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:bonfire_flutter_game/Enemy/Boss_Ninja.dart';
import 'package:bonfire_flutter_game/decorations/Items.dart';
import 'package:bonfire_flutter_game/player/Main_Player.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../MainGame.dart';
import '../constant/constant.dart';
import '../decorations/die_Decoration.dart';
bool isobserve = false ;
double sizeS = 30 ;
double damage = 20 ;
class Skeleton extends SimpleEnemy with ObjectCollision , AutomaticRandomMovement ,UseBarLife{

  Skeleton(Vector2 position )
      : super(
    position: position,
    size: Vector2(15,20),
    animation:PlayerSpriteSheet.simpleDirectionAnimation ,
    life: 100,
    speed: 80,
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
          align: Vector2(0, 16),
        ),
      ]),
    );

  }
  @override
  void receiveDamage(AttackFromEnum attacker, double damage, identify) {
    lastDirectionHorizontal == Direction.right ? animation?.playOnce(PlayerSpriteSheet.Hit(),runToTheEnd: true,size: Vector2.all(sizeS)) :animation?.playOnce(PlayerSpriteSheet.Hit(),runToTheEnd: true,flipX: true,size: Vector2.all(sizeS)) ;
    SFX ? FlameAudio.play('Punch_enemy.wav') : null ;
    showDamage(
      damage,
      config: TextStyle(fontSize: width / 3, color: Colors.red),

    );

    super.receiveDamage(attacker, damage, identify);
  }
  @override
  Future<void> die() async {
    SFX ? FlameAudio.play('skeleton-dying.mp3') : null ;
    removeFromParent();
    lastDirectionHorizontal == Direction.right ? gameRef.add(Skeleton_Death_R(position: position)) : gameRef.add(Skeleton_Death_L(position: position)) ;
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
              execute: () {
                SFX ? FlameAudio.play('slash.mp3') : null ;
                lastDirectionHorizontal == Direction.right ? animation?.playOnce(PlayerSpriteSheet.attack_R(),runToTheEnd: true,size: Vector2.all(sizeS)) : animation?.playOnce(PlayerSpriteSheet.attack_R(),size: Vector2.all(sizeS),runToTheEnd: true,flipX: true) ;
              }
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
  static Future<SpriteAnimation> Hit() => SpriteAnimation.load('Enemy/Skeleton/Skeleton Hit.png', SpriteAnimationData.sequenced(amount: 8, stepTime: 0.1, textureSize: Vector2(30, 32)));

static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
    "Enemy/Skeleton/Skeleton Walk.png",
    SpriteAnimationData.sequenced(
      amount: 13,
      stepTime: 0.2,
      textureSize: Vector2(22, 32),
    ),
  );
  static Future<SpriteAnimation> get runLeft => SpriteAnimation.load(
    "Enemy/Skeleton/Skeleton_Walk_Left.png",
    SpriteAnimationData.sequenced(
      amount: 13,
      stepTime: 0.2,
      textureSize: Vector2(22, 32),
    ),
  );

  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
    "Enemy/Skeleton/Skeleton Idle.png",
    SpriteAnimationData.sequenced(
      amount: 11,
      stepTime: 0.2,
      textureSize: Vector2(24, 32),
    ),
  );
  static Future<SpriteAnimation> get idleLeft => SpriteAnimation.load(
    "Enemy/Skeleton/Skeleton_Idle_Left.png",
    SpriteAnimationData.sequenced(
      amount: 11,
      stepTime: 0.2,
      textureSize: Vector2(24, 32),
    ),
  );


  static Future<SpriteAnimation>  attack_R() => SpriteAnimation.load(
    "Enemy/Skeleton/Skeleton Attack.png",
    SpriteAnimationData.sequenced(
      amount: 18,
      stepTime: 0.09,
      textureSize: Vector2(43, 37),
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
