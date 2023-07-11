// ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names
import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import '../MainGame.dart';
import '../decorations/die_Decoration.dart';
import '../player/Main_Player.dart';
bool isobserve = false ;

double damage = 5 ;
class Rat extends SimpleEnemy with ObjectCollision , AutomaticRandomMovement ,UseBarLife{

  Rat(Vector2 position )
      : super(
    position: position,
    size: Vector2(40,40),
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
    gameRef.add(Rat_death(position: position));
    super.die();
  }


  @override
  void update(double dt)  {

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
              animationRight: PlayerSpriteSheet.Rat_attack(),
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
    "Enemy/Rats/Rat_Run.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.2,
      textureSize: Vector2(64, 64),
    ),
  );
  static Future<SpriteAnimation> get runLeft => SpriteAnimation.load(
    "Enemy/Rats/Rat_Run_Left.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.2,
      textureSize: Vector2(64, 64),
    ),
  );
  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
    "Enemy/Rats/Rat_Idle.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.2,
      textureSize: Vector2(64, 64),
    ),
  );
  static Future<SpriteAnimation> get idleLeft => SpriteAnimation.load(
    "Enemy/Rats/Rat_Idle_left.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.2,
      textureSize: Vector2(64, 64),
    ),
  );

  static Future<SpriteAnimation>  Rat_attack() => SpriteAnimation.load(
    "Enemy/Rats/Rat_Attack_FX.png",
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
