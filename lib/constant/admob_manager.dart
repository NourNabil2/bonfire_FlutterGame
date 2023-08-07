import 'dart:io';
import 'package:admob_flutter/admob_flutter.dart';
bool test = false ;
class adsManager
{


  static String get BannerAds_UnitID {

    if (test == true)
      {
return AdmobBanner.testAdUnitId;
      }
    else
if (Platform.isAndroid)
  {
    return 'ca-app-pub-9503585436307618/5268566838' ;
  }
else {
  return '';
}
  }

  static String get InterstitialAds_UnitID {
    if (test == true)
    {
      return AdmobInterstitial.testAdUnitId;
    }
    else
if (Platform.isAndroid)
  {
    return 'ca-app-pub-9503585436307618/6134925946' ;
  }
else {
  return '';
}
  }

  static String get RewardedAds_UnitID {
    if (test == true)
    {
      return AdmobInterstitial.testAdUnitId;
    }
    else
if (Platform.isAndroid)
  {
    return 'ca-app-pub-9503585436307618/2920323839' ;
  }
else {
  return '';
}
  }
}