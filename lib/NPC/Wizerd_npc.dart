import 'package:bonfire/bonfire.dart';
import 'package:bonfire_flutter_game/player/Main_Player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../MainGame.dart';
import '../constant/constant.dart';
TextPaint textPaint = TextPaint(style: TextStyle(color: CupertinoColors.white , fontSize: 10 ) );
bool isobserve = false ;
bool finish = true ;

class Stranger extends SimpleNpc with ObjectCollision , AutomaticRandomMovement ,TapGesture{

  Stranger(Vector2 position)
      : super(
    position: position,
    size: Vector2(64,64),
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
      gameRef.add(
        AnimatedFollowerObject(
          animation: SpriteAnimation.load(
            dots,
            SpriteAnimationData.sequenced(
              amount: 8,
              stepTime: 0.1,
              textureSize: Vector2(32, 32),
            ),
          ),
          target: Stranger(position),
          size: Vector2(16, 16),
          positionFromTarget: Vector2(10, -15),
        ),
      );
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
    if (finish) {
      ShowDialogTalk();
      finish = false ;
    }
    else
      {
        ShowDialogTalk2();
      }
  }
  ShowDialogTalk()
  {
    gameRef.camera.moveToTargetAnimated(this,zoom: 2 , finish: () {
      TalkDialog.show(gameRef.context, [
        speak(text: 'Hello, who are you', isPlayer: true),
        speak(text: 'who am I ? Don\'t you remember me?', isPlayer: false),
        speak(text: 'The truth is, I don\'t know why you made me so important to you to be here. You made me to be here', isPlayer: false),
        speak(text: 'I think I remind you a little', isPlayer: true ),
        speak(text: 'I\'m lost now, do you know how to get out of here?', isPlayer: true ),
        speak(text: 'I think I can guide you, there are three pillars that must be operated to open the mind portal.', isPlayer: false ),
        speak(text: 'You can find it in the woods, it\'s scattered over there in the farthest place, and there\'s one near here. Good luck with it.', isPlayer: false ),
      ],logicalKeyboardKeysToNext:[LogicalKeyboardKey.space],
      //onChangeTalk: (value) => gameRef.camera.shake(intensity: 2 ) ,
          onClose: () => gameRef.camera.moveToPlayerAnimated(zoom: 1.8),
      );
    },);
  }

  ShowDialogTalk2()
  {
    gameRef.camera.moveToTargetAnimated(this,zoom: 2 , finish: () {
      TalkDialog.show(gameRef.context, [

        speak(text: 'hey again,did you find them?', isPlayer: false),

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
    "NPC/stranger.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.2,
      textureSize: Vector2(94, 91),
    ),
  );

  static Future<SpriteAnimation> get RunRight => SpriteAnimation.load(
    "NPC/stranger.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.2,
      textureSize: Vector2(94, 91),
    ),
  );


  static SimpleDirectionAnimation get simpleDirectionAnimation =>
      SimpleDirectionAnimation(
        idleRight: idleRight, runRight: RunRight,
      );
}