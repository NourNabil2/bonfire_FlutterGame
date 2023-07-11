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

    selectMap(4);
    //gameRef.pauseEngine();
    // gameRef.overlayManager.add(LevelWonScreen.id);
  }

}