// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:quran_sound/ads/ad_manager.dart';

// class NativeAds extends StatefulWidget {
//   const NativeAds({super.key});

//   @override
//   State<NativeAds> createState() => _NativeAdsState();
// }

// class _NativeAdsState extends State<NativeAds> {
//   NativeAd? _nativeAd;
//   bool _nativeAdIsLoaded = false;

//   void loadAdNative() {
//     _nativeAd = NativeAd(
//         adUnitId: AdManager.nativeAds,
//         listener: NativeAdListener(
//           onAdLoaded: (ad) {
//             debugPrint('$NativeAd loaded.');
//             setState(() {
//               _nativeAdIsLoaded = true;
//             });
//           },
//           onAdFailedToLoad: (ad, error) {
//             // Dispose the ad here to free resources.
//             debugPrint('$NativeAd failed to load: $error');
//             ad.dispose();
//           },
//         ),
//         request: const AdRequest(),
//         // Styling
//         nativeTemplateStyle: NativeTemplateStyle(
//             // Required: Choose a template.
//             templateType: TemplateType.small,
//             // Optional: Customize the ad's style.
//             mainBackgroundColor: Colors.purple,
//             cornerRadius: 10.0,
//             callToActionTextStyle: NativeTemplateTextStyle(
//                 textColor: Colors.cyan,
//                 backgroundColor: Colors.red,
//                 style: NativeTemplateFontStyle.monospace,
//                 size: 16.0),
//             primaryTextStyle: NativeTemplateTextStyle(
//                 textColor: Colors.red,
//                 backgroundColor: Colors.cyan,
//                 style: NativeTemplateFontStyle.italic,
//                 size: 16.0),
//             secondaryTextStyle: NativeTemplateTextStyle(
//                 textColor: Colors.green,
//                 backgroundColor: Colors.black,
//                 style: NativeTemplateFontStyle.bold,
//                 size: 16.0),
//             tertiaryTextStyle: NativeTemplateTextStyle(
//                 textColor: Colors.brown,
//                 backgroundColor: Colors.amber,
//                 style: NativeTemplateFontStyle.normal,
//                 size: 16.0)))
//       ..load();
//   }

//   @override
//   void dispose() {
//     _nativeAd?.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     loadAdNative();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: (_nativeAdIsLoaded && _nativeAd != null)
//             ? SizedBox(
//                 height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.width,
//                 child: AdWidget(ad: _nativeAd!))
//             : const SizedBox());
//   }
// }
