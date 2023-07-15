import 'package:bonfire/bonfire.dart';
import 'package:bonfire_flutter_game/player/Main_Player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../MainGame.dart';
import '../constant/NameOfMaps.dart';

bool isobserve = false ;
class Demon extends SimpleEnemy with ObjectCollision , AutomaticRandomMovement ,UseBarLife{

  Demon(Vector2 position)
      : super(
    life: 150,
    position: position,
    size: Vector2(tiledSize,tiledSize),
    animation: PlayerSpriteSheet.simpleDirectionAnimation,
    speed: 80,
    initDirection: Direction.down,
  ){
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
  void die() {
    gameRef.camera.shake(intensity: 4);
    removeFromParent();


    // bool dropPickup = Random().nextBool();
    // if (dropPickup) {
    //   gameRef.add(Medipack(position: position));
    // }

    super.die();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!gameRef.sceneBuilderStatus.isRunning)
    {
      isobserve = false ;
      seeAndMoveToPlayer(
        closePlayer: (Player) {
          if (!Player.isDead)
          {
            simpleAttackMelee(
                withPush: false,
                damage: damagePlayer * 2.5 ,
                size: size,
                animationRight: PlayerSpriteSheet2.CutSlash()
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

  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
    "Enemy/demon_cyclop_idle.png",
    SpriteAnimationData.sequenced(
      amount: 5,
      stepTime: 0.2,
      textureSize: Vector2(50, 50),
    ),
  );
  static Future<SpriteAnimation> get RunRight => SpriteAnimation.load(
    "Enemy/demon_cyclop_walk.png",
    SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.2,
      textureSize: Vector2(50, 50),
    ),
  );

  static SimpleDirectionAnimation get simpleDirectionAnimation =>
      SimpleDirectionAnimation(
        idleRight: idleRight, runRight: RunRight,
      );
}