import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../screens/certificate_screen.dart';
import '../provider/lang_provider.dart';
import '../widgets/app_settings.dart';
import '../provider/provider_sound.dart';
import '../screens/sounds_screen.dart';
import '../provider/theme_mode_provider.dart';
import '../screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AudioPlayerProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeModeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LangProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quran Sound 2',
      theme: ThemeData(
        popupMenuTheme: PopupMenuThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: AppSettings.borderRadiusCircle(20),
          ),
        ),
        appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: AppSettings.white, size: 30),
            titleTextStyle: TextStyle(color: AppSettings.white, fontSize: 25)),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade900),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      routes: {
        CertificateScreen.route: (context) => const CertificateScreen(),
        SplashScreen.route: (context) => const SplashScreen(),
        SoundScreen.route: (context) => const SoundScreen(),
      },
    );
  }
}
