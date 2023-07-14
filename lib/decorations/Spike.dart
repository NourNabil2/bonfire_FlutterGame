import 'package:bonfire/bonfire.dart';

import '../MainGame.dart';


class Spikes extends GameDecoration with Sensor {
  final double damage;

  Spikes(Vector2 position, {this.damage = 60})
      : super.withAnimation(
    animation: spikes(),
    position: position,
    size: Vector2(tiledSize, tiledSize),
  ) {
    setupSensorArea(
      // align: Vector2(valueByTileSize(2), valueByTileSize(4)),
      // size: Vector2(valueByTileSize(14), valueByTileSize(12)),
      intervalCheck: 100,
    );
  }

  @override
  void onContact(GameComponent collision) {
    if (collision is Player) {
      if (this.animation?.currentIndex ==
          (this.animation?.frames.length ?? 0) - 1 ||
          this.animation?.currentIndex ==
              (this.animation?.frames.length ?? 0) - 2) {
        gameRef.player?.receiveDamage(AttackFromEnum.ENEMY, damage, 0);
      }
    }
  }

  @override
  int get priority => LayerPriority.getComponentPriority(1);

  @override
  void onContactExit(GameComponent component) {
  }
}

Future<SpriteAnimation> spikes() => SpriteAnimation.load(
'Interface/spikes.png',
SpriteAnimationData.sequenced(
amount: 10,
stepTime: 0.1,
textureSize: Vector2(16, 16),
),
);