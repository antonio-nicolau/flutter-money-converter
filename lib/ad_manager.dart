import 'dart:io';
import 'package:firebase_admob/firebase_admob.dart';

class AdManager {
  static String get appID {
    if (Platform.isAndroid)
      return FirebaseAdMob.testAppId; // REPLACE WITH YOUR APP ID
    else if (Platform.isIOS)
      return "<YOUR_IOS_APP_ID>";
    else
      throw Exception("Unsuported Platform");
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return BannerAd.testAdUnitId; // REPLACE WITH YOUR BANNER ID
    } else if (Platform.isIOS) {
      return "<YOUR_IOS_BANNER_AD_UNIT_ID>";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
