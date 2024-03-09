import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/lang_provider.dart';
import '../provider/provider_sound.dart';
import '../provider/theme_mode_provider.dart';
import './app_settings.dart';

class SoundListWidget extends StatefulWidget {
  const SoundListWidget({
    super.key,
    required this.providerAudio,
    required this.providerTheme,
    required this.providerLang,
  });

  final AudioPlayerProvider providerAudio;
  final ThemeModeProvider providerTheme;
  final LangProvider providerLang;

  @override
  State<SoundListWidget> createState() => _SoundListWidgetState();
}

class _SoundListWidgetState extends State<SoundListWidget> {
  @override
  void dispose() {
    Provider.of<AudioPlayerProvider>(context).disposePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      interactive: true,
      thickness: 9.0,
      radius: const Radius.circular(10),
      child: ListView.builder(
        padding: AppSettings.edgeInsetsSymmetric(20),
        itemBuilder: (context, index) {
          String arabicName = widget.providerAudio.surahs[index].nameArabic;
          String englishName = widget.providerAudio.surahs[index].nameEnglish;
          String audioAsset = widget.providerAudio.surahs[index].audioAsset;
          // if ((index + 1) % 5 == 0) {
          //   return const NativeAds();
          // } else {
          return Card(
            elevation: 1,
            shadowColor: AppSettings.green,
            shape: RoundedRectangleBorder(
                borderRadius: AppSettings.borderRadiusCircle(20)),
            child: ListTile(
              contentPadding: AppSettings.edgeInsetsAll(0),
              title: Text(
                widget.providerLang.isArabic ? englishName : arabicName,
                textAlign: AppSettings.textAlignCenter,
                style: AppSettings.textStyle2.copyWith(
                    color: widget.providerTheme.isDark
                        ? AppSettings.white
                        : AppSettings.black),
              ),
              tileColor: widget.providerTheme.isDark
                  ? const Color.fromARGB(231, 0, 0, 0)
                  : Colors.white54,
              onTap: () {
                widget.providerAudio.playSurah(audioAsset, index);
              },
            ),
          );
        },
        itemCount: widget.providerAudio.surahs.length,
      ),
    );
  }
}
