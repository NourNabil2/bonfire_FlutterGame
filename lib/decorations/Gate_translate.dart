import 'package:bonfire/bonfire.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import '../MainGame.dart';
import '../SharedPreferences/Cash_Save.dart';
import '../constant/Sounds/background.dart';
import '../constant/constant.dart';
import '../constant/onBoarding.dart';
import '../player/Main_Player.dart';
class Portal extends GameDecoration with Sensor<Kinght>
{
  Portal({required Vector2 position}): super.withAnimation(size:  Vector2.all(50.0) ,animation: SpriteAnimation.load(
    "Effects/Portal.png",
    SpriteAnimationData.sequenced(
      amount: 41,
      stepTime: 0.1,
      textureSize: Vector2(100, 100),
    ),
  ) ,position: position );

  @override
  Future<void> onContact(GameComponent component) async {
    if(currentMap == 1 )
      {
        SFX ? await FlameAudio.play('swoosh_Gate.mp3') : null ;
        interstitial.show();
        CashSaver.SaveData(key: 'complete',value:complete+ 15);
        const Duration(milliseconds: 500);
        selectMap(3);
        removeFromParent();
      }
    else if (currentMap == 3)
      {
        SFX ? await FlameAudio.play('swoosh_Gate.mp3') : null ;
        interstitial.show();
        CashSaver.SaveData(key: 'complete',value:complete+ 10);
        const Duration(milliseconds: 500);
        selectMap(2);
        removeFromParent();
      }
    else if (currentMap == 2)
      {

        SFX ?await FlameAudio.play('swoosh_Gate.mp3') : null ;
        interstitial.show();
        gameRef.colorFilter?.animateTo(Colors.red.withOpacity(0.3), blendMode: BlendMode.colorBurn);
        CashSaver.SaveData(key: 'complete',value:complete+ 15);
        const Duration(milliseconds: 500);
        selectMap(4);
        removeFromParent();
      }
    else if (currentMap == 4)
      {

        SFX ?await FlameAudio.play('swoosh_Gate.mp3') : null ;
        interstitial.show();
        CashSaver.SaveData(key: 'complete',value:complete+ 20);
        const Duration(milliseconds: 500);
        selectMap(6);
        removeFromParent();
      }
    else if (currentMap == 5)
    {
      SFX ? await FlameAudio.play('swoosh_Gate.mp3') : null ;
      interstitial.show();
      CashSaver.SaveData(key: 'complete',value:complete+ 3);
      const Duration(milliseconds: 500);
      selectMap(4);
      removeFromParent();
    }

    else if (currentMap == 7)
    {
      SFX ? await FlameAudio.play('swoosh_Gate.mp3') : null ;
      interstitial.show();
      CashSaver.SaveData(key: 'complete',value:complete+ 7);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => OnBoarding(Story: boarding,),), (route) => false);
      removeFromParent();
    }
  }
}

class portal_Jail extends GameDecoration with Sensor<Kinght>
{
  portal_Jail({required Vector2 position}): super.withAnimation(size:  Vector2.all(50.0) ,animation: SpriteAnimation.load(
    "Effects/gate.png",
    SpriteAnimationData.sequenced(amount: 1, stepTime: 0.1, textureSize: Vector2.all(16)),
  ) ,position: position );

  @override
  void onContact(GameComponent component) {
    interstitial.show();
      CashSaver.SaveData(key: 'complete',value:complete+ 20);
      removeFromParent();
      selectMap(5);

  }
}