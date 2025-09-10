import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ad_manager.dart';

class AppOpenAdManager {
  static final AppOpenAdManager _instance = AppOpenAdManager._internal();
  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;
  bool _isAdAvailable = false;
  DateTime? _lastLoadTime;

  factory AppOpenAdManager() {
    return _instance;
  }

  AppOpenAdManager._internal();

  Future<void> loadAd() async {
    if (_isAdAvailable) {
      return;
    }
    await AppOpenAd.load(
      adUnitId: AdManager.appOpenAd,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          _appOpenAd!.show();
          _isAdAvailable = true;
          _lastLoadTime = DateTime.now();
        },
        onAdFailedToLoad: (error) {
          debugPrint('App Open Ad failed to load: $error');
          _isAdAvailable = false;
          _appOpenAd = null;
          // Retry loading the ad after some delay
          Future.delayed(const Duration(minutes: 1), () => loadAd());
        },
      ),
    );
  }

  void showAdIfAvailable() {
    if (!_isAdAvailable || _isShowingAd) {
      loadAd();
      return;
    }

    if (_lastLoadTime != null &&
        DateTime.now().difference(_lastLoadTime!).inMinutes > 4) {
      // App Open Ads expire after 4 hours
      loadAd();
      return;
    }

    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
      },
      onAdDismissedFullScreenContent: (ad) {
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        _isAdAvailable = false;
        loadAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        _isAdAvailable = false;
        loadAd();
      },
    );
    _appOpenAd!.show();
  }
}

/// Listens for app foreground events and shows app open ads.
class AppLifecycleReactor {
  final AppOpenAdManager appOpenAdManager;

  AppLifecycleReactor({required this.appOpenAdManager});

  void listenToAppStateChanges() {
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream
        .forEach((state) => _onAppStateChanged(state));
  }

  void _onAppStateChanged(AppState appState) {
    // Try to show an app open ad if the app is being resumed and
    // we're not already showing an app open ad.
    if (appState == AppState.foreground) {
      appOpenAdManager.showAdIfAvailable();
    }
  }
}
