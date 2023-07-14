import 'package:bonfire/bonfire.dart';
import '../MainGame.dart';
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
        selectMap(3);
      }
    else if (currentMap == 3)
      {
        selectMap(2);
      }
    else if (currentMap == 2)
      {
        selectMap(1);
      }
    //gameRef.pauseEngine();
    // gameRef.overlayManager.add(LevelWonScreen.id);
  }

}