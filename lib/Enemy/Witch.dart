
import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:bonfire_flutter_game/Enemy/Boss_Ninja.dart';
import 'package:bonfire_flutter_game/decorations/Items.dart';
import 'package:bonfire_flutter_game/player/Main_Player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../MainGame.dart';
import '../decorations/Gate_translate.dart';
import '../decorations/die_Decoration.dart';
bool isobserve = false ;
Vector2 sizeS = Vector2(32, 48) ;
double damage = 20 ;
class Witch extends SimpleEnemy with ObjectCollision , AutomaticRandomMovement ,UseBarLife{

  Witch(Vector2 position )
      : super(
    position: position,
    size: sizeS,
    animation:PlayerSpriteSheet.simpleDirectionAnimation ,
    life: 500,
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

    // FlameAudio.play(Globals.explosionSound);
    lastDirectionHorizontal == Direction.right ?  animation?.playOnce(SpriteAnimation.load(
        "Enemy/Wizard/B_witch_take_damage.png",
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.1,
          textureSize: sizeS,
        ),
      ) ) : animation?.playOnce(SpriteAnimation.load(
      "Enemy/Wizard/B_witch_take_damage.png",
      SpriteAnimationData.sequenced(
        amount: 3,
        stepTime: 0.1,
        textureSize: sizeS,
      ),
    ) ,flipX: true) ;
    showDamage(
      damage,
      config: TextStyle(fontSize: width / 3, color: Colors.red),
    );

    super.receiveDamage(attacker, damage, identify);
  }
  @override
  Future<void> die() async {
    removeFromParent();
    gameRef.add(witch_death(position: position)) ;
    gameRef.add(Portal(position: position + Vector2(50, 50) ));
    gameRef.add(Key_Gold(position: position + Vector2(50, 100) ));
    super.die();
  }


  void update(double dt) {

    if (!gameRef.sceneBuilderStatus.isRunning)
    {
      isobserve = false ;
      seeAndMoveToPlayer(
        radiusVision:100,
        closePlayer: (Player) {
          if (!Player.isDead)
          {
            simpleAttackMelee(
              withPush: false,
              damage: damage ,
              size: size,
              animationRight: SpriteAnimation.load(
                "Enemy/Wizard/B_witch_attack_ٍFX.png",
                SpriteAnimationData.sequenced(
                  amount: 8,
                  stepTime: 0.1,
                  textureSize: Vector2(71, 46),
                ),
              ),
              execute: () => lastDirectionHorizontal == Direction.right ? animation?.playOnce(PlayerSpriteSheet.attack_R(),runToTheEnd: true,size: sizeS) : animation?.playOnce(PlayerSpriteSheet.attack_R(),size: sizeS,runToTheEnd: true,flipX: true) ,
            );
          }
        },
        observed: () {
          isobserve = true ;
        },
      );


      if (!isobserve)
      {
        seeAndMoveToAttackRange(
          minDistanceFromPlayer: 150,
          positioned: (Player) {
            if (!Player.isDead)
            {
              simpleAttackRange(
                  speed: 500,
                  damage: damage/2,
                  animationDestroy: PlayerSpriteSheet3.SmokeAnimation(),
                  animationRight: PlayerSpriteSheet2.Wave_R(),
                  collision: CollisionConfig(collisions: [ CollisionArea.rectangle(
                    size: Vector2(8, 8),
                    //align: Vector2(width * 0.25, width * 0.25),

                  ),]),
                  size: size  );
            }
          } ,
          radiusVision: 150,
          runOnlyVisibleInScreen: false,
          notObserved: () {
            runRandomMovement(dt,maxDistance: 70,minDistance: 30);
          },
        );
      }

    }
    super.update(dt);
  }

}



class PlayerSpriteSheet {

  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
    "Enemy/Wizard/B_witch_run.png",
    SpriteAnimationData.sequenced(
      amount: 8,
      stepTime: 0.2,
      textureSize: sizeS,
    ),
  );
  static Future<SpriteAnimation> get runLeft => SpriteAnimation.load(
    "Enemy/Wizard/B_witch_run_Left.png",
    SpriteAnimationData.sequenced(
      amount: 8,
      stepTime: 0.2,
      textureSize: sizeS,
    ),
  );

  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
    "Enemy/Wizard/B_witch_idle.png",
    SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.2,
      textureSize: sizeS,
    ),
  );
  static Future<SpriteAnimation> get idleLeft => SpriteAnimation.load(
    "Enemy/Wizard/B_witch_idle_Left.png",
    SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.2,
      textureSize: sizeS,
    ),
  );


  static Future<SpriteAnimation>  attack_R() => SpriteAnimation.load(
    "Enemy/Wizard/B_witch_attack1.png",
    SpriteAnimationData.sequenced(
      amount: 9,
      stepTime: 0.09,
      textureSize: sizeS,
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
