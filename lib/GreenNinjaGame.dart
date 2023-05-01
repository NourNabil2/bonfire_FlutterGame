import 'package:bonfire/bonfire.dart';
import 'package:bonfire_flutter_game/Enemy/Boss_Ninja.dart';
import 'package:bonfire_flutter_game/Enemy/Dark_Ninja_Enemy.dart';
import 'package:bonfire_flutter_game/Enemy/Demon_enemy.dart';
import 'package:bonfire_flutter_game/NPC/Wizerd_npc.dart';
import 'package:bonfire_flutter_game/Screens/LoseScreen.dart';
import 'package:bonfire_flutter_game/Screens/WinScreen.dart';
import 'package:bonfire_flutter_game/constant/constant.dart';
import 'package:bonfire_flutter_game/decorations/Lighting.dart';
import 'package:bonfire_flutter_game/player/Main_Player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constant/Maps.dart';
import '';
double tiledSize = 32 ;
MapId currentMapId = MapId.one;
late Function(MapId) selectMap;

class GreenNinjaGame extends StatefulWidget {
  const GreenNinjaGame({Key? key}) : super(key: key);

  @override
  State<GreenNinjaGame> createState() => _GreenNinjaGameState();
}

class _GreenNinjaGameState extends State<GreenNinjaGame> {
  @override
  void dispose() {
    currentMapId = MapId.one;
    super.dispose();
  }

  @override
  void initState() {
    selectMap = (MapId id) {
      setState(() {
        currentMapId = id;
      });
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (currentMapId) {
      case MapId.one:
      case MapId.two:
      case MapId.three:
      default:
        return BonfireWidget(
          key: Key(DateTime.now().toIso8601String()),
          overlayBuilderMap: {
            GameOverScreen.id: (context, game) => const GameOverScreen(),
            LevelWonScreen.id: (context, game) => const LevelWonScreen(),
            'mini_map': (context, game) =>
                MiniMap(
                  game: game,
                  margin: const EdgeInsets.all(20),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.5),
                  ),
                )
          },
          initialActiveOverlays: const <String>['mini_map'],
          lightingColorGame: Colors.black54,
          cameraConfig: CameraConfig(zoom: 1.8),
          map: WorldMapByTiled(
              mapone, forceTileSize: Vector2(tiledSize, tiledSize),
              objectsBuilder: {
                'Wizard_oldMan': (properties) => WizerdMan(properties.position),
                'Dark_Ninja': (properties) => DarkNinja(properties.position),
                'Boss': (properties) => BossNinja(properties.position),
                'demon': (properties) => Demon(properties.position),
                'torch': (properties) => torch(position: properties.position),
                'picktorch': (properties) =>
                    Picktorch(position: properties.position),

              }
          ),
          joystick: Joystick(
            directional: JoystickDirectional(),
            keyboardConfig: KeyboardConfig(
              acceptedKeys: [
                LogicalKeyboardKey.space,
                LogicalKeyboardKey.controlLeft
              ],
            ),


            actions: [
              JoystickAction(actionId: AttackType.melee,
                  size: 80,
                  margin: const EdgeInsets.only(bottom: 50, right: 50),
                  align: JoystickActionAlign.BOTTOM_RIGHT,
                  sprite: Sprite.load('sword.png')),
              JoystickAction(actionId: AttackType.range,
                  size: 50,
                  margin: const EdgeInsets.only(bottom: 50, right: 200),
                  align: JoystickActionAlign.BOTTOM_RIGHT,
                  sprite: Sprite.load('shuriken_single.png')),
            ],
          ),
          player: Kinght(Vector2(tiledSize, tiledSize)),


        );
    }
  }
}
