
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

double damage = 15 ;
class Dog_White extends SimpleEnemy with ObjectCollision , AutomaticRandomMovement ,UseBarLife{

  Dog_White(Vector2 position )
      : super(
    position: position,
    size: Vector2(tiledSize,tiledSize),
    animation:PlayerSpriteSheet.simpleDirectionAnimation ,
    life: 100,
    speed: 90,
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
    lastDirectionHorizontal == Direction.right ? gameRef.add(Dog_death2(position: position)) : gameRef.add(Dog_death_L2(position: position)) ;
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
            SFX ? FlameAudio.play('wolf_attack.mp3') : null ;

            simpleAttackMelee(
              withPush: false,
              damage: damage ,
              size: size,
              execute: () => lastDirectionHorizontal == Direction.right ?animation?.playOnce(PlayerSpriteSheet.Dog_attack(),runToTheEnd: true,flipX: true): animation?.playOnce(PlayerSpriteSheet.Dog_attack(),runToTheEnd: true),
            );
          }
        },
        observed: () {
          isobserve = true ;
        },
        radiusVision:250,
      );

    }
    super.update(dt);
  }

}



class PlayerSpriteSheet {

  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
    "Enemy/Dogs/Canine_Gray_Run_R.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.2,
      textureSize: Vector2(48, 32),
    ),
  );
  static Future<SpriteAnimation> get runLeft => SpriteAnimation.load(
    "Enemy/Dogs/Canine_Gray_Run.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.2,
      textureSize: Vector2(48, 32),
    ),
  );

  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
    "Enemy/Dogs/Canine_Gray_Idle_R.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.2,
      textureSize: Vector2(48, 32),
    ),
  );
  static Future<SpriteAnimation> get idleLeft => SpriteAnimation.load(
    "Enemy/Dogs/Canine_Gray_Idle.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.2,
      textureSize: Vector2(48, 32),
    ),
  );


  static Future<SpriteAnimation>  Dog_attack() => SpriteAnimation.load(
    "Enemy/Dogs/Canine_Gray_Attack.png",
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
