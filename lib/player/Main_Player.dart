// ignore_for_file: non_constant_identifier_names

import 'dart:async' as async;

import 'package:bonfire/bonfire.dart';
import 'package:bonfire_flutter_game/Enemy/Rat.dart';
import 'package:bonfire_flutter_game/Enemy/Skull.dart';
import 'package:bonfire_flutter_game/MainGame.dart';
import 'package:bonfire_flutter_game/Screens/LoseScreen.dart';
import 'package:bonfire_flutter_game/SharedPreferences/Cash_Save.dart';
import 'package:bonfire_flutter_game/constant/Sounds/background.dart';
import 'package:bonfire_flutter_game/constant/constant.dart';
import 'package:bonfire_flutter_game/decorations/Items.dart';
import 'package:bonfire_flutter_game/decorations/die_Decoration.dart';
import 'package:bonfire_flutter_game/player/PlayerSpriteSheetPlayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

double damagePlayer = 8;
bool showObserveEnemy = false;

class Kinght extends SimplePlayer with BlockMovementCollision, Lighting {
  double stamina = 100;
  bool Taketorch = CashSaver.getData(key: 'torch') ?? false;
  bool silverKey = false;
  bool goldKey = CashSaver.getData(key: 'gold') ?? false;
  bool Key_red = CashSaver.getData(key: 'red') ?? false;
  bool Power = CashSaver.getData(key: 'Power') ?? false;
  bool PowerE = CashSaver.getData(key: 'PowerE') ?? false;

  // Track animation states to prevent unnecessary updates
  bool _currentlyUsingTorchAnimation = false;
  bool _lightingSetupComplete = false;
  bool _mapSixProcessed = false;

  async.Timer? _timerStamina;

  Kinght({required Vector2 position})
      : super(
    position: position,
    size: currentMap == 4 ? Vector2(80, 57) : Vector2(50, 37),
    animation: PlayerSpriteSheetPlayer.simpleDirectionAnimation,
    life: 200,
    speed: 100,
     initDirection: Direction.right,
  );

  @override
  Future<void> onLoad() async {
    add(
      RectangleHitbox(
        size: Vector2(16, 16),
        position: Vector2(16, 16),
      ),
    );

    // Set initial lighting state
    _setupInitialLighting();

    return super.onLoad();
  }

  void _setupInitialLighting() {
    if (islight) {
      setupLighting(
        LightingConfig(
          radius: width,
          blurBorder: width * 2,
          color: Colors.yellow.withOpacity(0.1),
        ),
      );
    } else {
      setupLighting(
        LightingConfig(radius: 0, color: Colors.transparent),
      );
    }
    _lightingSetupComplete = true;
  }

  @override
  Future<void> update(double dt) async {
    // Handle map 6 completion only once
    if (currentMap == 6 && backgroundMusic == false && !_mapSixProcessed) {
      _mapSixProcessed = true;
      backgroundMusic == true
          ? Sounds.playBackgroundForest()
          : Sounds.stopBackgroundSound();
      CashSaver.SaveData(key: 'complete', value: complete + 3);
      selectMap(7);
    }

    if (isDead) {
      async.Timer(
        const Duration(milliseconds: 500),
            () {
          removeFromParent();
          lastDirectionHorizontal == Direction.right
              ? gameRef.add(Player_death_R(position: position))
              : gameRef.add(Player_death(position: position));
        },
      );
    } else {
      _verifyStamina();
      seeEnemy(
        radiusVision: 200,
        notObserved: () {
          showObserveEnemy = false;
        },
        observed: (enemies) {
          if (showObserveEnemy) return;
          showObserveEnemy = true;
          _showEmote(emote: wonder);
        },
      );
    }

    // Handle animation changes only when needed
    await _handleAnimationChanges();

    super.update(dt);
  }

  Future<void> _handleAnimationChanges() async {
    if (islight && !_currentlyUsingTorchAnimation) {
      // Switch to torch animation
      await replaceAnimation(
        SimpleDirectionAnimation(
          idleRight: PlayerSpriteSheetPlayer.idleRight2,
          idleLeft: PlayerSpriteSheetPlayer.idleLeft2,
          runRight: PlayerSpriteSheetPlayer.runRight2,
          runLeft: PlayerSpriteSheetPlayer.runLeft2,
        ),
      );

      setupLighting(
        LightingConfig(
          radius: width,
          blurBorder: width * 2,
          color: Colors.yellow.withOpacity(0.1),
        ),
      );

      _currentlyUsingTorchAnimation = true;

    } else if (!islight && _currentlyUsingTorchAnimation) {
      // Switch back to normal animation
      await replaceAnimation(
        SimpleDirectionAnimation(
          idleRight: PlayerSpriteSheetPlayer.idleRight,
          idleLeft: PlayerSpriteSheetPlayer.idleLeft,
          runRight: PlayerSpriteSheetPlayer.runRight,
          runLeft: PlayerSpriteSheetPlayer.runLeft,
        ),
      );

      setupLighting(
        LightingConfig(radius: 0, color: Colors.transparent),
      );

      _currentlyUsingTorchAnimation = false;
    }
  }

  @override
  void receiveDamage(AttackOriginEnum attacker, double damage, identify) {
    if (attacker == AttackOriginEnum.ENEMY) {
      SFX ? Sounds.playSFX('ough.mp3') : null;
      showDamage(
        damage,
        config: TextStyle(fontSize: width / 3, color: Colors.red),
      );
    }
    // super.receiveDamage(attacker, damage, identify);
  }

  @override
  Future<void> onDie() async {
    dead++;
    // interstitial.show();
    SFX ? Sounds.playSFX('body_fall.mp3') : null;
    gameRef.colorFilter?.animateTo(Colors.red.withOpacity(0.7),
        blendMode: BlendMode.colorBurn);
    await animation?.playOnce(
      SpriteAnimation.load(
          "Player/MainMovement/player-death.png",
          SpriteAnimationData.sequenced(
              amount: 7,
              stepTime: 0.09,
              textureSize: Vector2(50, 37),
              loop: false)),
      runToTheEnd: true,
      flipX: lastDirectionHorizontal == Direction.right ? false : true,
    );

    gameRef.camera.shake(intensity: 4);
    die_rat = 0;
    die_Skull = 0;
    gameRef.overlays.add(GameOverScreen.id);

    super.onDie();
  }

  @override
  void onJoystickAction(JoystickActionEvent press) {
    if (press.event == ActionEvent.DOWN) {
      if (press.id == AttackType.Swrd ||
          press.id == LogicalKeyboardKey.keyC.keyId) {
        _performSwordAttack();
      }

      if (press.id == AttackType.PowerSwrd ||
          press.id == LogicalKeyboardKey.keyX.keyId) {
        _performPowerSwordAttack();
      }

      if (press.id == AttackType.Punch ||
          press.id == LogicalKeyboardKey.keyS.keyId) {
        _performPunchAttack();
      }

      if (press.id == AttackType.Elec ||
          press.id == LogicalKeyboardKey.keyD.keyId) {
        _performElectricAttack();
      }

      if (press.id == AttackType.light ||
          press.id == LogicalKeyboardKey.keyV.keyId) {
        _toggleLight();
      }

      if (press.id == AttackType.range ||
          press.id == LogicalKeyboardKey.keyZ.keyId) {
        _performRangeAttack();
      }
    }
    super.onJoystickAction(press);
  }

  void _performSwordAttack() {
    if (gameRef.player != null && gameRef.player?.isDead == true) return;
    if (stamina < 15) return;

    SFX ? Sounds.playSFX('sword_hit.mp3') : null;
    decrementStamina(15);
    animation?.playOnce(
      PlayerSpriteSheetPlayer.AttackSwrd_R(),
      runToTheEnd: true,
      flipX: lastDirectionHorizontal == Direction.right ? false : true,
    );
    simpleAttackMelee(
      damage: damagePlayer * 2,
      size: size,
    );
  }

  void _performPowerSwordAttack() {
    if (gameRef.player != null && gameRef.player?.isDead == true) return;
    if (stamina < 15) return;

    SFX ? Sounds.playSFX('Sword_P.wav') : null;
    decrementStamina(20);
    animation?.playOnce(
      PlayerSpriteSheetPlayer.AttackSwrd_R(),
      runToTheEnd: true,
      flipX: lastDirectionHorizontal == Direction.right ? false : true,
    );
    simpleAttackMelee(
      damage: damagePlayer * 3,
      size: size,
      animationRight: PlayerSpriteSheetPlayer.AttackSwrd_FX(),
    );
  }

  void _performPunchAttack() {
    if (gameRef.player != null && gameRef.player?.isDead == true) return;
    if (stamina < 15) return;

    SFX ? Sounds.playSFX('punch.mp3') : null;
    decrementStamina(5);
    animation?.playOnce(
      PlayerSpriteSheetPlayer.AttackPunch_R(),
      runToTheEnd: true,
      flipX: lastDirectionHorizontal == Direction.right ? false : true,
    );
    simpleAttackMelee(
      damage: damagePlayer / 2,
      size: size,
      withPush: true,
    );
  }

  void _performElectricAttack() {
    if (gameRef.player != null && gameRef.player?.isDead == true) return;

    if (PowerE) {
      if (stamina < 15) return;

      SFX ? Sounds.playSFX('electric_shoot.wav') : null;
      decrementStamina(35);
      animation?.playOnce(
        PlayerSpriteSheetPlayer.AttackRange_R(),
        runToTheEnd: true,
        flipX: lastDirectionHorizontal == Direction.right ? false : true,
      );
      simpleAttackMelee(
        damage: damagePlayer * 3,
        size: size,
        animationRight: PlayerSpriteSheetPlayer.AttackElec_FX(),
      );
    } else {
      SFX ? Sounds.playSFX('Wrong.wav') : null;
      _showEmote(emote: wrong);
    }
  }

  void _toggleLight() {
    if (gameRef.player != null && gameRef.player?.isDead == true) return;

    if (CashSaver.getData(key: 'torch') ?? false) {
      islight = !islight;
      SFX ? Sounds.playSFX('LighteSroundFX.mp3') : null;
      // Animation will be handled in the next update cycle
    } else {
      SFX ? Sounds.playSFX('Wrong.wav') : null;
      _showEmote(emote: wrong);
    }
  }

  void _performRangeAttack() {
    if (gameRef.player != null && gameRef.player?.isDead == true) return;

    if (Power) {
      if (stamina < 10) return;

      SFX ? Sounds.playSFX('range_shoot.mp3') : null;
      decrementStamina(15);
      animation?.playOnce(
        PlayerSpriteSheetPlayer.AttackRange_R(),
        flipX: lastDirectionHorizontal == Direction.right ? false : true,
        runToTheEnd: true,
      );
      simpleAttackRange(
        speed: 400,
        lightingConfig: LightingConfig(
            radius: 10, color: Colors.blueAccent, blurBorder: 60),
        damage: damagePlayer,
        animationRight: PlayerSpriteSheetPlayer.Wave_R(),
        id: SimpleDirectionAnimation(
          idleLeft: PlayerSpriteSheetPlayer.Wave_L(),
          idleUp: PlayerSpriteSheetPlayer.Wave_U(),
          idleDown: PlayerSpriteSheetPlayer.Wave_D(),
          idleRight: PlayerSpriteSheetPlayer.Wave_R(),
          runRight: PlayerSpriteSheetPlayer.Wave_R(),
        ),
        animationDestroy: PlayerSpriteSheetPlayer.FX_Wave(),
        size: Vector2(30, 30),
      );
    } else {
      SFX ? Sounds.playSFX('Wrong.wav') : null;
      _showEmote(emote: wrong);
    }
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

  Future<void> _showEmote({required String emote}) async {
    final emoteObject = AnimatedFollowerGameObject(
      animation: SpriteAnimation.load(
        emote,
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.1,
          textureSize: Vector2(32, 32),
          loop: false, // Don't loop the animation
        ),
      ),
      target: gameRef.player!,
      size: Vector2(16, 16),
      offset: Vector2(18, -15),
    );

    gameRef.add(emoteObject);

    // Remove the emote after animation completes
    async.Timer(
      Duration(milliseconds: (8 * 0.1 * 1000).round()), // 8 frames * 0.1s * 1000ms
          () {
        emoteObject.removeFromParent();
      },
    );
  }
}