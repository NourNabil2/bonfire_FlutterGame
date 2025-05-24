// lib/services/ads_service.dart
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../constant/admob_manager.dart';

class AdsService {
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  BannerAd? _bannerAd;

  bool isBannerAdLoaded = false;

  final ValueNotifier<bool> bannerNotifier = ValueNotifier(false);

  void initialize() {
    MobileAds.instance.initialize().then((status) {
      log("Google Mobile Ads SDK Initialized: ${status.adapterStatuses.values.first.state}");

      _loadInterstitialAd();
      _loadRewardedAd();
      _loadBannerAd();
    });
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdsManager.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _loadInterstitialAd();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              _loadInterstitialAd();
            },
          );
        },
        onAdFailedToLoad: (error) => log("Interstitial ad failed: $error"),
      ),
    );
  }

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdsManager.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          _rewardedAd = ad;
          _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _loadRewardedAd();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              _loadRewardedAd();
            },
          );
        },
        onAdFailedToLoad: (error) => log("Rewarded ad failed: $error"),
      ),
    );
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: AdsManager.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          isBannerAdLoaded = true;
          bannerNotifier.value = true;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          log('Banner ad failed: $error');
        },
      ),
    )..load();
  }

  BannerAd? get bannerAd => _bannerAd;

  void showInterstitialAd() {
    _interstitialAd?.show();
  }

  void showRewardedAd(Function onRewarded) {
    _rewardedAd?.show(onUserEarnedReward: (ad, reward) => onRewarded());
  }

  void disposeAds() {
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
    _bannerAd?.dispose();
  }
}
