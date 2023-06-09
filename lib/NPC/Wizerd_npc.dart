import 'package:bonfire/bonfire.dart';
import 'package:bonfire_flutter_game/player/Main_Player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../MainGame.dart';
TextPaint textPaint = TextPaint(style: TextStyle(color: CupertinoColors.white , fontSize: 10 ) );
bool isobserve = false ;
class WizerdMan extends SimpleNpc with ObjectCollision , AutomaticRandomMovement ,TapGesture{

  WizerdMan(Vector2 position)
      : super(
    position: position,
    size: Vector2(tiledSize,tiledSize),
    animation: PlayerSpriteSheet.simpleDirectionAnimation,
    speed: 100,
    initDirection: Direction.down,
  ){
    setupCollision(
      CollisionConfig(collisions: [
        CollisionArea.rectangle(
          size: Vector2(18, 20),
          align: Vector2(18, 20),
        ),
      ]),
    );
  }
@override
void render(Canvas canvas)
{

  super.render(canvas);
  if (isobserve)
    {
      textPaint.render(canvas, 'Tap me!', position);
    }
}
  @override
  void update(double dt) {
    super.update(dt);
    seePlayer(
        observed: (p0) {
      if(!isobserve)
        {
          isobserve = true ;
        }
    },
        notObserved: () {
          {
            isobserve = false ;
          }
        },
        radiusVision:80

    );
  }
  @override
  void onTap() {
    ShowDialogTalk();
  }
  ShowDialogTalk()
  {
    gameRef.camera.moveToTargetAnimated(this,zoom: 2 , finish: () {
      TalkDialog.show(gameRef.context, [
        speak(text: 'Hello warrior, What Are you doing here in this place ', isPlayer: false),
        speak(text: 'really i don\'t know', isPlayer: true),
        speak(text: 'go and find your goals', isPlayer: false),
      ],logicalKeyboardKeysToNext:[LogicalKeyboardKey.space],
      //onChangeTalk: (value) => gameRef.camera.shake(intensity: 2 ) ,
          onClose: () => gameRef.camera.moveToPlayerAnimated(zoom: 1.8),
      );
    },);
  }

  Say speak({required String text , required bool isPlayer ,})=> Say(
      text: [TextSpan(text: text),],
    person: SizedBox(height: 100,width: 100,child: isPlayer ? PlayerSpriteSheet2.idleRight.asWidget() : PlayerSpriteSheet.idleRight.asWidget() ,),
    personSayDirection: isPlayer ? PersonSayDirection.LEFT :PersonSayDirection.RIGHT ,
  );


}



class PlayerSpriteSheet {

  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
    "NPC/wizard_idle.png",
    SpriteAnimationData.sequenced(
      amount: 2,
      stepTime: 0.2,
      textureSize: Vector2(16, 20),
    ),
  );
  static Future<SpriteAnimation> get RunRight => SpriteAnimation.load(
    "NPC/wizard_idle.png",
    SpriteAnimationData.sequenced(
      amount: 2,
      stepTime: 0.2,
      textureSize: Vector2(16, 20),
    ),
  );

  static SimpleDirectionAnimation get simpleDirectionAnimation =>
      SimpleDirectionAnimation(
        idleRight: idleRight, runRight: RunRight,
      );
}