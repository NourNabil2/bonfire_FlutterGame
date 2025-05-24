import 'dart:core';
import 'dart:developer';
import 'package:bonfire/bonfire.dart';
import 'package:bonfire_flutter_game/Enemy/Boss_Ninja.dart';
import 'package:bonfire_flutter_game/Enemy/Dark_Ninja_Enemy.dart';
import 'package:bonfire_flutter_game/SharedPreferences/Cash_Save.dart';
import 'package:bonfire_flutter_game/constant/DynamicMap.dart';
import 'package:bonfire_flutter_game/constant/adService.dart';
import 'package:bonfire_flutter_game/constant/admob_manager.dart';
import 'package:bonfire_flutter_game/decorations/Lighting.dart';
import 'package:bonfire_flutter_game/followers/You.dart';
import 'package:bonfire_flutter_game/player/Main_Player.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart'; // Updated import
import 'Enemy/Dog_Black.dart';
import 'Enemy/Dog_white.dart';
import 'Enemy/Night.dart';
import 'Enemy/Rat.dart';
import 'Enemy/Skeleton.dart';
import 'Enemy/Skull.dart';
import 'constant/NameOfMaps.dart';
import 'package:bonfire_flutter_game/NPC/Shadow.dart';
import 'constant/Sounds/background.dart';
import 'constant/constant.dart';
import 'decorations/Items.dart';
import 'followers/Fox.dart';

double tiledSize = 32;
int complete = CashSaver.getData(key: 'complete') ?? 0;
bool T = true;
int currentMap = CashSaver.getData(key: 'Map') ?? 0;

late Function(int) selectMap;

class Just_Like_YouGame extends StatefulWidget {
  const Just_Like_YouGame({Key? key}) : super(key: key);

  @override
  State<Just_Like_YouGame> createState() => _Just_Like_You_Game();
}

class _Just_Like_You_Game extends State<Just_Like_YouGame> {
  InterstitialAd? interstitialAd;
  RewardedAd? rewardedAd;
  BannerAd? bannerAd;
  bool isBannerAdLoaded = false;
  final AdsService _adsService = AdsService();
  @override
  void initState() {
    super.initState();
    _adsService.initialize();
    // // Initialize Google Mobile Ads SDK
    // MobileAds.instance.initialize().then((status) {
    //   log("Google Mobile Ads SDK Initialized: ${status.adapterStatuses[0]!.state}");
    //   // Load interstitial ad
    //   InterstitialAd.load(
    //     adUnitId: AdsManager.interstitialAdUnitId,
    //     request: const AdRequest(),
    //     adLoadCallback: InterstitialAdLoadCallback(
    //       onAdLoaded: (InterstitialAd ad) {
    //         interstitialAd = ad;
    //         interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
    //           onAdDismissedFullScreenContent: (InterstitialAd ad) {
    //             ad.dispose();
    //             _loadInterstitialAd();
    //           },
    //           onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
    //             ad.dispose();
    //             _loadInterstitialAd();
    //           },
    //         );
    //       },
    //       onAdFailedToLoad: (LoadAdError error) {
    //         print('Interstitial ad failed to load: $error');
    //       },
    //     ),
    //   );
    //
    //   // Load rewarded ad
    //   RewardedAd.load(
    //     adUnitId: AdsManager.rewardedAdUnitId,
    //     request: AdRequest(),
    //     rewardedAdLoadCallback: RewardedAdLoadCallback(
    //       onAdLoaded: (RewardedAd ad) {
    //         rewardedAd = ad;
    //         rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
    //           onAdDismissedFullScreenContent: (RewardedAd ad) {
    //             ad.dispose();
    //             _loadRewardedAd();
    //           },
    //           onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
    //             ad.dispose();
    //             _loadRewardedAd();
    //           },
    //         );
    //       },
    //       onAdFailedToLoad: (LoadAdError error) {
    //         print('Rewarded ad failed to load: $error');
    //       },
    //     ),
    //   );
    //
    //   // Load banner ad
    //   bannerAd = BannerAd(
    //     adUnitId: AdsManager.bannerAdUnitId,
    //     size: AdSize.banner,
    //     request: AdRequest(),
    //     listener: BannerAdListener(
    //       onAdLoaded: (Ad ad) {
    //         print('Banner ad loaded.');
    //         setState(() {
    //           isBannerAdLoaded = true;
    //         });
    //       },
    //       onAdFailedToLoad: (Ad ad, LoadAdError error) {
    //         print('Banner ad failed to load: $error');
    //       },
    //     ),
    //   );
    //   bannerAd!.load();
    // });

    // Initialize other necessary data
    complete = CashSaver.getData(key: 'complete') ?? 0;
    currentMap = CashSaver.getData(key: 'Map') ?? 0;

    // Select map function
    selectMap = (int id) {
      setState(() {
        currentMap = id;
        CashSaver.SaveData(key: 'Map', value: id);
      });
    };
  }

  @override
  void dispose() {
    FlameAudio.bgm.dispose();
    _adsService.disposeAds();
    // interstitialAd?.dispose();
    // rewardedAd?.dispose();
    // bannerAd?.dispose();
    super.dispose();
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdsManager.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('Interstitial ad failed to load: $error');
        },
      ),
    );
  }

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdsManager.rewardedAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          rewardedAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('Rewarded ad failed to load: $error');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Handle background music based on the current map
    Sounds.handleBackgroundMusic();

    return Scaffold(
      body: Stack(
        children: [
          _buildGameContent(),

          // Show banner ad with ValueListenableBuilder
          ValueListenableBuilder<bool>(
            valueListenable: _adsService.bannerNotifier,
            builder: (context, isVisible, _) {
              if (isVisible && _adsService.bannerAd != null) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: _adsService.bannerAd!.size.width.toDouble(),
                    height: _adsService.bannerAd!.size.height.toDouble(),
                    child: AdWidget(ad: _adsService.bannerAd!),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }



  Widget _buildGameContent() {
    switch (currentMap) {
      case 0:
        return MainMap(
          lightingMap: Colors.black38,
          tiledSize: tiledSize,
          map: WorldMapByTiled(
            WorldMapReader.fromAsset(nothingness),
            forceTileSize: Vector2(tiledSize, tiledSize),
            objectsBuilder: {
              'nothing': (properties) => Shadow(properties.position),
            },
          ),
          player: Kinght(position: Vector2(90, 90)),
        );
      case 1:
        return MainMap(
          tiledSize: tiledSize,
          map: WorldMapByTiled(
            WorldMapReader.fromAsset(House),
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
            },
          ),
          player: Kinght(position: Vector2(90, 90)),
        );
    // Add other cases for different maps here...
      default:
        return MainMap(
          lightingMap: Colors.black38,
          tiledSize: tiledSize,
          map: WorldMapByTiled(
            WorldMapReader.fromAsset(Last)
            ,
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
              'portal_X': (properties) => Portal_Mind(position: properties.position),
            },
          ),
          player: Kinght(position: Vector2(90, 90)),
        );
    }
  }
}