import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/lang_provider.dart';
import '../provider/provider_sound.dart';
import '../provider/theme_mode_provider.dart';
import './app_settings.dart';
import './silder_widget.dart';

class ContainerButtons extends StatelessWidget {
  const ContainerButtons({
    super.key,
    required this.providerAudio,
    required this.providerTheme,
  });

  final AudioPlayerProvider providerAudio;
  final ThemeModeProvider providerTheme;

  @override
  Widget build(BuildContext context) {
    bool isDark = providerTheme.isDark;
    Color color2 = isDark ? AppSettings.white : Colors.grey.shade900;
    Color color3 = isDark ? Colors.grey.shade700 : Colors.greenAccent.shade100;
    bool isSliderMove = providerAudio.isSliderMove;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: AppSettings.radiusLerp(),
        ),
        gradient: isDark
            ? const LinearGradient(
                colors: [
                  Color.fromARGB(255, 18, 19, 20),
                  Color.fromARGB(255, 51, 72, 45)
                ],
              )
            : LinearGradient(
                colors: [Colors.green.shade200, Colors.greenAccent],
              ),
      ),
      height: AppSettings.heightContainer,
      padding: AppSettings.edgeInsetsSymmetric(9),
      child: Column(
        children: [
          AppSettings.sizedBoxHeight(8),
          Container(
            decoration: BoxDecoration(
                borderRadius: AppSettings.borderRadiusCircle(30),
                color: isDark
                    ? Colors.white10
                    : const Color.fromARGB(146, 9, 86, 17)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (isSliderMove)
                  Consumer<LangProvider>(
                    builder: (context, langProvider, _) => IconButton(
                        onPressed: () {
                          buildDialog(context, langProvider);
                        },
                        icon: const Icon(
                          Icons.restart_alt,
                          size: AppSettings.iconSize,
                          color: AppSettings.white,
                        )),
                  ),
                AppSettings.sizedBoxWidth(isSliderMove ? 0 : 9),
                Text(
                  AppSettings.formatDuration(providerAudio.currentDuration),
                  style: AppSettings.textStyle1,
                ),
                Flexible(
                  child: SliderWidget(provider: providerAudio),
                ),
                Text(
                  AppSettings.formatDuration(providerAudio.musicLength),
                  style: AppSettings.textStyle1,
                ),
                IconButton(
                  splashRadius: 1,
                  tooltip: 'تكرار',
                  onPressed: () {
                    providerAudio.repeatAudio();
                  },
                  icon: Icon(
                    providerAudio.isRepeat
                        ? Icons.repeat_on_outlined
                        : Icons.repeat,
                    color: AppSettings.white,
                  ),
                  iconSize: AppSettings.iconSize,
                ),
              ],
            ),
          ),
          AppSettings.sizedBoxHeight(3),
          Card(
            color: color3,
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: AppSettings.borderRadiusCircle(30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  color: color2,
                  highlightColor: AppSettings.green,
                  onPressed: () {
                    providerAudio.seekBackward();
                  },
                  icon: const Icon(Icons.replay_5),
                  iconSize: 35,
                ),
                IconButton(
                    color: color2,
                    highlightColor: AppSettings.green,
                    onPressed: () {
                      providerAudio.previousSurah();
                    },
                    icon: const Icon(Icons.skip_previous_sharp),
                    iconSize: 40),
                CircleAvatar(
                  radius: 27,
                  backgroundColor: AppSettings.white,
                  child: IconButton(
                      padding: AppSettings.edgeInsetsAll(0),
                      onPressed: () {
                        providerAudio.playAndPauseSurah();
                      },
                      icon: Icon(
                        providerAudio.isPlaying
                            ? Icons.pause_circle
                            : Icons.play_circle,
                        size: 50,
                        color: Colors.green,
                      )),
                ),
                IconButton(
                    color: color2,
                    highlightColor: AppSettings.green,
                    onPressed: () {
                      providerAudio.nextSurah();
                    },
                    icon: const Icon(Icons.skip_next_sharp),
                    iconSize: 40),
                IconButton(
                  color: color2,
                  highlightColor: AppSettings.green,
                  onPressed: () {
                    providerAudio.seekForward();
                  },
                  icon: const Icon(Icons.forward_5),
                  iconSize: 35,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> buildDialog(BuildContext context, LangProvider langProvider) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  style: AppSettings.textStyle2.copyWith(foreground: Paint()),
                  langProvider.isArabic ? 'No' : 'لا',
                ),
              ),
              TextButton(
                onPressed: () {
                  providerAudio.reset();
                  Navigator.of(context).pop();
                  // Ads().loadAd2();
                },
                child: Text(
                    style: AppSettings.textStyle2,
                    langProvider.isArabic ? 'Yes' : 'نعم'),
              ),
            ],
          )
        ],
        content: Text(langProvider.isArabic ? 'Reset All?' : 'إعادة الضبط؟',
            style: AppSettings.textStyle2,
            textAlign: AppSettings.textAlignCenter),
      ),
    );
  }
}
