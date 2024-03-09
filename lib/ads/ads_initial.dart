import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quran_sound_2/ads/ad_manager.dart';

class Ads {
  InterstitialAd? _interstitialAd;
  InterstitialAd? _interstitialAd2;

  void loadAd() {
    InterstitialAd.load(
        adUnitId: AdManager.interstitialAd,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded 1.');
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;
            if (_interstitialAd != null) {
              _interstitialAd!.show();
            }
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                ad.dispose();
              },
              onAdFailedToShowFullScreenContent: (ad, error) {
                ad.dispose();
              },
            );
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
  }

  void loadAd2() {
    InterstitialAd.load(
        adUnitId: AdManager.interstitialAd2,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded 2.');
            // Keep a reference to the ad so you can show it later.
            _interstitialAd2 = ad;
            if (_interstitialAd2 != null) {
              _interstitialAd2!.show();
            }
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                ad.dispose();
              },
              onAdFailedToShowFullScreenContent: (ad, error) {
                ad.dispose();
              },
            );
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
  }

}
