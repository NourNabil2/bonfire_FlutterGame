
import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:bonfire_flutter_game/Enemy/Boss_Ninja.dart';
import 'package:bonfire_flutter_game/decorations/Items.dart';
import 'package:bonfire_flutter_game/player/Main_Player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../MainGame.dart';
import '../decorations/die_enemy.dart';
bool isobserve = false ;

double damage = 10 ;
class Bat_purble extends SimpleEnemy with ObjectCollision , AutomaticRandomMovement ,UseBarLife{

  Bat_purble(Vector2 position )
      : super(
    position: position,
    size: Vector2(tiledSize,tiledSize),
    animation:PlayerSpriteSheet.simpleDirectionAnimation ,
    life: 100,
    speed: 50,
    initDirection: Direction.down,
  )
  {
    setupBarLife(
      barLifePosition: BarLifePorition.top,
      showLifeText: false,
      borderRadius: BorderRadius.circular(2),
      borderWidth: 2,

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
      config: TextStyle(fontSize: width / 3, color: Colors.red),
    );

    super.receiveDamage(attacker, damage, identify);
  }
  @override
  Future<void> die() async {
     removeFromParent();
    gameRef.add(Bat_death(position: position));
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
                damage: damage *2 ,
                size: size,
                animationRight: PlayerSpriteSheet.bat_attack(),
            );
          }
        },
        observed: () {
          isobserve = true ;
        },
        radiusVision:80,
      );

    }
    super.update(dt);
  }

}



class PlayerSpriteSheet {

  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
      "Enemy/Bats/Bat_Fly.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.2,
      textureSize: Vector2(64, 64),
    ),
  );
  static Future<SpriteAnimation> get runLeft => SpriteAnimation.load(
      "Enemy/Bats/Bat_Fly_Left.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.2,
      textureSize: Vector2(64, 64),
    ),
  );
  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
      "Enemy/Bats/Bat_idle.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.2,
      textureSize: Vector2(64, 64),
    ),
  );
  static Future<SpriteAnimation> get idleLeft => SpriteAnimation.load(
      "Enemy/Bats/Bat_idle_left.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.2,
      textureSize: Vector2(64, 64),
    ),
  );

  static Future<SpriteAnimation> get bat_death => SpriteAnimation.load(
      "Enemy/Bats/Bat_Death.png",
    SpriteAnimationData([
      SpriteAnimationFrameData(srcPosition: Vector2(192, 0), srcSize: Vector2(16, 16), stepTime: 0.1),
      SpriteAnimationFrameData(srcPosition: Vector2(0, 64), srcSize: Vector2(16, 16), stepTime: 0.1),
      SpriteAnimationFrameData(srcPosition: Vector2(64, 64), srcSize: Vector2(16, 16), stepTime: 0.1),
      SpriteAnimationFrameData(srcPosition: Vector2(128, 64), srcSize: Vector2(16, 16), stepTime: 0.1),
      SpriteAnimationFrameData(srcPosition: Vector2(192, 64), srcSize: Vector2(16, 16), stepTime: 0.1),

      SpriteAnimationFrameData(srcPosition: Vector2(0, 128), srcSize: Vector2(16, 16), stepTime: 0.1),
      SpriteAnimationFrameData(srcPosition: Vector2(64, 128), srcSize: Vector2(16, 16), stepTime: 0.1),
      SpriteAnimationFrameData(srcPosition: Vector2(128, 128), srcSize: Vector2(16, 16), stepTime: 0.1),
    ]),
  );


  static Future<SpriteAnimation>  bat_attack() => SpriteAnimation.load(
      "Enemy/Bats/Bat_Attack_FX.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.2,
      textureSize: Vector2(64, 64),
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
