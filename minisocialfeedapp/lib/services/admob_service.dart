import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart';

class GoogleAdsService {
  static final GoogleAdsService _instance = GoogleAdsService._internal();
  factory GoogleAdsService() => _instance;
  GoogleAdsService._internal();

  // Test Ad Unit IDs
  static const String _testBannerAndroid =
      'ca-app-pub-3940256099942544/6300978111';
  static const String _testBannerIOS = 'ca-app-pub-3940256099942544/2934735716';
  static const String _testInterstitialAndroid =
      'ca-app-pub-3940256099942544/1033173712';
  static const String _testInterstitialIOS =
      'ca-app-pub-3940256099942544/4411468910';
  static const String _testRewardedAndroid =
      'ca-app-pub-3940256099942544/5224354917';
  static const String _testRewardedIOS =
      'ca-app-pub-3940256099942544/1712485313';

  // Production Ad Unit IDs - Replace with your actual ad unit IDs
  static const String _prodBannerAndroid =
      'ca-app-pub-8578354810587703/4743491252';
  static const String _prodBannerIOS = '';
  static const String _prodInterstitialAndroid =
      'your-production-interstitial-android-id';
  static const String _prodInterstitialIOS = '';
  static const String _prodRewardedAndroid =
      'your-production-rewarded-android-id';
  static const String _prodRewardedIOS = 'your-production-rewarded-ios-id';

  // Helper methods to get correct ad unit IDs
  static String get _bannerAdUnitId {
    if (kDebugMode) {
      return Platform.isAndroid ? _testBannerAndroid : _testBannerIOS;
    }
    return Platform.isAndroid ? _prodBannerAndroid : _prodBannerIOS;
  }

  static String get _interstitialAdUnitId {
    if (kDebugMode) {
      return Platform.isAndroid
          ? _testInterstitialAndroid
          : _testInterstitialIOS;
    }
    return Platform.isAndroid ? _prodInterstitialAndroid : _prodInterstitialIOS;
  }

  static String get _rewardedAdUnitId {
    if (kDebugMode) {
      return Platform.isAndroid ? _testRewardedAndroid : _testRewardedIOS;
    }
    return Platform.isAndroid ? _prodRewardedAndroid : _prodRewardedIOS;
  }

  // Ad instances
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;

  // Loading states
  bool _isBannerAdReady = false;
  bool _isInterstitialAdReady = false;
  bool _isRewardedAdReady = false;

  // Callbacks
  Function(String)? onAdError;
  Function(String)? onAdLoaded;
  Function(String, int)? onRewardEarned;

  // Getters
  bool get isBannerAdReady => _isBannerAdReady;
  bool get isInterstitialAdReady => _isInterstitialAdReady;
  bool get isRewardedAdReady => _isRewardedAdReady;
  BannerAd? get bannerAd => _bannerAd;

  /// Initialize Google Mobile Ads SDK
  Future<void> initialize() async {
    try {
      await MobileAds.instance.initialize();
      log('🎯 Google Mobile Ads initialized successfully');

      // Load ads after initialization
      await Future.wait([
        loadBannerAd(),
        loadInterstitialAd(),
        loadRewardedAd(),
      ]);
    } catch (e) {
      log('❌ Error initializing Google Mobile Ads: $e');
      onAdError?.call('Initialization failed: $e');
    }
  }

  /// Load Banner Ad
  Future<void> loadBannerAd() async {
    try {
      _bannerAd = BannerAd(
        adUnitId: _bannerAdUnitId,
        request: const AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            log('📱 Banner ad loaded');
            _isBannerAdReady = true;
            onAdLoaded?.call('banner');
          },
          onAdFailedToLoad: (ad, error) {
            log('❌ Banner ad failed to load: $error');
            _isBannerAdReady = false;
            onAdError?.call('Banner ad failed: ${error.message}');
            ad.dispose();
            _bannerAd = null;
          },
          onAdOpened: (ad) => log('📱 Banner ad opened'),
          onAdClosed: (ad) => log('📱 Banner ad closed'),
        ),
      );

      await _bannerAd!.load();
    } catch (e) {
      log('❌ Error loading banner ad: $e');
      onAdError?.call('Banner ad error: $e');
    }
  }

  /// Load Interstitial Ad
  Future<void> loadInterstitialAd() async {
    try {
      await InterstitialAd.load(
        adUnitId: _interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            log('🎬 Interstitial ad loaded');
            _interstitialAd = ad;
            _isInterstitialAdReady = true;
            onAdLoaded?.call('interstitial');

            // Set full screen callbacks
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdShowedFullScreenContent: (ad) {
                log('🎬 Interstitial ad showed full screen');
              },
              onAdDismissedFullScreenContent: (ad) {
                log('🎬 Interstitial ad dismissed');
                ad.dispose();
                _interstitialAd = null;
                _isInterstitialAdReady = false;
                // Preload next interstitial
                loadInterstitialAd();
              },
              onAdFailedToShowFullScreenContent: (ad, error) {
                log('❌ Interstitial ad failed to show: $error');
                ad.dispose();
                _interstitialAd = null;
                _isInterstitialAdReady = false;
                onAdError?.call('Interstitial show failed: ${error.message}');
              },
            );
          },
          onAdFailedToLoad: (error) {
            log('❌ Interstitial ad failed to load: $error');
            _isInterstitialAdReady = false;
            onAdError?.call('Interstitial load failed: ${error.message}');
          },
        ),
      );
    } catch (e) {
      log('❌ Error loading interstitial ad: $e');
      onAdError?.call('Interstitial ad error: $e');
    }
  }

  /// Load Rewarded Ad
  Future<void> loadRewardedAd() async {
    try {
      await RewardedAd.load(
        adUnitId: _rewardedAdUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            log('🏆 Rewarded ad loaded');
            _rewardedAd = ad;
            _isRewardedAdReady = true;
            onAdLoaded?.call('rewarded');

            // Set full screen callbacks
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdShowedFullScreenContent: (ad) {
                log('🏆 Rewarded ad showed full screen');
              },
              onAdDismissedFullScreenContent: (ad) {
                log('🏆 Rewarded ad dismissed');
                ad.dispose();
                _rewardedAd = null;
                _isRewardedAdReady = false;
                // Preload next rewarded ad
                loadRewardedAd();
              },
              onAdFailedToShowFullScreenContent: (ad, error) {
                log('❌ Rewarded ad failed to show: $error');
                ad.dispose();
                _rewardedAd = null;
                _isRewardedAdReady = false;
                onAdError?.call('Rewarded show failed: ${error.message}');
              },
            );
          },
          onAdFailedToLoad: (error) {
            log('❌ Rewarded ad failed to load: $error');
            _isRewardedAdReady = false;
            onAdError?.call('Rewarded load failed: ${error.message}');
          },
        ),
      );
    } catch (e) {
      log('❌ Error loading rewarded ad: $e');
      onAdError?.call('Rewarded ad error: $e');
    }
  }

  /// Show Interstitial Ad
  Future<void> showInterstitialAd() async {
    if (_isInterstitialAdReady && _interstitialAd != null) {
      await _interstitialAd!.show();
    } else {
      log('⚠️ Interstitial ad not ready');
      // Try to load a new one
      await loadInterstitialAd();
    }
  }

  /// Show Rewarded Ad
  Future<void> showRewardedAd({
    required Function(int amount, String type) onUserEarnedReward,
  }) async {
    if (_isRewardedAdReady && _rewardedAd != null) {
      await _rewardedAd!.show(
        onUserEarnedReward: (ad, reward) {
          log('🏆 User earned reward: ${reward.amount} ${reward.type}');
          onUserEarnedReward(reward.amount.toInt(), reward.type);
          onRewardEarned?.call(reward.type, reward.amount.toInt());
        },
      );
    } else {
      log('⚠️ Rewarded ad not ready');
      // Try to load a new one
      await loadRewardedAd();
    }
  }

  /// Dispose all ads
  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();

    _bannerAd = null;
    _interstitialAd = null;
    _rewardedAd = null;

    _isBannerAdReady = false;
    _isInterstitialAdReady = false;
    _isRewardedAdReady = false;

    log('🗑️ All ads disposed');
  }

  /// Set callback functions
  void setCallbacks({
    Function(String)? onError,
    Function(String)? onLoaded,
    Function(String, int)? onReward,
  }) {
    onAdError = onError;
    onAdLoaded = onLoaded;
    onRewardEarned = onReward;
  }

  /// Check if ads are available
  Map<String, bool> getAdAvailability() {
    return {
      'banner': _isBannerAdReady,
      'interstitial': _isInterstitialAdReady,
      'rewarded': _isRewardedAdReady,
    };
  }

  /// Refresh all ads
  Future<void> refreshAllAds() async {
    log('🔄 Refreshing all ads...');
    await Future.wait([loadBannerAd(), loadInterstitialAd(), loadRewardedAd()]);
  }
}

// Helper widget for banner ads
class AdBannerWidget extends StatefulWidget {
  const AdBannerWidget({super.key});

  @override
  State<AdBannerWidget> createState() => _AdBannerWidgetState();
}

class _AdBannerWidgetState extends State<AdBannerWidget> {
  final GoogleAdsService _adService = GoogleAdsService();

  @override
  Widget build(BuildContext context) {
    print("_adService.isBannerAdReady: ${_adService.isBannerAdReady}");
    if (!_adService.isBannerAdReady || _adService.bannerAd == null) {
      return const SizedBox.shrink();
    }

    return Container(
      alignment: Alignment.center,
      width: _adService.bannerAd!.size.width.toDouble(),
      height: _adService.bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: _adService.bannerAd!),
    );
  }
}
