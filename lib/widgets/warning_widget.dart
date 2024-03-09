import 'package:flutter/material.dart';

import '../widgets/app_settings.dart';
import '../model/list_arabic_certificate.dart';
import '../provider/lang_provider.dart';

class WarningWidget extends StatelessWidget {
  const WarningWidget({
    super.key,
    required this.providerLang,
  });

  final LangProvider providerLang;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: providerLang.isArabic
            ? englishCertificate
                .map((text) => AppSettings.align(
                      Alignment.centerLeft,
                      AppSettings.padding(
                        Text(
                          "•$text",
                          textAlign: AppSettings.left,
                          textDirection: AppSettings.ltr,
                          style: AppSettings.copyWith,
                        ),
                      ),
                    ))
                .toList()
            : arabicCertifiate
                .map((text) => AppSettings.align(
                      Alignment.centerRight,
                      AppSettings.padding(
                        Text(
                          "• $text",
                          textAlign: AppSettings.right,
                          textDirection: AppSettings.rtl,
                          style: AppSettings.copyWith,
                        ),
                      ),
                    ))
                .toList());
  }
}
