
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

double damage = 10 ;
class Dog_Black extends SimpleEnemy with ObjectCollision , AutomaticRandomMovement ,UseBarLife{

  Dog_Black(Vector2 position )
      : super(
    position: position,
    size: Vector2(tiledSize,tiledSize),
    animation:PlayerSpriteSheet.simpleDirectionAnimation ,
    life: 120,
    speed: 85,
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

    SFX ? FlameAudio.play('Punch_enemy.wav') : null ;
    showDamage(
      damage,
      config: TextStyle(fontSize: width / 3, color: Colors.red),
    );

    super.receiveDamage(attacker, damage, identify);
  }
  @override
  Future<void> die() async {
    SFX ? FlameAudio.play('wolf_dying.mp3') : null ;
    removeFromParent();
    lastDirectionHorizontal == Direction.right ? gameRef.add(Dog_death(position: position)) : gameRef.add(Dog_death_L(position: position)) ;
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

                SFX ? FlameAudio.play('wolf_attack.mp3') : null ;
                lastDirectionHorizontal == Direction.right ?animation?.playOnce(PlayerSpriteSheet.Dog_attack(),runToTheEnd: true,flipX: true): animation?.playOnce(PlayerSpriteSheet.Dog_attack(),runToTheEnd: true);
              }
            );
          }
        },
        observed: () {
          isobserve = true ;
        },
        radiusVision:200,
      );

    }
    super.update(dt);
  }

}



class PlayerSpriteSheet {

  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
    "Enemy/Dogs/Canine_Black_Run_Right.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.2,
      textureSize: Vector2(48, 32),
    ),
  );
  static Future<SpriteAnimation> get runLeft => SpriteAnimation.load(
    "Enemy/Dogs/Canine_Black_Run.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.2,
      textureSize: Vector2(48, 32),
    ),
  );

  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
    "Enemy/Dogs/Canine_Black_Death_Right.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.2,
      textureSize: Vector2(48, 32),
    ),
  );
  static Future<SpriteAnimation> get idleLeft => SpriteAnimation.load(
    "Enemy/Dogs/Canine_Black_Idle.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.2,
      textureSize: Vector2(48, 32),
    ),
  );


  static Future<SpriteAnimation>  Dog_attack() => SpriteAnimation.load(
    "Enemy/Dogs/Canine_Black_Attack.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.2,
      textureSize: Vector2(48, 32),
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
