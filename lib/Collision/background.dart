
import 'package:bonfire/bonfire.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/cupertino.dart';

class backGround extends FlameGame
{
  Future<void> onLoad() async {
    final World world = World();
    await add(world);
    final stars = await ParallaxComponent.load(
      [ ParallaxImageData('plx-5.png')],
      repeat: ImageRepeat.repeat,
      baseVelocity: Vector2(50, 0),
      velocityMultiplierDelta: Vector2(1.5, 1.5),
      fill: LayerFill.width,

      size: Vector2(1000, 1000),
    );
    await add(stars);

  }
}