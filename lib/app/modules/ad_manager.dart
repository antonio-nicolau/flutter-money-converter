import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-6938134630901841/5031608905";
    } else if (Platform.isIOS) {
      return "<YOUR_IOS_BANNER_AD_UNIT_ID>";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  String get interstialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-6938134630901841/8338892892";
    } else if (Platform.isIOS) {
      return "<YOUR_IOS_BANNER_AD_UNIT_ID>";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  BannerAd createAd() {
    BannerAd ad = BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: AdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError err) => ad.dispose(),
        onApplicationExit: (Ad ad) => ad.dispose(),
      ),
    );

    return ad;
  }

  createInterstialAd(context) {
    InterstitialAd? myInterstitial;
    myInterstitial = InterstitialAd(
      adUnitId: interstialAdUnitId,
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
