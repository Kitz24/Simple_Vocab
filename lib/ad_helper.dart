import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
//TODO: replace ads with my own also in manifest file
class AdMobService {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
    else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712';
    }
    else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static final BannerAdListener bannerListener = BannerAdListener(
    onAdLoaded: (ad) => print('Ad Loaded'),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      print('failed to load');
    },
  );
}