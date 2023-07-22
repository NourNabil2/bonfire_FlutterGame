import 'package:bonfire/bonfire.dart';
import 'package:bonfire_flutter_game/MainGame.dart';
import 'package:bonfire_flutter_game/decorations/Gate_translate.dart';
import 'package:bonfire_flutter_game/decorations/Items.dart';

import '../decorations/die_Decoration.dart';
Vector2 _size = Vector2(50, 50);
class You extends SimpleEnemy with ObjectCollision {
  bool see = false;
  You(Vector2 position)
      : super(
    position: position,
    size: Vector2(32,32),
    animation: PlayerSpriteSheet.simpleDirectionAnimation,
    speed: 50,
    life: 40,
    initDirection: Direction.right,
  ){

    setupCollision(
      CollisionConfig(collisions: [
        CollisionArea.rectangle(
          size: Vector2(5, 10),
          align: Vector2(10, 20),
        ),
      ]),
    );
  }

  @override
  void die()
  {
    if (currentMap == 6 )
      {
        gameRef.add(You(Vector2(90, 90)));
        gameRef.add(You(Vector2(90, 150)));
      }
    else {
      gameRef.add(You(position + Vector2(80, 0)));
    }

    gameRef.add(YOUDEATH(position: position));
    removeFromParent();

    currentMap == 2 ? gameRef.add(Key_Gold( position: position + Vector2(20, 20),)) : null ;

    super.die();
  }

  @override
  void update(double dt)  {





    seeAndMoveToPlayer(
      closePlayer: (player) {},
      observed: () {
        seeAndMoveToPlayer(
          radiusVision: 50,
          closePlayer: (p0) {
          },
          observed: () {},
        );
      },
      radiusVision: 80,
    );



    super.update(dt);

  }


  @override
  bool onCollision(GameComponent component, bool active) {
    if (component is FlyingAttackObject ) {
      return false;
    }
    return super.onCollision(component, active);
  }

}



class PlayerSpriteSheet {

  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
    "follower/summonIdle.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.2,
      textureSize: _size,
    ),
  );
  static Future<SpriteAnimation> get idleLeft => SpriteAnimation.load(
    "follower/summonIdle_Left.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.2,
      textureSize: _size,
    ),
  );






  static SimpleDirectionAnimation get simpleDirectionAnimation =>
      SimpleDirectionAnimation(
          idleRight: idleRight, runRight: idleRight ,idleLeft: idleLeft ,runLeft: idleLeft
      );
}