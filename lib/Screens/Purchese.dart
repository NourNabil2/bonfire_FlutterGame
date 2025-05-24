import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart'; // Import google_mobile_ads
import '../MainGame.dart';
import 'package:bonfire_flutter_game/SharedPreferences/Cash_Save.dart';
import 'package:bonfire_flutter_game/constant/admob_manager.dart';

int selected = 0;

class Purchases extends StatefulWidget {
  const Purchases({Key? key}) : super(key: key);

  @override
  State<Purchases> createState() => _PurchasesState();
}

class _PurchasesState extends State<Purchases> {
  int balance_1 = CashSaver.getData(key: 'balance_1') ?? 0;
  int balance_2 = CashSaver.getData(key: 'balance_2') ?? 0;

  late RewardedAd rewardedAd;
  bool isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    // Initialize the Google Mobile Ads SDK
    MobileAds.instance.initialize();

    // Load a rewarded ad
    loadRewardedAd();
  }

  // Load a rewarded ad
  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdsManager.rewardedAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (Ad ad) {
          setState(() {
            rewardedAd = ad as RewardedAd;
            isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (LoadAdError error) {
          setState(() {
            isAdLoaded = false;
          });
          print('Ad failed to load: $error');
        },
      ),
    );
  }

  // Show rewarded ad
  void showRewardedAd() {
    if (isAdLoaded) {
      rewardedAd.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          // Handle reward here
          CashSaver.SaveData(key: 'balance_1', value: balance_1 + 1);
        },
      );
      loadRewardedAd(); // Load a new ad after showing
    } else {
      Alert(context: context, title: "No Ads, try again later").show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.7),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        backgroundColor: Colors.grey,
        child: const Icon(
          Icons.home,
          color: Colors.blueGrey,
        ),
      ),
      body: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          MaterialButton(
            onPressed: () {
              setState(() {
                selected = 0;
              });
            },
            child: Card(
              color: selected == 0 ? Colors.grey : Colors.grey.withOpacity(0.6),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text('DEFAULT Joystick'),
                  ),
                  Icon(Icons.check, color: Colors.blueGrey, size: 50),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          MaterialButton(
            onPressed: () {
              if (balance_1 == 6) {
                setState(() {
                  selected = 1;
                });
              } else {
                showRewardedAd();
              }
            },
            child: Card(
              color: selected == 1 ? Colors.grey : Colors.grey.withOpacity(0.6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/Player/Joystick/Peview1.png', width: 200),
                  balance_1 < 6
                      ? IconButton(
                    onPressed: showRewardedAd,
                    icon: const Icon(
                      Icons.ondemand_video,
                      color: Colors.blueGrey,
                      size: 50,
                    ),
                  )
                      : const Icon(Icons.check, color: Colors.blueGrey, size: 50),
                  const SizedBox(height: 10),
                  Text('   $balance_1/6'),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          MaterialButton(
            onPressed: () {
              if (balance_2 == 11) {
                setState(() {
                  selected = 2;
                });
              } else {
                showRewardedAd();
              }
            },
            child: Card(
              color: selected == 2 ? Colors.grey : Colors.grey.withOpacity(0.6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset('assets/images/Player/Joystick/Peview0.png', width: 200),
                  ),
                  balance_2 < 11
                      ? IconButton(
                    onPressed: showRewardedAd,
                    icon: const Icon(
                      Icons.ondemand_video,
                      color: Colors.blueGrey,
                      size: 50,
                    ),
                  )
                      : const Icon(Icons.check, color: Colors.blueGrey, size: 50),
                  const SizedBox(height: 10),
                  Text('   $balance_2/11'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
