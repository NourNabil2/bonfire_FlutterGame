import 'package:bonfire/bonfire.dart';
import 'package:bonfire_flutter_game/MainGame.dart';
import 'package:bonfire_flutter_game/Screens/WinScreen.dart';
import 'package:bonfire_flutter_game/SharedPreferences/Cash_Save.dart';
import 'package:bonfire_flutter_game/constant/NameOfMaps.dart';
import 'package:bonfire_flutter_game/constant/constant.dart';
import 'package:bonfire_flutter_game/player/Main_Player.dart';
import 'package:flame_audio/flame_audio.dart';

class PotionLife extends GameDecoration with Sensor<Kinght>
{
  PotionLife({required Vector2 position}): super.withSprite(sprite: Sprite.load("items/potion_life.png",), position: position, size: Vector2.all(15.0));


  @override
  void onContact(GameComponent component) {

    CashSaver.getData(key: 'SFX') ==true ? FlameAudio.play('power_up.wav') : null ;
    gameRef.player!.addLife(lifePotion);
    removeFromParent();
  }

}


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
   // selectMap(MapId.two);
    gameRef.pauseEngine();
    gameRef.overlayManager.add(LevelWonScreen.id);
  }

}


bool islight = false ;
class Picktorch extends GameDecoration with Sensor<Kinght> {
  Picktorch({required Vector2 position})
      : super.withAnimation(
    animation: SpriteAnimation.load(
      "Interface/torch_spritesheet.png",
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: 0.2,
        textureSize: Vector2(16, 16),
      ),
    ),
    position: position,
    size: Vector2.all(16),
  ) {



  }
  @override
  void onContact(GameComponent component) {
    islight = true;
    removeFromParent();
    // component = component as GreenNinjaPlayer;
    // FlameAudio.play(Globals.fireSound);
    // component.showDamage(_damage);
    // component.removeLife(_damage);
  }
}