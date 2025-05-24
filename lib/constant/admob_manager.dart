import 'dart:io';

class AdsManager {
  static bool test = false;

  static String get bannerAdUnitId {
    if (test) {
      return 'ca-app-pub-3940256099942544/6300978111'; // Official test ad ID
    } else {
      return Platform.isAndroid
          ? 'ca-app-pub-9503585436307618/5268566838'
          : '';
    }
  }

  static String get interstitialAdUnitId {
    if (test) {
      return 'ca-app-pub-3940256099942544/1033173712'; // Official test ad ID
    } else {
      return Platform.isAndroid
          ? 'ca-app-pub-9503585436307618/6134925946'
          : '';
    }
  }

  static String get rewardedAdUnitId {
    if (test) {
      return 'ca-app-pub-3940256099942544/5224354917'; // Official test ad ID
    } else {
      return Platform.isAndroid
          ? 'ca-app-pub-9503585436307618/2920323839'
          : '';
    }
  }
}
