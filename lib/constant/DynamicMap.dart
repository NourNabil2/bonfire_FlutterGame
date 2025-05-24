import 'dart:core';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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

/// **Banner Ad Widget**
Widget buildBannerAd() {
  BannerAd bannerAd = BannerAd(
    adUnitId: AdsManager.bannerAdUnitId,
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(
      onAdLoaded: (Ad ad) => print("Banner Ad Loaded"),
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        print("Banner Ad Failed to Load: $error");
        ad.dispose();
      },
    ),
  );

  // Load the ad
  bannerAd.load();

  return SizedBox(
    height: 50,
    child: AdWidget(ad: bannerAd),
  );
}

Widget MainMap({
  required double tiledSize,
  required GameMap map,
  required Player Player,
  Color lightingMap = Colors.transparent,
}) =>
    BonfireWidget(

      key: Key(DateTime.now().toIso8601String()),
      interface: KnightInterface(),
      overlayBuilderMap: {
        GameOverScreen.id: (context, game) => const GameOverScreen(),
        PauseScreen.id: (context, game) => PauseScreen(game: game),
        'mini_map': (context, game) => MiniMap(
          game: game,
          zoom: 0.6,
          size: Vector2.all(100),
          margin: const EdgeInsets.all(20),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        'BannerAds': (context, game) => Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            buildBannerAd(), // Use the new function here
          ],
        ),
        'Pause': (context, game) => Padding(
          padding: const EdgeInsets.all(10.0),
          child: MaterialButton(
            child: const Image(
                image:
                AssetImage('assets/images/image_Interface/Pause.png'),
                width: 50),
            onPressed: () {
              game.overlays.add(PauseScreen.id);
              game.pauseEngine();
              Sounds.pauseBackgroundSound();
            },
          ),
        ),
      },
      initialActiveOverlays: const <String>['mini_map', 'Pause', 'BannerAds'],
      lightingColorGame: lightingMap,
      cameraConfig: CameraConfig(zoom: 1.5),
      map: map,
      playerControllers: [
        Joystick(
          directional: JoystickDirectional(
            spriteKnobDirectional: selected == 1
                ? Sprite.load("Player/Joystick/joystick_knob.png")
                : selected == 2
                ? Sprite.load("Player/Joystick/joystick_stick.png")
                : null,
            spriteBackgroundDirectional: selected == 1
                ? Sprite.load("Player/Joystick/joystick_background.png")
                : selected == 2
                ? Sprite.load("Player/Joystick/joystick_bg.png")
                : null,
            color: Colors.grey,
            size: 100,
            isFixed: true,
          ),
          id: KeyboardConfig(
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
            JoystickAction(
                actionId: AttackType.Swrd,
                size: 50,
                margin: const EdgeInsets.only(bottom: 150, right: 100),
                // align: JoystickActionAlign.BOTTOM_RIGHT,
                alignment: Alignment.bottomRight,
                sprite: Sprite.load('Player/Joystick/swrd.png')),
            JoystickAction(
                actionId: AttackType.PowerSwrd,
                size: 50,
                margin: const EdgeInsets.only(bottom: 150, right: 40),
               // align: JoystickActionAlign.BOTTOM_RIGHT,
                alignment: Alignment.bottomRight,
                sprite: Sprite.load('Player/Joystick/swrd_P.png')),
            JoystickAction(
                actionId: AttackType.light,
                size: 35,
                margin: const EdgeInsets.only(top: 80, left: 50),
                //align: JoystickActionAlign.TOP_LEFT,
                alignment: Alignment.topLeft,
                sprite: Sprite.load('Player/Joystick/torch.png')),
            JoystickAction(
                actionId: AttackType.range,
                size: 50,
                margin: const EdgeInsets.only(bottom: 50, right: 220),
                //align: JoystickActionAlign.BOTTOM_RIGHT,
                alignment: Alignment.bottomRight,
                sprite: Sprite.load('Player/Joystick/range.png')),
            JoystickAction(
                actionId: AttackType.Elec,
                size: 50,
                margin: const EdgeInsets.only(bottom: 50, right: 150),
                //align: JoystickActionAlign.BOTTOM_RIGHT,
                alignment: Alignment.bottomRight,
                sprite: Sprite.load('Player/Joystick/elec.png')),
            JoystickAction(
                actionId: AttackType.Punch,
                size: 80,
                margin: const EdgeInsets.only(bottom: 50, right: 50),
                //align: JoystickActionAlign.BOTTOM_RIGHT,
                alignment: Alignment.bottomRight,
                sprite: Sprite.load('Player/Joystick/punch.png')),
          ],
        ),
      ],
      player: Player,
    );
