import 'package:bonfire/bonfire.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import '../MainGame.dart';
import '../SharedPreferences/Cash_Save.dart';
import '../constant/Sounds/background.dart';
import '../constant/constant.dart';
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
        CashSaver.SaveData(key: 'complete',value: 15);
        const Duration(milliseconds: 500);
        selectMap(3);
        removeFromParent();
      }
    else if (currentMap == 3)
      {
        SFX ? await FlameAudio.play('swoosh_Gate.mp3') : null ;
        interstitial.show();
        CashSaver.SaveData(key: 'complete',value: 10);
        const Duration(milliseconds: 500);
        selectMap(2);
        removeFromParent();
      }
    else if (currentMap == 2)
      {

        SFX ?await FlameAudio.play('swoosh_Gate.mp3') : null ;
        interstitial.show();
        gameRef.colorFilter?.animateTo(Colors.red.withOpacity(0.3), blendMode: BlendMode.colorBurn);
        CashSaver.SaveData(key: 'complete',value: 15);
        const Duration(milliseconds: 500);
        selectMap(4);
        removeFromParent();
      }
    else if (currentMap == 4)
      {

        SFX ?await FlameAudio.play('swoosh_Gate.mp3') : null ;
        interstitial.show();
        CashSaver.SaveData(key: 'complete',value: 20);
        const Duration(milliseconds: 500);
        selectMap(6);
        removeFromParent();
      }
    else if (currentMap == 5)
    {
      SFX ? await FlameAudio.play('swoosh_Gate.mp3') : null ;
      interstitial.show();
      CashSaver.SaveData(key: 'complete',value: 3);
      const Duration(milliseconds: 500);
      selectMap(4);
      removeFromParent();
    }

    else if (currentMap == 7)
    {
      SFX ? await FlameAudio.play('swoosh_Gate.mp3') : null ;
      interstitial.show();
      CashSaver.SaveData(key: 'complete',value: 7);
      
      removeFromParent();
    }
  }
}

class portal_Jail extends GameDecoration with Sensor<Kinght>
{
  portal_Jail({required Vector2 position}): super.withAnimation(size:  Vector2.all(50.0) ,animation: SpriteAnimation.load(
    "0x72_DungeonTilesetII_v1.3.png",
    SpriteAnimationData([
      SpriteAnimationFrameData(srcPosition: Vector2(96, 48), srcSize: Vector2(16, 16), stepTime: 0.1),
    ]),
  ) ,position: position );

  @override
  void onContact(GameComponent component) {
    interstitial.show();
      CashSaver.SaveData(key: 'complete',value: 20);
      removeFromParent();
      selectMap(5);

  }
}