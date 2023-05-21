import 'package:bonfire/bonfire.dart';
import 'package:bonfire_flutter_game/Enemy/Boss_Ninja.dart';
import 'package:bonfire_flutter_game/Screens/LoseScreen.dart';
import 'package:bonfire_flutter_game/constant/constant.dart';
import 'package:bonfire_flutter_game/decorations/Lighting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../MainGame.dart';
double damage = 10 ;

class Kinght extends SimplePlayer with ObjectCollision ,UseBarLife,Lighting{

  Kinght(Vector2 position)
      : super(
    position: position,
    size: Vector2(tiledSize,tiledSize),
    animation: PlayerSpriteSheet2.simpleDirectionAnimation,
    life: 200,
    speed: 100,
    initDirection: Direction.right,
  )
  {


    setupBarLife(
      barLifePosition: BarLifePorition.top,
      showLifeText: false,
      borderRadius: BorderRadius.circular(2),
      borderWidth: 2,

    );
    setupCollision(
      CollisionConfig(collisions: [
        CollisionArea.rectangle(
          size: Vector2(16, 16),
          align: Vector2(16, 16),
        ),
      ]),
    );

  }
  @override
  void update(double dt) {
    if (islight)
    {
      setupLighting(
        LightingConfig(
          radius: width * 2,
          blurBorder: width * 2,
          color: Colors.yellow.withOpacity(0.1),
        ),
      );
    }

  super.update(dt);
  }

    @override
  void receiveDamage(AttackFromEnum attacker, double damage, identify) {
    if (attacker == AttackFromEnum.ENEMY) {
      // FlameAudio.play(Globals.explosionSound);
      showDamage(
        damage,
        config: TextStyle(fontSize: width / 3, color: Colors.red),
      );
    }
    super.receiveDamage(attacker, damage, identify);
  }
  @override
  void die() {
   // FlameAudio.play(Globals.gameOverSound);
    gameRef.camera.shake(intensity: 4);
    removeFromParent();
    gameRef.pauseEngine();
    gameRef.overlayManager.add(GameOverScreen.id);
    super.die();
  }




  @override
  void joystickAction (JoystickActionEvent press) {
    if (press.event == ActionEvent.DOWN) {
      if (press.id == AttackType.melee || press.id == LogicalKeyboardKey.space.keyId) {
        if (gameRef.player != null && gameRef.player?.isDead == true) return;
          simpleAttackMelee(
            damage: damage *2 ,
            size: size,
            animationRight: PlayerSpriteSheet2.CutSword()
          );
      }

      if (press.id == AttackType.range || press.id == LogicalKeyboardKey.controlLeft.keyId) {
        if (gameRef.player != null && gameRef.player?.isDead == true) return;
simpleAttackRange(
    speed: 200,
    damage: damage,
    animationRight: PlayerSpriteSheet2.Shuriken(),
    animationLeft: PlayerSpriteSheet2.Shuriken(),
    animationUp: PlayerSpriteSheet2.Shuriken(),
    animationDown: PlayerSpriteSheet2.Shuriken(),
    animationDestroy: PlayerSpriteSheet3.SmokeAnimation(),
    size: Vector2(16, 16));
      }
    }

    super.joystickAction(press);
  }


}


class PlayerSpriteSheet2 {
  static Future<SpriteAnimation> Shuriken() => SpriteAnimation.load(
    "shuriken.png",
    SpriteAnimationData.sequenced(
      amount: 2,
      stepTime: 0.1,
      textureSize: Vector2(16, 16),
    ),
  );
  static Future<SpriteAnimation> big_energy_ball() => SpriteAnimation.load(
    "big_energy_ball.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.1,
      textureSize: Vector2(24, 24),
    ),
  );
  static Future<SpriteAnimation> CutSword() => SpriteAnimation.load(
    "cut.png",
    SpriteAnimationData.sequenced(
      amount: 7,
      stepTime: 0.1,
      textureSize: Vector2(32, 32),
    ),
  );
  static Future<SpriteAnimation> CutSlash() => SpriteAnimation.load(
    "circular_slash.png",
    SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.1,
      textureSize: Vector2(32, 32),
    ),
  );


  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
    "knight_idle.png",
    SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.1,
      textureSize: Vector2(16, 16),
    ),
  );

  static Future<SpriteAnimation> get idleLeft => SpriteAnimation.load(
    "knight_idle_left.png",
    SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.1,
      textureSize: Vector2(16, 16),
    ),
  );

  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
    "knight_run.png",
    SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.1,
      textureSize: Vector2(16, 16),
    ),
  );

  static Future<SpriteAnimation> get runLeft => SpriteAnimation.load(
    "knight_run_left.png",
    SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.1,
      textureSize: Vector2(16, 16),
    ),
  );

  static SimpleDirectionAnimation get simpleDirectionAnimation =>
      SimpleDirectionAnimation(
        idleRight: idleRight,
        idleLeft: idleLeft,
        runRight: runRight,
        runLeft: runLeft,
      );
}