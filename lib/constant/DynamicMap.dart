import 'dart:core';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:bonfire/bonfire.dart';
import 'package:bonfire_flutter_game/Screens/LoseScreen.dart';
import 'package:bonfire_flutter_game/Screens/PauseScreen.dart';
import 'package:bonfire_flutter_game/constant/Interface/player_InterFace.dart';
import 'package:bonfire_flutter_game/constant/Sounds/background.dart';
import 'package:bonfire_flutter_game/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bonfire_flutter_game/constant/admob_manager.dart';

import '../Screens/Purchese.dart';


Widget MainMap (
    {
      required double tiledSize ,
      required GameMap map ,
      required Player Player ,
      Color lightingMap = Colors.transparent ,

    }
    )=>BonfireWidget(
    key: Key(DateTime.now().toIso8601String()),
    interface: KnightInterface(),
    gameController: GameController(),
    overlayBuilderMap: {
      GameOverScreen.id: (context, game) => const GameOverScreen(),
      PauseScreen.id: (context, game ) => PauseScreen(game: game ,),
      'mini_map': (context, game) =>
          MiniMap(
            game: game,
            zoom: 0.6,
            size: Vector2.all(100),
            margin: const EdgeInsets.all(20),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.5),
            ),
          ),
      'BannerAds' : (context, game) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AdmobBanner(adUnitId: adsManager.BannerAds_UnitID, adSize: AdmobBannerSize.SMART_BANNER(context)),
        ],
      ),
      'Pause' : (context, game) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: MaterialButton(
          child: Image(image: AssetImage('assets/images/image_Interface/Pause.png'), width: 50),
          onPressed: (){
            game.overlayManager.add(PauseScreen.id);
            game.gameController!.gameRef.pauseEngine();
            Sounds.pauseBackgroundSound();
          },
        ),
      ),

    },

    initialActiveOverlays: const <String>['mini_map','Pause','BannerAds'],

    lightingColorGame: lightingMap,
    cameraConfig: CameraConfig(zoom: 1.5),
    map: map,
    joystick: Joystick(

      directional: JoystickDirectional(
        // margin: const EdgeInsets.only(bottom: 120, left: 120),
        spriteKnobDirectional: selected == 1 ? Sprite.load(
          "Player/Joystick/joystick_knob.png",
        ) : selected == 2? Sprite.load(
          "Player/Joystick/joystick_stick.png",
        ) : null,
        spriteBackgroundDirectional: selected == 1? Sprite.load(
          "Player/Joystick/joystick_background.png",
        ) :selected == 2? Sprite.load(
          "Player/Joystick/joystick_bg.png",
        ) : null,
        color: Colors.grey,
        size: 100,
        isFixed: true,

      ),

      keyboardConfig: KeyboardConfig(
        acceptedKeys: [
          LogicalKeyboardKey.space,
          LogicalKeyboardKey.keyC,
          LogicalKeyboardKey.keyX,
          LogicalKeyboardKey.keyV,
          LogicalKeyboardKey.keyZ,
          LogicalKeyboardKey.keyS,
          LogicalKeyboardKey.keyD,
        ],
      ),
      actions: [

        JoystickAction(actionId: AttackType.Swrd,
            size: 50,
            margin: const EdgeInsets.only(bottom: 150, right: 100),
            align: JoystickActionAlign.BOTTOM_RIGHT,
            sprite: Sprite.load('Player/Joystick/swrd.png')),
        JoystickAction(actionId: AttackType.PowerSwrd,
            size: 50,
            margin: const EdgeInsets.only(bottom: 150, right: 40),
            align: JoystickActionAlign.BOTTOM_RIGHT,
            sprite: Sprite.load('Player/Joystick/swrd_P.png')
        ),
        JoystickAction(actionId: AttackType.light,
            size: 35,
            margin: const EdgeInsets.only(top: 80, left: 50),
            align: JoystickActionAlign.TOP_LEFT,
            sprite: Sprite.load('Player/Joystick/torch.png')),
        JoystickAction(actionId: AttackType.range,
            size: 50,
            margin: const EdgeInsets.only(bottom: 50, right: 220),
            align: JoystickActionAlign.BOTTOM_RIGHT,
            sprite: Sprite.load('Player/Joystick/range.png')),
        JoystickAction(actionId: AttackType.Elec,
            size: 50,
            margin: const EdgeInsets.only(bottom: 50, right: 150),
            align: JoystickActionAlign.BOTTOM_RIGHT,
            sprite: Sprite.load('Player/Joystick/elec.png')
        ),
        JoystickAction(actionId: AttackType.Punch,
            size: 80,
            margin: const EdgeInsets.only(bottom: 50, right: 50),
            align: JoystickActionAlign.BOTTOM_RIGHT,
            sprite: Sprite.load('Player/Joystick/punch.png')
        ),
      ],
    ),
    player: Player



);