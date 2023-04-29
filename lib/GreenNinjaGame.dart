import 'package:bonfire/bonfire.dart';
import 'package:bonfire_flutter_game/Enemy/Dark_Ninja_Enemy.dart';
import 'package:bonfire_flutter_game/NPC/Wizerd_npc.dart';
import 'package:bonfire_flutter_game/constant/constant.dart';
import 'package:bonfire_flutter_game/player/Main_Player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constant/Maps.dart';
import '';
double tiledSize = 32 ;

class GreenNinjaGame extends StatefulWidget {
  const GreenNinjaGame({Key? key}) : super(key: key);

  @override
  State<GreenNinjaGame> createState() => _GreenNinjaGameState();
}

class _GreenNinjaGameState extends State<GreenNinjaGame> {
  @override
  Widget build(BuildContext context) {
    return BonfireWidget(
      cameraConfig: CameraConfig(zoom: 1.8),
        map:WorldMapByTiled(mapone,forceTileSize: Vector2(tiledSize, tiledSize),
            objectsBuilder: {
          'Wizard_oldMan' :(properties) => WizerdMan(properties.position),
              'Dark_Ninja' : (properties) => DarkNinja(properties.position),
            }
        ),
        joystick: Joystick(
        directional: JoystickDirectional(),
        keyboardConfig: KeyboardConfig(
          acceptedKeys: [LogicalKeyboardKey.space,LogicalKeyboardKey.controlLeft],
        ),

          
          actions: [
            JoystickAction(actionId: AttackType.melee ,size: 80,margin: const EdgeInsets.only(bottom: 50,right: 50),align: JoystickActionAlign.BOTTOM_RIGHT,sprite: Sprite.load('sword.png')),
            JoystickAction(actionId: AttackType.range ,size: 50,margin: const EdgeInsets.only(bottom: 50,right: 200),align: JoystickActionAlign.BOTTOM_RIGHT,sprite: Sprite.load('shuriken_single.png')),
          ],
      ),
        player: Kinght(Vector2(tiledSize,tiledSize)),


    );
  }
}
