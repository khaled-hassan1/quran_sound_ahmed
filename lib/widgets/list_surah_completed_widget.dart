import 'package:flutter/material.dart';

import '../widgets/app_settings.dart';
import '../provider/lang_provider.dart';
import '../provider/provider_sound.dart';

class ListSurahCompleted extends StatelessWidget {
  const ListSurahCompleted({
    super.key,
    required this.providerLang,
    required this.providerAudio,
  });

  final LangProvider providerLang;
  final AudioPlayerProvider providerAudio;

  @override
  Widget build(BuildContext context) {
    bool isArabic = providerLang.isArabic;

    return Wrap(
      alignment: isArabic ? WrapAlignment.start : WrapAlignment.end,
      children: !isArabic
          ? providerAudio.nameSurahComplatedArabic.map((text) {
              return Text("$text ... ",
                  textDirection: AppSettings.rtl, style: AppSettings.copyWith);
            }).toList()
          : providerAudio.nameSurahComplatedEnglish
              .map((text) => Text("$text ... ",
                  textDirection: AppSettings.ltr, style: AppSettings.copyWith))
              .toList(),
    );
  }
}
