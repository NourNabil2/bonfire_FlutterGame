import 'package:bonfire/bonfire.dart';
import 'package:bonfire_flutter_game/Enemy/Bat_purble.dart';
import 'package:bonfire_flutter_game/Enemy/Boss_Ninja.dart';
import 'package:bonfire_flutter_game/Screens/LoseScreen.dart';
import 'package:bonfire_flutter_game/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Enemy/Rat.dart';
import '../SharedPreferences/Cash_Save.dart';
import '../decorations/Items.dart';
import 'dart:async' as async;

import '../decorations/die_Decoration.dart';
double damage = 10 ;
bool showObserveEnemy = false;

class Kinght extends SimplePlayer with ObjectCollision,Lighting {
  double stamina = 100;
  bool Taketorch =  CashSaver.getData(key: 'torch') ?? false ;
  bool silverKey = false ;
  bool goldKey = false ;

  async.Timer? _timerStamina;
  Kinght(Vector2 position )
      : super (
    position: position,
    size: Vector2(50,37),
    animation: PlayerSpriteSheet2.simpleDirectionAnimation,
    life: 200,
    speed: 100,
    initDirection: Direction.right,
  )
  {
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
  Future<void> update(double dt) async {


    if(isDead)
  {
    return;
  }
else
  {
    _verifyStamina();
    seeEnemy(
      radiusVision:  200,
      notObserved: () {
        showObserveEnemy = false;
      },
      observed: (enemies) {
        if (showObserveEnemy) return;
        showObserveEnemy = true;
        _showEmote(emote: wonder);


      }, );

  }


    if (islight)
    {
      super.animation?.idleRight = await PlayerSpriteSheet2.idleRight2 ;
      super.animation?.idleLeft = await PlayerSpriteSheet2.idleLeft2 ;
      super.animation?.runRight = await PlayerSpriteSheet2.runRight2 ;
      super.animation?.runLeft = await PlayerSpriteSheet2.runLeft2 ;
      setupLighting(
        LightingConfig(
          radius: width ,
          blurBorder: width * 2,
          color: Colors.yellow.withOpacity(0.1),
        ),
      );

    }
    else
      {
        super.animation?.idleRight = await PlayerSpriteSheet2.idleRight ;
        super.animation?.idleLeft = await PlayerSpriteSheet2.idleLeft ;
        super.animation?.runRight = await PlayerSpriteSheet2.runRight ;
        super.animation?.runLeft = await PlayerSpriteSheet2.runLeft ;
        setupLighting(
        LightingConfig(radius: 0, color: Colors.transparent),

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
  Future<void> die() async {
    // FlameAudio.play(Globals.gameOverSound);

   await animation?.playOnce(
      SpriteAnimation.load(
          "Player/MainMovement/player-death.png",
          SpriteAnimationData.sequenced(amount: 7, stepTime: 0.1, textureSize: Vector2(50, 37),loop: false )

      ),
      runToTheEnd: true ,
      flipX: lastDirectionHorizontal == Direction.right ?  false  : true,
      onFinish: () => lastDirectionHorizontal == Direction.right ? gameRef.add(Player_death_R(position: position)) : gameRef.add(Player_death(position: position)) ,
    );
   gameRef.camera.shake(intensity: 4);
  await Future.delayed(const Duration(milliseconds: 700));
   removeFromParent();
    die_rat = 0 ;
    gameRef.pauseEngine();
    gameRef.overlayManager.add(GameOverScreen.id);



    super.die();
  }




  @override
  void joystickAction (JoystickActionEvent press) {
    if (press.event == ActionEvent.DOWN) {
      if (press.id == AttackType.melee || press.id == LogicalKeyboardKey.space.keyId) {
        if (gameRef.player != null && gameRef.player?.isDead == true) return;
        if (stamina < 15) {
          return;
        }
        else {
          decrementStamina(15);
          animation?.playOnce(
            PlayerSpriteSheet2.AttackSwrd_R(),
            runToTheEnd: true ,
            flipX: lastDirectionHorizontal == Direction.right ?  false  : true,
          );
          simpleAttackMelee(
              damage: damage * 2,
              size: size,
          );
        }
      }

      if (press.id == AttackType.light || press.id == LogicalKeyboardKey.keyZ.keyId) {
        if (gameRef.player != null && gameRef.player?.isDead == true) return;

        if (CashSaver.getData(key: 'torch')?? false)
          {
            islight == false ? islight = true : islight =false ;

          }
        else
          {
            _showEmote(emote: wrong);
          }



        }

      if (press.id == AttackType.range || press.id == LogicalKeyboardKey.controlLeft.keyId) {
        if (gameRef.player != null && gameRef.player?.isDead == true) return;

        if (stamina < 10) {
          return;
        }
        else
          {
            decrementStamina(15);
            animation?.playOnce(
                PlayerSpriteSheet2.AttackRange_R() ,
                flipX:  lastDirectionHorizontal == Direction.right ?  false  : true,
                runToTheEnd: true,

            );
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
    }

    super.joystickAction(press);
  }




  void _verifyStamina() {

    if (_timerStamina == null) {

      _timerStamina = async.Timer(const Duration(milliseconds: 150), () {
        _timerStamina = null;
      });
    } else {
      return;
    }
    stamina += 2;

    if (stamina > 100) {
      stamina = 100;
    }
  }

  void decrementStamina(int i) {
    stamina -= i;
    if (stamina < 0) {
      stamina = 0;
    }
  }


  Future<void> _showEmote({required String emote }) async {
    gameRef.add(
      AnimatedFollowerObject(
        animation: SpriteAnimation.load(
          emote,
          SpriteAnimationData.sequenced(
            amount: 8,
            stepTime: 0.1,
            textureSize: Vector2(32, 32),
          ),
        ),
        target: gameRef.player,
        size: Vector2(16, 16),
        positionFromTarget: Vector2(18, -15),
      ),
    );
  }

}




class PlayerSpriteSheet2 {
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