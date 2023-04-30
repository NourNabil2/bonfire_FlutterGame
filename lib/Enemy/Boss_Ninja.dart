
import 'package:bonfire/bonfire.dart';
import 'package:bonfire_flutter_game/player/Main_Player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../GreenNinjaGame.dart';
bool isobserve = false ;

double damage = 10 ;
class BossNinja extends SimpleEnemy with ObjectCollision , AutomaticRandomMovement ,UseBarLife{

  BossNinja(Vector2 position )
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
  void die() {
    gameRef.camera.shake(intensity: 4);
    removeFromParent();

    // bool dropPickup = Random().nextBool();
    // if (dropPickup) {
    //   gameRef.add(Medipack(position: position));
    // }

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
                animationRight: PlayerSpriteSheet2.CutSword()
            );
          }
        },
        observed: () {
          isobserve = true ;
        },
        radiusVision:80,
      );


      if (!isobserve)
      {
        seeAndMoveToAttackRange(
          minDistanceFromPlayer: 128,
          positioned: (Player) {
            if (!Player.isDead)
            {
              simpleAttackRange(
                  speed: 200,
                  damage: damage/2,
                  animationDestroy: PlayerSpriteSheet.SmokeAnimation(),
                  animationRight: PlayerSpriteSheet2.Shuriken(),
                  collision: CollisionConfig(collisions: [ CollisionArea.rectangle(
                    size: Vector2.all(width / 2),
                    align: Vector2(width * 0.25, width * 0.25),

                  ),]),
                  size: size  );
            }
          } ,
          radiusVision: 80,
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

  static Future<SpriteAnimation> SmokeAnimation() => SpriteAnimation.load(
      "smoke.png",
      SpriteAnimationData.variable(amount: 6 , stepTimes: [0.1 , 0.1 , 0.1 ,0.1 ], textureSize: Vector2(16, 16))
  );

  static Future<SpriteAnimation> get runDown => SpriteAnimation.load(
      "Boss.png",
      SpriteAnimationData.variable(amountPerRow: 1,amount: 4 , stepTimes: [0.1 , 0.1 , 0.1 ,0.1 ], textureSize: Vector2(16, 16))
  );
  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
      "Boss.png",
      SpriteAnimationData.range(amountPerRow: 4 ,amount: 4 , stepTimes: [0.1 , 0.1 , 0.1 ,0.1 ], textureSize: Vector2(16, 16), start: 3, end: 3)
  );
  static Future<SpriteAnimation> get idleLeft => SpriteAnimation.load(
      "Boss.png",
      SpriteAnimationData.range(amountPerRow: 3 ,amount: 3, stepTimes: [0.1 , 0.1 , 0.1 ,0.1 ], textureSize: Vector2(16, 16), start: 2, end: 2)
  );
  static Future<SpriteAnimation> get idleUp => SpriteAnimation.load(
    "Boss.png",
    SpriteAnimationData([
      SpriteAnimationFrameData(srcPosition: Vector2(16, 0), srcSize: Vector2(16, 16), stepTime: 0.1),
    ]),
  );
  static Future<SpriteAnimation> get idleDown => SpriteAnimation.load(
    "Boss.png",
    SpriteAnimationData([
      SpriteAnimationFrameData(srcPosition: Vector2(0, 0), srcSize: Vector2(16, 16), stepTime: 0.1),
    ]),
  );
  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
    "Boss.png",
    SpriteAnimationData([
      SpriteAnimationFrameData(srcPosition: Vector2(48, 0), srcSize: Vector2(16, 16), stepTime: 0.1),
      SpriteAnimationFrameData(srcPosition: Vector2(48, 16), srcSize: Vector2(16, 16), stepTime: 0.1),
      SpriteAnimationFrameData(srcPosition: Vector2(48, 32), srcSize: Vector2(16, 16), stepTime: 0.1),
      SpriteAnimationFrameData(srcPosition: Vector2(48, 48), srcSize: Vector2(16, 16), stepTime: 0.1),
    ]),

  );
  static Future<SpriteAnimation> get runLeft => SpriteAnimation.load(
    "Boss.png",
    SpriteAnimationData([
      SpriteAnimationFrameData(srcPosition: Vector2(32, 0), srcSize: Vector2(16, 16), stepTime: 0.1),
      SpriteAnimationFrameData(srcPosition: Vector2(32, 16), srcSize: Vector2(16, 16), stepTime: 0.1),
      SpriteAnimationFrameData(srcPosition: Vector2(32, 32), srcSize: Vector2(16, 16), stepTime: 0.1),
      SpriteAnimationFrameData(srcPosition: Vector2(32, 48), srcSize: Vector2(16, 16), stepTime: 0.1),
    ]),
  );
  static Future<SpriteAnimation> get runUp => SpriteAnimation.load(
    "Boss.png",
    SpriteAnimationData([
      SpriteAnimationFrameData(srcPosition: Vector2(16, 0), srcSize: Vector2(16, 16), stepTime: 0.1),
      SpriteAnimationFrameData(srcPosition: Vector2(16, 16), srcSize: Vector2(16, 16), stepTime: 0.1),
      SpriteAnimationFrameData(srcPosition: Vector2(16, 32), srcSize: Vector2(16, 16), stepTime: 0.1),
      SpriteAnimationFrameData(srcPosition: Vector2(16, 48), srcSize: Vector2(16, 16), stepTime: 0.1),
    ]),
  );
  //////////////////////////////////////
  static SimpleDirectionAnimation get simpleDirectionAnimation =>
      SimpleDirectionAnimation(
        idleRight: idleRight,
        idleLeft: idleLeft,
        idleDown: idleDown,
        idleUp: idleUp,
        runRight: runRight,
        runLeft: runLeft,
        runDown: runDown,
        runUp: runUp,
      );
}
