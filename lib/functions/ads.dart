import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdServices {
  static const String bannerAdUnitTest =
      "ca-app-pub-3940256099942544/6300978111";
  static const String fullScreenAdUnitTest =
      "ca-app-pub-3940256099942544/1033173712";
  // ca-app-pub-2463660650076163/3725268532 up
  static const String rewardAdUnitTest =
      "ca-app-pub-3940256099942544/5224354917";

  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;

  initBannerAd() {
    _bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: bannerAdUnitTest,
        listener: BannerAdListener(
          onAdLoaded: (ad) {},
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
            print(error);
          },
        ),
        request: AdRequest());
    _bannerAd!.load();
  }

  initInterstitialAd() {
    InterstitialAd.load(
      adUnitId: fullScreenAdUnitTest,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback =
                FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
              //TODO go to the page you want here
            });
            _interstitialAd = ad;
          },
          onAdFailedToLoad: (error) => print(error)),
    );
  }

  initRewardedAd() {
    RewardedAd.load(
      adUnitId: rewardAdUnitTest,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback =
                FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
              //TODO go to the page you want here
            });
            _rewardedAd = ad;
          },
          onAdFailedToLoad: (error) => print(error)),
    );
  }

  getBannerAd() {
    return _bannerAd;
  }

  getInterstitialAd() {
    return _interstitialAd;
  }

  getRewardedAd() {
    return _rewardedAd;
  }
}
