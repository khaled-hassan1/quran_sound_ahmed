import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/list_arabic_certificate.dart';
import '../provider/lang_provider.dart';
import '../provider/provider_sound.dart';
import '../provider/theme_mode_provider.dart';
import '../widgets/app_settings.dart';
import '../widgets/list_surah_completed_widget.dart';
import '../widgets/warning_widget.dart';

class CertificateScreen extends StatelessWidget {
  static String route = '/certificate-screen';

  const CertificateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final providerLang = Provider.of<LangProvider>(context);
    final providerAudio = Provider.of<AudioPlayerProvider>(context);
    final providerMode = Provider.of<ThemeModeProvider>(context);

    bool isArabic = providerLang.isArabic;
    bool isDark = providerMode.isDark;

    String lettersSurah = providerAudio.isCompleted
        ? isArabic
            ? '$numberOfLettersEnglish ${providerAudio.totalLettersInSurahs.toString()}'
            : '$numberOfLettersArabic ${providerAudio.totalLettersInSurahs.toString()}'
        : isArabic
            ? '$numberOfLettersEnglish 0'
            : '$numberOfLettersArabic 0';
    String numberSurah = providerAudio.isCompleted
        ? isArabic
            ? '$numberofSurahsEnglish ${providerAudio.totalCompletedSurahs.toString()}'
            : '$numberOfSurahsArabic ${providerAudio.totalCompletedSurahs.toString()}'
        : isArabic
            ? '$numberofSurahsEnglish 0'
            : '$numberOfSurahsArabic 0';
    String goodDeeds = providerAudio.isCompleted
        ? isArabic
            ? '$numberOfGoodDeedsEnglish  ${(providerAudio.totalLettersInSurahs * 20).toString()}'
            : '$numberOfGoodDeedsArabic  ${(providerAudio.totalLettersInSurahs * 20).toString()}'
        : isArabic
            ? '$numberOfGoodDeedsEnglish 0'
            : '$numberOfGoodDeedsArabic 0';

    Color color2 = isDark ? AppSettings.white70 : AppSettings.black;
    TextStyle copyWith = AppSettings.textStyle2.copyWith(color: color2);

    double height2 = MediaQuery.of(context).size.height;
    double width2 = MediaQuery.of(context).size.width;

    return SafeArea(
        child: InteractiveViewer(
      maxScale: 5,
      child: Scaffold(
        backgroundColor: AppSettings.transparent,
        body: Container(
          height: height2,
          width: width2,
          decoration: BoxDecoration(
            image: isDark
                ? DecorationImage(
                    image: AppSettings.assetImage('assets/images/gradient.jpg'),
                    fit: BoxFit.cover)
                : DecorationImage(
                    image: AppSettings.assetImage('assets/images/images.png'),
                    opacity: 0.1,
                    filterQuality: FilterQuality.none,
                    fit: AppSettings.cover),
            color: isDark ? Colors.black87 : AppSettings.color,
            border: Border.all(
                color: isDark
                    ? AppSettings.color
                    : const Color.fromARGB(255, 23, 167, 215),
                width: 3),
            borderRadius: AppSettings.borderRadiusCircle(22),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppSettings.sizedBoxHeight(30),
                Text(
                  isArabic ? addressEnglish : addressArabic,
                  textAlign: AppSettings.textAlignCenter,
                  style:
                      copyWith.copyWith(fontFamily: 'ReemKufi', fontSize: 30),
                ),
                AppSettings.sizedBoxHeight(30),
                AppSettings.scrollText(
                  Text(
                    numberSurah,
                    style: copyWith,
                  ),
                  providerLang,
                ),
                AppSettings.scrollText(
                  Text(
                    lettersSurah,
                    style: copyWith,
                  ),
                  providerLang,
                ),
                AppSettings.scrollText(
                    Text(
                      goodDeeds,
                      style: copyWith,
                    ),
                    providerLang),
                AppSettings.sizedBoxHeight(30),
                Container(
                    padding: const EdgeInsets.only(
                      bottom: 2,
                    ),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: AppSettings.red,
                      width: 2.0,
                    ))),
                    child: Text(
                      isArabic ? attentionEnglish : attentionArabic,
                      style: copyWith,
                    )),
                AppSettings.sizedBoxHeight(10),
                Container(
                  padding: AppSettings.edgeInsetsAll(10),
                  decoration: BoxDecoration(
                      color: AppSettings.white70,
                      borderRadius: AppSettings.borderRadiusCircle(10)),
                  child: WarningWidget(providerLang: providerLang),
                ),
                AppSettings.sizedBoxHeight(10),
                Container(
                    padding: const EdgeInsets.only(
                      bottom: 2,
                    ),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: AppSettings.red,
                      width: 2.0,
                    ))),
                    child: Text(
                      isArabic ? nameSurahHeardEnglish : nameSurahHeardArabic,
                      style: copyWith,
                    )),
                AppSettings.sizedBoxHeight(10),
                Container(
                  width: 350,
                  padding: AppSettings.edgeInsetsAll(10),
                  decoration: BoxDecoration(
                      color: AppSettings.white70,
                      borderRadius: AppSettings.borderRadiusCircle(10)),
                  child: ListSurahCompleted(
                      providerLang: providerLang, providerAudio: providerAudio),
                ),
                buildSignatureImage()
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

Widget buildSignatureImage() {
  AssetImage assetImageMe = AppSettings.assetImage('assets/images/me.png');
  return FadeInImage(
    placeholder: assetImageMe,
    image: assetImageMe,
    height: 100,
    width: 130,
  );
}
