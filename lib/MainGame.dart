import 'dart:core';
import 'package:bonfire/bonfire.dart';
import 'package:bonfire_flutter_game/Enemy/Bat_purble.dart';
import 'package:bonfire_flutter_game/Enemy/Boss_Ninja.dart';
import 'package:bonfire_flutter_game/Enemy/Dark_Ninja_Enemy.dart';
import 'package:bonfire_flutter_game/NPC/Wizerd_npc.dart';
import 'package:bonfire_flutter_game/SharedPreferences/Cash_Save.dart';
import 'package:bonfire_flutter_game/constant/DynamicMap.dart';
import 'package:bonfire_flutter_game/constant/admob_manager.dart';
import 'package:bonfire_flutter_game/decorations/Lighting.dart';
import 'package:bonfire_flutter_game/followers/You.dart';
import 'package:bonfire_flutter_game/player/Main_Player.dart';
import 'package:flutter/material.dart';
import 'Enemy/Bringer.dart';
import 'Enemy/Dog_Black.dart';
import 'Enemy/Dog_white.dart';
import 'Enemy/Night.dart';
import 'Enemy/Rat.dart';
import 'Enemy/Skeleton.dart';
import 'Enemy/Skull.dart';
import 'Enemy/Witch.dart';
import 'constant/NameOfMaps.dart';
import 'package:bonfire_flutter_game/NPC/Shadow.dart';
import 'constant/Sounds/background.dart';
import 'constant/constant.dart';
import 'decorations/Gate_translate.dart';
import 'decorations/Items.dart';
import 'decorations/Spike.dart';
import 'followers/Fox.dart';
import 'package:admob_flutter/admob_flutter.dart';
double tiledSize = 32 ;
int complete = CashSaver.getData(key: 'complete') ?? 0 ;
bool T = true ;
int currentMap = CashSaver.getData(key: 'Map') ?? 0 ;
late AdmobInterstitial interstitial ;
late AdmobReward rewardAd;
late AdmobBannerSize bannerSize ; ////////
late Function(int) selectMap;

class Just_Like_YouGame extends StatefulWidget {
  const Just_Like_YouGame({Key? key}) : super(key: key);
  @override
  State<Just_Like_YouGame> createState() => _Just_Like_You_Game();
}
class _Just_Like_You_Game extends State<Just_Like_YouGame> {
  @override
  void dispose() {
    Sounds.dispose();
    interstitial.dispose();
    rewardAd.dispose();
    currentMap = 0;
    super.dispose();
  }

  @override
  void initState() {
    interstitial = AdmobInterstitial(adUnitId: adsManager.InterstitialAds_UnitID ,
        listener: (AdmobAdEvent event, Map ) {
      if (event == AdmobAdEvent.closed) interstitial.load();
        },
    );
    rewardAd = AdmobReward(
      adUnitId: adsManager.RewardedAds_UnitID,
      listener: (AdmobAdEvent event, Map) {
        if (event == AdmobAdEvent.closed) rewardAd.load();

      },
    );
    rewardAd.load();
    interstitial.load();
    complete = CashSaver.getData(key: 'complete') ?? 0;
    currentMap = CashSaver.getData(key: 'Map') ?? 0 ;
    selectMap = (int id) {
      setState(() {
        currentMap = id ;
        CashSaver.SaveData(key: 'Map', value: id);
      });
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (currentMap) {
      case 0:
        backgroundMusic == true ? Sounds.playBackground_SpaceSound() : Sounds.stop_Space();
        break;
      case 1:
        backgroundMusic == true ? Sounds.playBackground_background_home() : Sounds.stop_background_home();
        break;
      case 2:
        backgroundMusic == true ? Sounds.playBackground_background_home2() : Sounds.stop_background_home2();
        break;
      case 3:
        backgroundMusic == true ? Sounds.playBackground_bg_Witch() : Sounds.stop_bg_Witch();
        break;
      case 4:
        backgroundMusic == true ? Sounds.playBackground_forest2() : Sounds.stop_forest2();
        break;
      case 5:
        backgroundMusic == true ? Sounds.playBackground_jail_bg() : Sounds.stop_jail_bg();
        break;
      case 6:
        backgroundMusic == true ? Sounds.playBackground_Mind() : Sounds.stop_Mind();
        break;
      default:
        backgroundMusic == true ? Sounds.playBackground_forest2() : Sounds.stop_forest2();
        break;
    }
    switch (currentMap) {

      case 0:  return MainMap(lightingMap:Colors.black38 ,tiledSize: tiledSize, map: WorldMapByTiled(
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
              'Dark_Ninja': (properties) => DarkNinja(properties.position),
              'Boss': (properties) => BossNinja(properties.position),
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
              'Dog_Black': (properties) => Dog_Black(properties.position),
              'Skeleton': (properties) => Skeleton(properties.position),
            }
        ),Player: Kinght(Vector2(90,90))) ;
      case 2: return  MainMap(tiledSize: tiledSize, map: WorldMapByTiled(
          Housereturn,
          forceTileSize: Vector2(tiledSize, tiledSize),
          objectsBuilder: {
            'Boss': (properties) => BossNinja(properties.position),
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
            'You': (properties) => You(properties.position),
            'Skull': (properties) => Skull(properties.position),
            'Bringer': (properties) => Bringer(properties.position),
          }
      ),Player: Kinght(Vector2(90,90))) ;
      case 3: return MainMap(lightingMap:Colors.black54 ,tiledSize: tiledSize, map: WorldMapByTiled(
          RoadMap,
          forceTileSize: Vector2(tiledSize, tiledSize),
          objectsBuilder: {
            'Dark_Ninja': (properties) => DarkNinja(properties.position),
            'Boss': (properties) => BossNinja(properties.position),
            'picktorch': (properties) => Picktorch(position: properties.position),
            'radio': (properties) => Radio_House(position: properties.position),
            'bed_door': (properties) => BedRoom_Door(position: properties.position),
            'fox': (properties) => Fox(properties.position),
            'Bat': (properties) => Bat_purble(properties.position),
            'Witch': (properties) => Witch(properties.position),
            'Skeleton': (properties) => Skeleton(properties.position),
            'torch': (properties) => torch(position: properties.position),
            'Spikes': (properties) => Spikes(properties.position),
            'chest': (properties) => Chest_easter(position: properties.position),
          }
      ),Player: Kinght(Vector2(90,90))) ;
      case 4: return MainMap(lightingMap:Colors.black38 ,tiledSize: tiledSize, map: WorldMapByTiled(
          temple,
          forceTileSize: Vector2(tiledSize, tiledSize),
          objectsBuilder: {
            'Stranger': (properties) => Stranger(properties.position),
            'picktorch': (properties) => Picktorch(position: properties.position),
            'bed_door': (properties) => BedRoom_Door(position: properties.position),
            'fox': (properties) => Fox(properties.position),
            'Dog_Black': (properties) => Dog_Black(properties.position),
            'Dog_White': (properties) => Dog_White(properties.position),
            'Bat': (properties) => Bat_purble(properties.position),
            'Witch': (properties) => Witch(properties.position),
            'Skeleton': (properties) => Skeleton(properties.position),
            'torch': (properties) => torch(position: properties.position),
            'Spikes': (properties) => Spikes(properties.position),
            'Tower_1': (properties) => Tower_1(position: properties.position),
            'Tower_2': (properties) => Tower_2(position: properties.position),
            'Tower_3': (properties) => Tower_3(position: properties.position),
            'safe': (properties) => safe(position: properties.position),
            'Rats': (properties) => Rat(properties.position),
            'chest': (properties) => Chest_easter(position: properties.position),
            'portal_Jail': (properties) => portal_Jail(position: properties.position),

          }
      ),Player: Kinght(Vector2(90,90))) ;
      case 5: return MainMap(lightingMap:Colors.black.withOpacity(0.8) ,tiledSize: tiledSize, map: WorldMapByTiled(
          jail,
          forceTileSize: Vector2(tiledSize, tiledSize),
          objectsBuilder: {
            'picktorch': (properties) => Picktorch(position: properties.position),
            'Rats': (properties) => Rat(properties.position),
            'bed_door': (properties) => BedRoom_Door(position: properties.position),
            'fox': (properties) => Fox(properties.position),
            'Bat': (properties) => Bat_purble(properties.position),
            'Witch': (properties) => Witch(properties.position),
            'Skeleton': (properties) => Skeleton(properties.position),
            'torch': (properties) => torch(position: properties.position),
            'Spikes': (properties) => Spikes(properties.position),
            'gate': (properties) => Portal(position: properties.position),
            'Elec': (properties) => Elec(position: properties.position),
            'chest': (properties) => Chest_easter(position: properties.position),
          }
      ),Player: Kinght(Vector2(90,90))) ;
      case 6: return MainMap(tiledSize: tiledSize, map: WorldMapByTiled(
          Mind,
          forceTileSize: Vector2(tiledSize, tiledSize),
          objectsBuilder: {
            'You': (properties) => You(properties.position),
            'safe': (properties) => safe(position: properties.position),
          }
      ),Player: Kinght(Vector2(90,90))) ;
      default:
        return MainMap(lightingMap:Colors.black38 ,tiledSize: tiledSize, map: WorldMapByTiled(
            Last,
            forceTileSize: Vector2(tiledSize, tiledSize),
            objectsBuilder: {
              'fox': (properties) => Fox(properties.position),
              'Nightmare': (properties) => Nightmare(properties.position),
              'You': (properties) => You(properties.position),
              'RED': (properties) => Key_red(properties.position),
              'chest': (properties) => Chest_easter(position: properties.position),
              'Skull': (properties) => Skull(properties.position),
              'Dog_black': (properties) => Dog_Black(properties.position),
              'dog_white': (properties) => Dog_White(properties.position),
              'Rats': (properties) => Rat(properties.position),
              'portal_X': (properties) => Portal_Mind( position: properties.position),

            }
        ),Player: Kinght(Vector2(90,90))) ;

    }
  }
  
}
