import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Admob Ad Service
class AdmobService {
  /// Banner Ad Unit ID
  static String get bannerAdUnit => "ca-app-pub-8545434595834021/8695982479";

  /// Banner Ad Test Unit ID
  static String get bannerAdTestUnit =>
      "ca-app-pub-3940256099942544/6300978111";

  /// Initialize Admob Service
  static initialize() {
    // ignore: unnecessary_null_comparison
    if (MobileAds.instance == null) {
      MobileAds.instance.initialize();
    }
  }

  /// Create banner ad
  static BannerAd createBannerAd() {
    BannerAd ad = new BannerAd(
      size: AdSize.banner,
      adUnitId: bannerAdUnit,
      listener: bannerAdlistener,
      request: AdRequest(),
    );
    return ad;
  }

  /// Banner Ad Listener
  static BannerAdListener bannerAdlistener = BannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      ad.dispose();
      print('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => print('Ad closed.'),
    // Called when an impression occurs on the ad.
    onAdImpression: (Ad ad) => print('Ad impression.'),
  );
}
