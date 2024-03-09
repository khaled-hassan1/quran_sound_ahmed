import 'package:flutter/material.dart';

import '../provider/provider_sound.dart';
import './app_settings.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({
    super.key,
    required this.provider,
  });

  final AudioPlayerProvider provider;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    double sliderValue = provider.sliderValue;
    double value = provider.currentDuration.inSeconds.toDouble() >
            provider.musicLength.inSeconds.toDouble()
        ? provider.musicLength.inSeconds.toDouble()
        : provider.currentDuration.inSeconds.toDouble();
    double max = provider.musicLength.inSeconds.toDouble();
    int divisions = provider.musicLength.inSeconds;
    return Padding(
      padding: AppSettings.edgeInsetsAll(8.0),
      child: SliderTheme(
        data: const SliderThemeData(
          activeTickMarkColor: AppSettings.transparent,
          inactiveTickMarkColor: AppSettings.transparent,
          trackHeight: 5,
          valueIndicatorShape: PaddleSliderValueIndicatorShape(),
        ),
        child: Slider(
          inactiveColor: AppSettings.white,
          activeColor: Colors.greenAccent.shade400,
          value: value,
          min: 0,
          max: max,
          onChanged: (double value) {
            sliderValue = value;
            provider.seekTo(Duration(seconds: value.toInt()));
          },
          label: AppSettings.formatDuration(provider.currentDuration),
          divisions: divisions > 0 ? divisions : null,
        ),
      ),
    );
  }
}
