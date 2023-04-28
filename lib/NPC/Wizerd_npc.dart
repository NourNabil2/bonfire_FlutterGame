import 'package:bonfire/bonfire.dart';
import 'package:bonfire_flutter_game/player/Main_Player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../GreenNinjaGame.dart';

class WizerdMan extends SimpleNpc with ObjectCollision , TapGesture{

  WizerdMan(Vector2 position)
      : super(
    position: position,
    size: Vector2(tiledSize,tiledSize),
    animation: PlayerSpriteSheet.simpleDirectionAnimation,
    speed: 100,
    initDirection: Direction.down,
  );

  @override
  void onTap() {
    ShowDialogTalk();
  }
  ShowDialogTalk()
  {
    gameRef.camera.moveToTargetAnimated(this,zoom: 2 , finish: () {
      TalkDialog.show(gameRef.context, [
        speak(text: 'Hello warrior, What Are you doing here in this place ', isPlayer: false),
        speak(text: 'really i dont know', isPlayer: true),
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
    "wizard_idle.png",
    SpriteAnimationData.sequenced(
      amount: 2,
      stepTime: 0.2,
      textureSize: Vector2(16, 20),
    ),
  );
  static Future<SpriteAnimation> get RunRight => SpriteAnimation.load(
    "wizard_idle.png",
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