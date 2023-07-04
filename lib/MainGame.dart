import 'package:bonfire/bonfire.dart';
import 'package:bonfire_flutter_game/Enemy/Boss_Ninja.dart';
import 'package:bonfire_flutter_game/Enemy/Dark_Ninja_Enemy.dart';
import 'package:bonfire_flutter_game/Enemy/Demon_enemy.dart';
import 'package:bonfire_flutter_game/NPC/Wizerd_npc.dart';
import 'package:bonfire_flutter_game/constant/DynamicMap.dart';
import 'package:bonfire_flutter_game/decorations/Lighting.dart';
import 'package:bonfire_flutter_game/player/Main_Player.dart';
import 'package:flutter/material.dart';
import 'constant/NameOfMaps.dart';
import 'package:bonfire_flutter_game/NPC/Shadow.dart';
import 'constant/Sounds/background.dart';
import 'constant/constant.dart';
import 'decorations/Items.dart';
double tiledSize = 32 ;
bool istrue = true ;
MapId currentMapId = MapId.one;
late Function(MapId) selectMap;

class Just_Like_YouGame extends StatefulWidget {
  const Just_Like_YouGame({Key? key}) : super(key: key);

  @override
  State<Just_Like_YouGame> createState() => _GreenNinjaGameState();
}

class _GreenNinjaGameState extends State<Just_Like_YouGame> {
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

        switch (currentMapId) {
          case MapId.one:
            backgroundMusic == true ? Sounds.playBackground_SpaceSound() : Sounds.stop_Space();
            break;
          case MapId.two:
          // TODO: Handle this case.
            break;
          case MapId.three:
          // TODO: Handle this case.
            break;
        }



    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (currentMapId) {
      case MapId.one: return MainMap(tiledSize: tiledSize, map: WorldMapByTiled(
          istrue? RoadMap : Green,
          forceTileSize: Vector2(tiledSize, tiledSize),
          objectsBuilder: {
            'Wizard_oldMan': (properties) => WizerdMan(properties.position),
            'Dark_Ninja': (properties) => DarkNinja(properties.position),
            'Boss': (properties) => BossNinja(properties.position),
            'demon': (properties) => Demon(properties.position),
            'torch': (properties) => torch(position: properties.position),
            'picktorch': (properties) => Picktorch(position: properties.position),
            'nothing': (properties) => Shadow(properties.position),
            'radio': (properties) => Radio_House(position: properties.position),
            'bed_door': (properties) => BedRoom_Door(position: properties.position),
            'chest_1': (properties) => Chest_easter(position: properties.position),
          }
      ),Player: Kinght(Vector2(90,90))) ;
      case MapId.two:
      case MapId.three:
      default:
      return MainMap(tiledSize: tiledSize, map: WorldMapByTiled(
           RoadMap,
          forceTileSize: Vector2(tiledSize, tiledSize),
          objectsBuilder: {
            'Wizard_oldMan': (properties) => WizerdMan(properties.position),
            'Dark_Ninja': (properties) => DarkNinja(properties.position),
            'Boss': (properties) => BossNinja(properties.position),
            'demon': (properties) => Demon(properties.position),
            'torch': (properties) => torch(position: properties.position),
            'picktorch': (properties) => Picktorch(position: properties.position),
            'radio': (properties) => Radio_House(position: properties.position),
            'bed_door': (properties) => BedRoom_Door(position: properties.position),
          }
      ),Player: Kinght(Vector2(90,90))) ;

    }
  }
}
