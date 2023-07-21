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
Vector2 sizeS = Vector2(93, 93) ;
double damage = 45 ;
class Bringer extends SimpleEnemy with ObjectCollision , AutomaticRandomMovement ,UseBarLife{

  Bringer(Vector2 position )
      : super(
    position: position,
    size: sizeS,
    animation:PlayerSpriteSheet.simpleDirectionAnimation ,
    life: 1000,
    speed: 60,
    initDirection: Direction.down,
  )
  {
    setupBarLife(
      barLifePosition: BarLifePorition.top,
      showLifeText: true,
      size: Vector2(40, 1),
      borderWidth: 0,


    );
    setupCollision(
      CollisionConfig(collisions: [
        CollisionArea.rectangle(
          size: Vector2(16, 32),
          align: Vector2(16, 64),
        ),
      ]),
    );

  }
  @override
  void receiveDamage(AttackFromEnum attacker, double damage, identify) {

    // FlameAudio.play(Globals.explosionSound);
    lastDirectionHorizontal == Direction.right ?  animation?.playOnce(SpriteAnimation.load(
      "Enemy/Bringer/Hit_R.png",
      SpriteAnimationData.sequenced(
        amount: 3,
        stepTime: 0.1,
        textureSize: sizeS,
      ),
    ) ) : animation?.playOnce(SpriteAnimation.load(
      "Enemy/Bringer/Hit_L.png",
      SpriteAnimationData.sequenced(
        amount: 3,
        stepTime: 0.1,
        textureSize: sizeS,
      ),)) ;
    showDamage(
      damage,
      config: TextStyle(fontSize: width / 3, color: Colors.red),
    );

    super.receiveDamage(attacker, damage, identify);
  }
  @override
  Future<void> die() async {
    gameRef.camera.shake(intensity: 4);
    removeFromParent();
    lastDirectionHorizontal == Direction.right ?  animation?.playOnce(SpriteAnimation.load(
      "Enemy/Bringer/Death_R.png",
      SpriteAnimationData.sequenced(
        amount: 3,
        stepTime: 0.1,
        textureSize: sizeS,
      ),
    ) ) : animation?.playOnce(SpriteAnimation.load(
      "Enemy/Bringer/Death_L.png",
      SpriteAnimationData.sequenced(
        amount: 3,
        stepTime: 0.1,
        textureSize: sizeS,
      ),)) ;

    gameRef.add(Portal(position: Vector2(600,120) ));
    super.die();
  }


  void update(double dt) {

    if (!gameRef.sceneBuilderStatus.isRunning)
    {
      isobserve = false ;
      seeAndMoveToPlayer(
        radiusVision:200,
        closePlayer: (Player) {
          if (!Player.isDead)
          {
            simpleAttackMelee(
              withPush: false,
              damage: damage ,
              size: size,
              execute: () => lastDirectionHorizontal == Direction.right ? animation?.playOnce(PlayerSpriteSheet.attack_R(),runToTheEnd: true,size: sizeS) : animation?.playOnce(PlayerSpriteSheet.attack_R(),size: sizeS,runToTheEnd: true,flipX: true) ,
            );
          }
        },
        observed: () {
          isobserve = true ;
        },
      );


    }
    super.update(dt);
  }

}



class PlayerSpriteSheet {

  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
    "Enemy/Bringer/Bringer-Walk_R.png",
    SpriteAnimationData.sequenced(
      amount: 8,
      stepTime: 0.2,
      textureSize: sizeS,
    ),
  );
  static Future<SpriteAnimation> get runLeft => SpriteAnimation.load(
    "Enemy/Bringer/Bringer-Walk_L.png",
    SpriteAnimationData.sequenced(
      amount: 8,
      stepTime: 0.2,
      textureSize: sizeS,
    ),
  );

  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
    "Enemy/Bringer/Bringer-Idle_R.png",
    SpriteAnimationData.sequenced(
      amount: 8,
      stepTime: 0.2,
      textureSize: sizeS,
    ),
  );
  static Future<SpriteAnimation> get idleLeft => SpriteAnimation.load(
    "Enemy/Bringer/Bringer-Idle_L.png",
    SpriteAnimationData.sequenced(
      amount: 8,
      stepTime: 0.2,
      textureSize: sizeS,
    ),
  );


  static Future<SpriteAnimation>  attack_R() => SpriteAnimation.load(
    "Enemy/Bringer/Attack_R.png",
    SpriteAnimationData.sequenced(
      amount: 9,
      stepTime: 0.09,
      textureSize: Vector2(140, 93),
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
