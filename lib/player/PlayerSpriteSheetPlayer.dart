


import 'package:bonfire/bonfire.dart';

class PlayerSpriteSheetPlayer {
  static Future<SpriteAnimation> Wave_R() => SpriteAnimation.load(
    "Effects/wave_R.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.1,
      textureSize: Vector2(48, 32),
    ),
  );
  static Future<SpriteAnimation> Wave_L() => SpriteAnimation.load(
    "Effects/wave_L.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.1,
      textureSize: Vector2(48, 32),
    ),
  );
  static Future<SpriteAnimation> Wave_D() => SpriteAnimation.load(
    "Effects/wave_D.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.1,
      textureSize: Vector2(32, 48),
    ),
  );
  static Future<SpriteAnimation> Wave_U() => SpriteAnimation.load(
    "Effects/wave_Up.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.1,
      textureSize: Vector2(32, 48),
    ),
  );


  static Future<SpriteAnimation> FX_Wave() => SpriteAnimation.load(
    "Effects/hits-wave.png",
    SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.1,
      textureSize: Vector2(32, 32),
    ),
  );



  static Future<SpriteAnimation> Shuriken() => SpriteAnimation.load(
    "Effects/shuriken.png",
    SpriteAnimationData.sequenced(
      amount: 2,
      stepTime: 0.1,
      textureSize: Vector2(16, 16),
    ),
  );



  static Future<SpriteAnimation> big_energy_ball() => SpriteAnimation.load(
    "Effects/big_energy_ball.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.1,
      textureSize: Vector2(24, 24),
    ),
  );
  static Future<SpriteAnimation> CutSword() => SpriteAnimation.load(
    "Effects/cut.png",
    SpriteAnimationData.sequenced(
      amount: 7,
      stepTime: 0.1,
      textureSize: Vector2(32, 32),
    ),
  );
  static Future<SpriteAnimation> CutSlash() => SpriteAnimation.load(
    "Effects/circular_slash.png",
    SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.1,
      textureSize: Vector2(32, 32),
    ),
  );

  static Future<SpriteAnimation> AttackSwrd_R() => SpriteAnimation.load (
    "Player/AttackMovement/player-attack.png",
    SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.05,
      textureSize: Vector2(50, 37),
    ),
  );

  static Future<SpriteAnimation> AttackPunch_R() => SpriteAnimation.load (
    "Player/AttackMovement/Player-punch-R.png",
    SpriteAnimationData.sequenced(
      amount: 9,
      stepTime: 0.07,
      textureSize: Vector2(50, 37),
    ),
  );


  static Future<SpriteAnimation> AttackSwrd_FX() => SpriteAnimation.load (
    "Effects/Swrd_FX1.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.1,
      textureSize: Vector2(45, 32),
    ),
  );

  static Future<SpriteAnimation> AttackElec_FX() => SpriteAnimation.load (
    "Effects/Elec.png",
    SpriteAnimationData.sequenced(
      amount: 7,
      stepTime: 0.1,
      textureSize: Vector2(512, 512),
    ),
  );

  static Future<SpriteAnimation> AttackPunch_FX() => SpriteAnimation.load (
    "Effects/SwrdFX.png",
    SpriteAnimationData.sequenced(
      amount: 3,
      stepTime: 0.1,
      textureSize: Vector2(65, 27),
    ),
  );


  static Future<SpriteAnimation> AttackRange_R() => SpriteAnimation.load(
    "Player/AttackMovement/player-attack-range.png",
    SpriteAnimationData.sequenced(
      amount: 3,
      stepTime: 0.1,
      textureSize: Vector2(50, 37),
      loop: false,
    ),
  );



  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
    "Player/MainMovement/player-idle.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.2,
      textureSize: Vector2(50, 37),
    ),
  );
  static Future<SpriteAnimation> get idleLeft => SpriteAnimation.load(
    "Player/MainMovement/player-idle-left.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.2,
      textureSize: Vector2(50, 37),
    ),
  );

  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
    "Player/MainMovement/player-run.png",
    SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.15,
      textureSize: Vector2(50, 37),
    ),
  );
  static Future<SpriteAnimation> get runLeft => SpriteAnimation.load(
    "Player/MainMovement/player-run-left.png",
    SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.15,
      textureSize: Vector2(50, 37),
    ),
  );

  static SimpleDirectionAnimation get simpleDirectionAnimation =>
      SimpleDirectionAnimation(
        idleRight: idleRight,
        idleLeft: idleLeft,
        runRight: runRight,
        runLeft: runLeft,
      );
  static Future<SpriteAnimation> get idleRight2 => SpriteAnimation.load(
    'Player/Picktorch/player-idle-torch.png',
    SpriteAnimationData.sequenced(
      amount:4,
      stepTime: 0.2,
      textureSize: Vector2(50, 37),
    ),
  );
  static Future<SpriteAnimation> get idleLeft2 => SpriteAnimation.load(
    'Player/Picktorch/player-idle-torch-left.png',
    SpriteAnimationData.sequenced(
      amount:4,
      stepTime: 0.2,
      textureSize: Vector2(50, 37),
    ),
  );
  static Future<SpriteAnimation> get runRight2 => SpriteAnimation.load(
    "Player/Picktorch/player-run-torch.png",
    SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.2,
      textureSize: Vector2(50, 37),
    ),
  );
  static Future<SpriteAnimation> get runLeft2 => SpriteAnimation.load(
    "Player/Picktorch/player-run-torch-left.png",
    SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.2,
      textureSize: Vector2(50, 37),
    ),
  );
}