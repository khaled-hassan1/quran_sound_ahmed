import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/lang_provider.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/app_settings.dart';
import '../provider/provider_sound.dart';
import '../provider/theme_mode_provider.dart';
import '../widgets/container_buttons.dart';
import '../widgets/sound_list_widget.dart';

@immutable
class SoundScreen extends StatelessWidget {
  static String route = '/sound-screen';
  const SoundScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final providerAudio = Provider.of<AudioPlayerProvider>(context);
    final providerTheme = Provider.of<ThemeModeProvider>(context);
    final providerLang = Provider.of<LangProvider>(context);
    if (providerAudio.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(0, 80),
          child: AppBarWidget(
              providerAudio: providerAudio,
              providerTheme: providerTheme,
              providerLang: providerLang),
        ),
        backgroundColor: providerTheme.isDark
            ? const Color.fromARGB(154, 13, 7, 7)
            : AppSettings.white,
        body: Column(
          children: [
            Expanded(
              child: SoundListWidget(
                  providerAudio: providerAudio,
                  providerTheme: providerTheme,
                  providerLang: providerLang),
            ),
            AppSettings.sizedBoxHeight(3),
            ContainerButtons(
                providerAudio: providerAudio, providerTheme: providerTheme),
          ],
        ),
      );
    }
  }
}
