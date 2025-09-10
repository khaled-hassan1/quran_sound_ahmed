import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../ads/ads_initial.dart';
import '../screens/sounds_screen.dart';
import '../widgets/app_settings.dart';

@immutable
class SplashScreen extends StatefulWidget {
  static String route = '/splash-screen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(SoundScreen.route);
      }
    });
    Future.delayed(const Duration(seconds: 5), () {
      Ads().loadAd();
    });
    Future.delayed(const Duration(seconds: 20), () {
      Ads().loadAd2();
    });

    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue.shade100.withValues(alpha: 0),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: SizedBox(
            height: 180,
            width: 180,
            child: ClipRRect(
              borderRadius: AppSettings.borderRadiusCircle(20),
              child: FadeInImage(
                  placeholder: AppSettings.assetImage('assets/images/icon.png'),
                  image: AppSettings.assetImage('assets/images/icon.png'),
                  fit: AppSettings.cover),
            ),
          ),
        ),
      ),
    );
  }
}
