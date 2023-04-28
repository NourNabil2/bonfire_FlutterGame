import 'package:bonfire/bonfire.dart';
import 'package:bonfire_flutter_game/NPC/Wizerd_npc.dart';
import 'package:bonfire_flutter_game/player/Main_Player.dart';
import 'package:flutter/material.dart';
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
            }
        ),
        joystick: Joystick(
        directional: JoystickDirectional(),
        keyboardConfig: KeyboardConfig(),
      ),
        player: Kinght(Vector2(tiledSize,tiledSize)),


    );
  }
}
