import 'package:bonfire/bonfire.dart';

import '../MainGame.dart';
import '../constant/NameOfMaps.dart';
import '../player/Main_Player.dart';

class Chest extends GameDecoration with Sensor<Kinght>
{
  Chest({required Vector2 position}): super.withAnimation(size:  Vector2.all(25.0) ,animation: SpriteAnimation.load(
    "items/chest_spritesheet.png",
    SpriteAnimationData.sequenced(
      amount: 8,
      stepTime: 0.2,
      textureSize: Vector2(16, 16),
    ),
  ) ,position: position );


  @override
  void onContact(GameComponent component) {

    removeFromParent();
    selectMap(1);
    //gameRef.pauseEngine();
    // gameRef.overlayManager.add(LevelWonScreen.id);
  }

}