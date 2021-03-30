import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  static String get appID {
    if (Platform.isAndroid)
      return "ca-app-pub-6938134630901841~9674056334";
    else if (Platform.isIOS)
      return "<YOUR_IOS_APP_ID>";
    else
      throw Exception("Unsuported Platform");
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-6938134630901841/5031608905";
    } else if (Platform.isIOS) {
      return "<YOUR_IOS_BANNER_AD_UNIT_ID>";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  BannerAd createAd() {
    //ca-app-pub-3940256099942544/6300978111
    final testID = 'ca-app-pub-3940256099942544/6300978111';
    BannerAd ad = BannerAd(
      adUnitId: testID,
      size: AdSize.banner,
      request: AdRequest(),
      listener: AdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError err) {
          ad.dispose();
          print('Falied to load');
          print(err.message);
        },
        onApplicationExit: (Ad ad) => ad.dispose(),
      ),
    );

    return ad;
  }

  createInterstialAd(context) {
    InterstitialAd? myInterstitial;
    myInterstitial = InterstitialAd(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
      request: AdRequest(),
      listener: AdListener(
        onAdLoaded: (Ad ad) => myInterstitial?.show(),
        onAdClosed: (Ad ad) => ad.dispose(),
        onAdFailedToLoad: (Ad ad, LoadAdError e) => ad.dispose(),
        onApplicationExit: (Ad ad) => ad.dispose(),
      ),
    );

    myInterstitial.load();
  }
}
