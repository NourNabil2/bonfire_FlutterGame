import 'dart:async';
import 'dart:math';
import 'package:bonfire_flutter_game/Screens/Purchese.dart';
import 'package:bonfire_flutter_game/constant/admob_manager.dart';
import 'package:bonfire_flutter_game/MainGame.dart';
import 'package:bonfire_flutter_game/Screens/settingScreen.dart';
import 'package:bonfire_flutter_game/constant/Buttons.dart';
import 'package:bonfire_flutter_game/constant/Hero_Dialog.dart';
import 'package:bonfire_flutter_game/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart'; // Import the google_mobile_ads package
import '../NPC/Shadow.dart';
import '../SharedPreferences/Cash_Save.dart';
import '../constant/Sounds/background.dart';
import 'About_Screen.dart';

class Start_Screen extends StatefulWidget {
  const Start_Screen({Key? key}) : super(key: key);

  @override
  State<Start_Screen> createState() => _Start_ScreenState();
}

List<String> background = ['assets/images/image_Interface/BG.gif', 'assets/images/image_Interface/Coffee_in_rain.gif'];

class _Start_ScreenState extends State<Start_Screen> {
  BannerAd? _bannerAd;
  bool _isBannerAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();

    setState(() {
      backgroundMusic == true ? Sounds.playBackgroundRainNoise() : Sounds.stopBackgroundSound();
    });
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: AdsManager.bannerAdUnitId,
      size: AdSize.fullBanner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            print('_isBannerAdLoaded: $_isBannerAdLoaded');
            _isBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          print('Failed AD: $error');
          ad.dispose(); // Dispose failed ad
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(image: AssetImage(background[Random().nextInt(2)]), width: double.infinity, fit: BoxFit.fill),
          ClipPath(
            clipper: Tringle(),
            child: Container(
              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.7)),
              width: 350,
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Button(
                        width: 70,
                        height: 150,
                        isboxShadow: true,
                        border: true,
                        radius: 50,
                        ColorOfButton: Colors.red,
                        text: currentMap == 0 ? 'New Game' : 'Start',
                        Function: () async {
                          Sounds.stopBackgroundSound();
                          SFX ?Sounds.playSFX('game-start.mp3') : null;
                          setState(() {
                            isPressed = !isPressed;
                          });
                          await Future.delayed(const Duration(milliseconds: 300));
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Just_Like_YouGame()),
                                (route) => false,
                          );
                          setState(() {
                            isPressed = !isPressed;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (currentMap != 0)
                      Expanded(
                        child: Button(
                          width: Width_Button - 30,
                          height: Height_Button,
                          isboxShadow: false,
                          border: false,
                          radius: 10,
                          ColorOfButton: Colors.blueGrey,
                          text: 'New Game',
                          Function: () {
                            Alert(
                              context: context,
                              type: AlertType.warning,
                              title: "You will lose all your progress!!",
                              desc: "Are you sure you want to restart the game?",
                              buttons: [
                                DialogButton(
                                  onPressed: () {
                                    close = false;
                                    CashSaver.Clearall();
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (context) => Just_Like_YouGame()),
                                          (route) => false,
                                    );
                                  },
                                  color: Colors.red[500],
                                  child: const Text(
                                    "Yes",
                                    style: TextStyle(
                                        decoration: TextDecoration.none, color: Colors.black, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DialogButton(
                                  onPressed: () => Navigator.pop(context),
                                  color: Colors.blueGrey,
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(
                                        decoration: TextDecoration.none, color: Colors.black, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ).show();
                          },
                        ),
                      ),
                    const SizedBox(height: 15),
                    Expanded(
                      child: Button(
                        width: Width_Button,
                        height: Height_Button,
                        isboxShadow: false,
                        border: false,
                        radius: 10,
                        ColorOfButton: Colors.blueGrey,
                        text: 'Settings',
                        Function: () async {
                          await Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                            return const SettingPopupCard();
                          }));
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                      child: Button(
                        width: Width_Button + 30,
                        height: Height_Button,
                        isboxShadow: false,
                        border: false,
                        radius: 10,
                        ColorOfButton: Colors.blueGrey,
                        text: 'About Us',
                        Function: () async {
                          await Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                            return const About_screen();
                          }));
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                      child: Button(
                        width: Width_Button + 60,
                        height: Height_Button,
                        isboxShadow: false,
                        border: false,
                        radius: 10,
                        ColorOfButton: Colors.blueGrey,
                        text: 'Exit',
                        Function: () {
                          SystemNavigator.pop();
                        },
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text('Discover: $complete%'),
                  ],
                ),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  MaterialButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Purchases())),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Image.asset('assets/images/image_Interface/purchases.png', width: 80),
                    ),
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _isBannerAdLoaded
                    ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: _bannerAd?.size.height.toDouble(),
                    width: _bannerAd?.size.width.toDouble(),
                    child: AdWidget(ad: _bannerAd!),
                  ),
                )
                    : SizedBox(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
