import 'package:bonfire/bonfire.dart';
import 'package:bonfire_flutter_game/Enemy/Boss_Ninja.dart';
import 'package:bonfire_flutter_game/Enemy/Dark_Ninja_Enemy.dart';
import 'package:bonfire_flutter_game/Enemy/Demon_enemy.dart';
import 'package:bonfire_flutter_game/NPC/Wizerd_npc.dart';
import 'package:bonfire_flutter_game/SharedPreferences/Cash_Save.dart';
import 'package:bonfire_flutter_game/constant/DynamicMap.dart';
import 'package:bonfire_flutter_game/constant/onBoarding.dart';
import 'package:bonfire_flutter_game/decorations/Lighting.dart';
import 'package:bonfire_flutter_game/player/Main_Player.dart';
import 'package:flutter/material.dart';
import 'Enemy/Rat.dart';
import 'constant/NameOfMaps.dart';
import 'package:bonfire_flutter_game/NPC/Shadow.dart';
import 'constant/Sounds/background.dart';
import 'constant/constant.dart';
import 'decorations/Items.dart';
import 'followers/Fox.dart';
double tiledSize = 32 ;
bool istrue = true ;
int currentMap = CashSaver.getData(key: 'Map') ?? 0 ;
late Function(int) selectMap;

class Just_Like_YouGame extends StatefulWidget {
  const Just_Like_YouGame({Key? key}) : super(key: key);

  @override
  State<Just_Like_YouGame> createState() => _GreenNinjaGameState();
}

class _GreenNinjaGameState extends State<Just_Like_YouGame> {

  @override
  void dispose() {
    currentMap = 0 ;
    super.dispose();
  }

  @override
  void initState() {
    currentMap = CashSaver.getData(key: 'Map') ?? 0 ;
    selectMap = (int id) {
      setState(() {
        currentMap = id ;
        CashSaver.SaveData(key: 'Map', value: id);
      });
    };

        switch (currentMap) {
          case 0:
            backgroundMusic == true ? Sounds.playBackground_SpaceSound() : Sounds.stop_Space();
            break;
          case 1:
          // TODO: Handle this case.
            break;
          case 2:
          // TODO: Handle this case.
            break;
        }



    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (currentMap) {

      case 0: return MainMap(tiledSize: tiledSize, lightingMap: Colors.black38,map: WorldMapByTiled(
          nothingness,
          forceTileSize: Vector2(tiledSize, tiledSize),
          objectsBuilder: {
            'nothing': (properties) => Shadow(properties.position),
          }
      ),Player: Kinght(Vector2(90,90))) ;
      case 1: return  MainMap(tiledSize: tiledSize, map: WorldMapByTiled(
          House,
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
              'Mirror_C': (properties) => Mirror_C(position: properties.position),
              'fox': (properties) => Fox(properties.position),
              'Silver_Key': (properties) => Key_silver(position: properties.position, keyImage: SilverKey),
              'Rat': (properties) => Rat(properties.position),
            }
        ),Player: Kinght(Vector2(90,90))) ;
      case 2: return  MainMap(tiledSize: tiledSize, map: WorldMapByTiled(
          Housereturn,
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
            'Mirror_C': (properties) => Mirror_C(position: properties.position),
            'fox': (properties) => Fox(properties.position),
            'Silver_Key': (properties) => Key_silver(position: properties.position, keyImage: SilverKey),
            'Rat': (properties) => Rat(properties.position),
            'safe': (properties) => safe(position: properties.position),
          }
      ),Player: Kinght(Vector2(90,90))) ;
      default:
      return MainMap(lightingMap:Colors.black38 ,tiledSize: tiledSize, map: WorldMapByTiled(
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
            'fox': (properties) => Fox(properties.position),
          }
      ),Player: Kinght(Vector2(90,90))) ;

    }
  }
}
