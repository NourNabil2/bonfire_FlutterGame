import 'package:bonfire/bonfire.dart';
import '../MainGame.dart';
import '../constant/constant.dart';
import '../player/Main_Player.dart';

class Fox extends SimpleAlly with ObjectCollision ,TapGesture{

  Fox(Vector2 position)
      : super(
    position: position,
    size: Vector2(16,16),
    animation: PlayerSpriteSheet.simpleDirectionAnimation,
    speed: 100,
    initDirection: Direction.right,
  ){


    setupCollision(
      CollisionConfig(collisions: [
        CollisionArea.rectangle(
          size: Vector2(5, 5),
          align: Vector2(9, 10),
        ),
      ]),
    );
  }

  @override
  void update(double dt)  {

        seeAndMoveToPlayer(
          closePlayer: (player) {},
          observed: () async {
            super.animation?.idleRight = await PlayerSpriteSheet.idleRight;
            seeAndMoveToEnemy(
              radiusVision: 50,
              closeEnemy: (p0) {
                simpleAttackMelee(
                    withPush: false,
                    damage: 10,
                    size: size,
                    animationRight: PlayerSpriteSheet2.CutSword()
                );
              },
              observed: () {
                seeAndMoveToEnemy(
                  radiusVision: 50,
                  closeEnemy: (p0) {
                    simpleAttackMelee(
                        withPush: false,
                        damage: 10,
                        size: size,
                        animationRight: PlayerSpriteSheet2.CutSword()
                    );
                  },
                );
              },
            );
          },
          radiusVision: 50,
          notObserved: ()  {

          },
        );



    super.update(dt);

  }

  @override
  void onTap() {

    gameRef.add(
      AnimatedFollowerObject(
        animation: SpriteAnimation.load(
          love,
          SpriteAnimationData.sequenced(
            amount: 8,
            stepTime: 0.1,
            textureSize: Vector2(32, 32),
          ),
        ),
        target: Fox(position),
        size: Vector2(16, 16),
        positionFromTarget: Vector2(18, -15),
      ),
    );
  }

  @override
  bool onCollision(GameComponent component, bool active) {
    if (component is FlyingAttackObject) {
      return false;
    }
    return super.onCollision(component, active);
  }

}



class PlayerSpriteSheet {

  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
    "follower/fox_idle_right.png",
    SpriteAnimationData.sequenced(
      amount: 5,
      stepTime: 0.2,
      textureSize: Vector2(32, 16),
    ),
  );
  static Future<SpriteAnimation> get idleLeft => SpriteAnimation.load(
    "follower/fox_idle_left.png",
    SpriteAnimationData.sequenced(
      amount: 5,
      stepTime: 0.2,
      textureSize: Vector2(32, 16),
    ),
  );

  static Future<SpriteAnimation> get RunRight => SpriteAnimation.load(
    "follower/fox_run_right.png",
    SpriteAnimationData.sequenced(
      amount: 8,
      stepTime: 0.09,
      textureSize: Vector2(32, 16),
    ),
  );
  static Future<SpriteAnimation> get RunLeft => SpriteAnimation.load(
    "follower/fox_run_left.png",
    SpriteAnimationData.sequenced(
      amount: 8,
      stepTime: 0.09,
      textureSize: Vector2(32, 16),
    ),
  );

  static Future<SpriteAnimation> get fox_sleep => SpriteAnimation.load(
    "follower/fox_sleep.png",
    SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.2,
      textureSize: Vector2(32, 16),
    ),

  );



  static SimpleDirectionAnimation get simpleDirectionAnimation =>
      SimpleDirectionAnimation(
        idleRight: fox_sleep, runRight: RunRight,idleLeft: idleLeft ,runLeft: RunLeft
      );
}