import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import '../MainGame.dart';
import '../SharedPreferences/Cash_Save.dart';
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
  void onContact(GameComponent component) {
    if(currentMap == 1 )
      {
        CashSaver.SaveData(key: 'complete',value: 20);
        selectMap(3);
      }
    else if (currentMap == 3)
      {
        CashSaver.SaveData(key: 'complete',value: 20);
        selectMap(2);
      }
    else if (currentMap == 2)
      {
        gameRef.colorFilter?.animateTo(Colors.red.withOpacity(0.3), blendMode: BlendMode.colorBurn);
        CashSaver.SaveData(key: 'complete',value: 20);
        selectMap(4);
      }
    else if (currentMap == 4)
      {

        CashSaver.SaveData(key: 'complete',value: 20);
        selectMap(6);
      }
    else if (currentMap == 5)
    {

      CashSaver.SaveData(key: 'complete',value: 10);
      selectMap(4);
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

      CashSaver.SaveData(key: 'complete',value: 20);
      selectMap(3);

  }
}