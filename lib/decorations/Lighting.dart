
import 'package:bonfire/bonfire.dart';
import 'package:bonfire_flutter_game/player/Main_Player.dart';
import 'package:flutter/material.dart';

bool islight = false ;
class torch extends GameDecoration with Lighting {

  torch({required Vector2 position})
      : super.withAnimation(
    animation: SpriteAnimation.load(
      "torch_spritesheet.png",
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: 0.2,
        textureSize: Vector2(16, 16),
      ),
    ),
    position: position,
    size: Vector2.all(16),
  ) {
    setupLighting(
      LightingConfig(
        radius: width * 2,
        blurBorder: width * 2,
        color: Colors.yellow.withOpacity(0.1),
      ),
    );
  }

  @override
  void onContact(GameComponent component) {
    // component = component as GreenNinjaPlayer;
    // FlameAudio.play(Globals.fireSound);
    // component.showDamage(_damage);
    // component.removeLife(_damage);
  }
}

class Picktorch extends GameDecoration with Sensor<Kinght> {
  Picktorch({required Vector2 position})
      : super.withAnimation(
    animation: SpriteAnimation.load(
      "torch_spritesheet.png",
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
