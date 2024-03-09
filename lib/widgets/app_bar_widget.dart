import 'package:flutter/material.dart';
import 'package:rotating_icon_button/rotating_icon_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ads/ads_initial.dart';
import '../widgets/colorized_text.dart';
import '../screens/certificate_screen.dart';
import '../model/enum.dart';
import '../model/list_arabic_certificate.dart';
import '../provider/lang_provider.dart';
import '../provider/provider_sound.dart';
import '../provider/theme_mode_provider.dart';
import './app_settings.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
    required this.providerAudio,
    required this.providerTheme,
    required this.providerLang,
  });

  final AudioPlayerProvider providerAudio;
  final ThemeModeProvider providerTheme;
  final LangProvider providerLang;

  @override
  Widget build(BuildContext context) {
    bool appearCertificate = providerAudio.appearCertificate;
    String route = CertificateScreen.route;

    bool isArabic = providerLang.isArabic;
    return AppBar(
      leading: IconButton(
        tooltip: isArabic ? rating : 'تقييمك',
        onPressed: () async {
          try {
            final Uri url = Uri.parse(
                'https://play.google.com/store/apps/details?id=com.quran_2.quran_sound_2');
            await launchUrl(url, mode: LaunchMode.inAppBrowserView);
          } catch (error) {
            debugPrint('Error launching URL: $error');
          }
        },
        icon: const Icon(Icons.star_border),
      ),
      actions: [
        RotatingIconButton(
          background: AppSettings.transparent,
          rotateType: RotateType.semi,
          onTap: () {
            if (!appearCertificate) {
              Future.delayed(Duration.zero, () => Ads().loadAd());
              snackBar(context: context, providerLang: providerLang);
            } else {
              if (appearCertificate) {
                Future.delayed(Duration.zero, () => Ads().loadAd2());
                Navigator.of(context).pushNamed(route);
              }
            }
          },
          child: Icon(
            appearCertificate
                ? Icons.workspace_premium_rounded
                : Icons.workspace_premium_outlined,
            color: appearCertificate
                ? providerTheme.isDark
                    ? Colors.greenAccent.shade700
                    : Colors.yellow
                : Colors.blueGrey.shade300,
          ),
        ),
        PopupMenuButton(
          itemBuilder: (context) {
            return [
              popMenu(
                iconPopMenu: IconPopMenu.english,
                listTile: ListTile(
                  contentPadding: AppSettings.edgeInsetsAll(0),
                  title: Text(providerLang.isArabic ? 'ترجمة' : translate),
                  onTap: () {
                    providerLang.toggleLan();
                    Navigator.of(context).pop();
                  },
                  trailing: const Icon(Icons.translate),
                ),
              ),
              popMenu(
                  listTile: ListTile(
                    contentPadding: AppSettings.edgeInsetsAll(0),
                    title: Text(providerLang.isArabic
                        ? providerTheme.isDark
                            ? light
                            : dark
                        : providerTheme.isDark
                            ? 'إضاءة'
                            : 'مظلم'),
                    onTap: () {
                      providerTheme.toggleDarkMode();
                      Navigator.of(context).pop();
                    },
                    trailing: Icon(providerTheme.isDark
                        ? Icons.light_mode
                        : Icons.dark_mode),
                  ),
                  iconPopMenu: IconPopMenu.mode)
            ];
          },
        ),
      ],
      toolbarHeight: 90,
      backgroundColor: AppSettings.transparent,
      elevation: 0.0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            bottom: AppSettings.radiusLerp(),
          ),
          gradient: providerTheme.isDark
              ? const LinearGradient(
                  colors: AppSettings.colors1,
                )
              : LinearGradient(
                  colors: AppSettings.colors2,
                ),
        ),
      ),
      title: ColorizedText(
          text: providerLang.isArabic
              ? providerAudio.englishTitle
              : providerAudio.arabicTitle,
          colors: providerAudio.isPlaying
              ? providerTheme.isDark
                  ? AppSettings.colorizeColorsLight
                  : AppSettings.colorizeColorsDark2
              : AppSettings.colorizeColorsDark,
          textAlign: AppSettings.textAlignCenter,
          textStyle: AppSettings.colorizeTextStyle),
      centerTitle: true,
    );
  }

  PopupMenuItem<IconPopMenu> popMenu(
      {required ListTile listTile, required IconPopMenu iconPopMenu}) {
    return PopupMenuItem(
      value: iconPopMenu,
      child: listTile,
    );
  }

  void snackBar(
      {required BuildContext context, required LangProvider providerLang}) {
    ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);
    String warningArabic =
        'أتمم سماع السورة كاملة ولا تحرك شريط التمرير لترى الشهادة';
    String warningEnglish =
        'Complete the entire surah and do not move the slider to see the certificate. ';
    scaffoldMessenger.hideCurrentSnackBar();
    scaffoldMessenger.showSnackBar(
      SnackBar(
          showCloseIcon: true,
          closeIconColor: AppSettings.red,
          margin: AppSettings.edgeInsetsAll(16),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: AppSettings.borderRadiusCircle(30)),
          content: Text(
            providerLang.isArabic ? warningEnglish : warningArabic,
            textAlign:
                providerLang.isArabic ? AppSettings.left : AppSettings.right,
          )),
    );
  }
}
