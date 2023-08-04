
import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:bonfire_flutter_game/Enemy/Boss_Ninja.dart';
import 'package:bonfire_flutter_game/SharedPreferences/Cash_Save.dart';
import 'package:bonfire_flutter_game/decorations/Items.dart';
import 'package:bonfire_flutter_game/player/Main_Player.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../MainGame.dart';
import '../constant/constant.dart';
import '../decorations/Gate_translate.dart';
import '../decorations/die_Decoration.dart';
bool isobserve = false ;
Vector2 sizeS = Vector2(80, 80) ;
double damage = 25 ;
class Nightmare extends SimpleEnemy with ObjectCollision , AutomaticRandomMovement ,UseBarLife{

  Nightmare(Vector2 position )
      : super(
    position: position,
    size: sizeS,
    animation:PlayerSpriteSheet.simpleDirectionAnimation ,
    life: 1000,
    speed: 101,
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
   animation?.playOnce(SpriteAnimation.load(
      "Enemy/Night/NightBorne_give_hit.png",
      SpriteAnimationData.sequenced(
        amount: 3,
        stepTime: 0.1,
        textureSize: sizeS,
      ),
    ) ,flipX: lastDirectionHorizontal == Direction.right ?  true : false) ;
    showDamage(
      damage,
      config: TextStyle(fontSize: width / 3, color: Colors.red),
    );

    super.receiveDamage(attacker, damage, identify);
  }
  @override
  Future<void> die() async {
    SFX ? FlameAudio.play('Night_die.wav') : null ;
    removeFromParent();
    gameRef.add(Night_death(position: position)) ;
    gameRef.add(Portal(position: Vector2(41*32, 35*32) ));
    super.die();
  }


  void update(double dt) {

    if (life == 500 )
      {
        add(PotionLife(position: position + Vector2(50, 50)));
        add(PotionLife(position: position + Vector2(35, 15)));
        add(PotionLife(position: position + Vector2(45, 10)));
      }
    if (!gameRef.sceneBuilderStatus.isRunning)
    {
      isobserve = false ;
      seeAndMoveToPlayer(
        radiusVision:100,
        closePlayer: (Player) {
          if (!Player.isDead)
          {
            SFX ? FlameAudio.play('Sword_Night.wav') : null ;
            simpleAttackMelee(
              withPush: false,
              damage: damage ,
              size: size,
              execute: () => animation?.playOnce(PlayerSpriteSheet.attack_R(),runToTheEnd: true,size: sizeS , flipX:  lastDirectionHorizontal == Direction.right ? false : true),
            );
          }
        },
        observed: () {
          gameRef.colorFilter?.animateTo(Colors.transparent);
          isobserve = true ;
        },
      );


    }
    super.update(dt);
  }

}



class PlayerSpriteSheet {

  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
    "Enemy/Night/NightBorne_run.png",
    SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.2,
      textureSize: Vector2(80, 80),
    ),
  );
  static Future<SpriteAnimation> get runLeft => SpriteAnimation.load(
    "Enemy/Night/NightBorne_run_Left.png",
    SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.2,
      textureSize: Vector2(80, 80),
    ),
  );

  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
    "Enemy/Night/NightBorne_Idle.png",
    SpriteAnimationData.sequenced(
      amount: 9,
      stepTime: 0.2,
      textureSize: Vector2(80, 80),
    ),
  );
  static Future<SpriteAnimation> get idleLeft => SpriteAnimation.load(
    "Enemy/Night/NightBorne_Idle_L.png",
    SpriteAnimationData.sequenced(
      amount: 9,
      stepTime: 0.2,
      textureSize: Vector2(80, 80),
    ),
  );


  static Future<SpriteAnimation>  attack_R() => SpriteAnimation.load(
    "Enemy/Night/NightBorne_hit.png",
    SpriteAnimationData.sequenced(
      amount: 12,
      stepTime: 0.08,
      textureSize: Vector2(80, 80),
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
