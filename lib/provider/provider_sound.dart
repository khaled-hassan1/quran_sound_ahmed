import 'dart:async';

import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

import '../provider/lang_provider.dart';
import '../model/surah.dart';

class AudioPlayerProvider extends ChangeNotifier {
  final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer();
  LangProvider langProvider = LangProvider();
  int _currentSoundIndex = 0;
  int _totalCompletedSurahs = 0;
  String _arabicTitle = 'القرآن الكريم';
  String _englishTitle = 'Al-Quran Al-Kareem';
  final List<Surah> _surahs = [];
  List<String> _nameSurahComplatedArabic = [];
  List<String> _nameSurahComplatedEnglish = [];
  Duration _currentDuration = const Duration();
  Duration _musicLength = const Duration();
  double _sliderValue = 0.0;
  StreamSubscription? _audioPlayerSubscription;

  bool _isPlaying = false;
  bool _isRepeat = false;
  bool _isCompleted = false;
  bool _isLoading = true;
  bool _isSliderMove = false;
  int _totalLettersInSurahs = 0;

  List<String> get nameSurahComplatedArabic => _nameSurahComplatedArabic;

  List<String> get nameSurahComplatedEnglish => _nameSurahComplatedEnglish;

  int get totalLettersInSurahs => _totalLettersInSurahs;

  bool get appearCertificate => !_isSliderMove && _isCompleted;

  bool get isSliderMove => _isSliderMove;

  bool get isLoading => _isLoading;

  String get englishTitle => _englishTitle;

  String get arabicTitle => _arabicTitle;

  int get totalCompletedSurahs => _totalCompletedSurahs;

  int get currentSoundIndex => _currentSoundIndex;

  bool get isCompleted => _isCompleted;

  bool get isRepeat => _isRepeat;

  bool get isPlaying => _isPlaying;

  Duration get currentDuration => _currentDuration;

  Duration get musicLength => _musicLength;

  double get sliderValue => _sliderValue;

  List<Surah> get surahs => _surahs;

  AssetsAudioPlayer get audioPlayer => _audioPlayer;

  AudioPlayerProvider() {
    try {
      _surahs.addAll(surahsModel);
      _isLoading = false;
    } catch (error) {
      _isLoading = false;
      debugPrint("Error loading surahs: $error");
    } finally {
      notifyListeners();
    }
  }

  void playSurah(String audioPath, int index) async {
    _audioPlayerSubscription?.cancel();
    _isPlaying = _audioPlayer.isPlaying.value;
    _isPlaying = true;
    _currentSoundIndex = index;

    try {
      List<Audio> audios = _surahs.map((surah) {
        return Audio(
          surah.audioAsset,
          metas: Metas(
              album: surah.nameEnglish,
              title: surah.nameArabic,
              artist: langProvider.isArabic
                  ? 'Muhammad Siddiq Al-Minshawi'
                  : 'محمد صديق المنشاوي',
              image: const MetasImage.asset('assets/images/icon.png')),
        );
      }).toList();
      _audioPlayer.open(
        Playlist(audios: audios, startIndex: _currentSoundIndex),
        loopMode: LoopMode.playlist,
        showNotification: true,
      );

      _audioPlayerSubscription = _audioPlayer.current.listen((playing) {
        final duration = _audioPlayer.current.value;
        _musicLength = duration!.audio.duration;

        String currentTitleArabic = _audioPlayer.getCurrentAudioTitle;
        String currentTitleEnglish = _audioPlayer.getCurrentAudioAlbum;
        debugPrint(
            '....................||||||||||||||$currentTitleArabic||||||||||||||||||||||.......................');
        debugPrint(
            '....................||||||||||||||$currentTitleEnglish||||||||||||||||||||||.......................');

        setTitle(currentTitleArabic, currentTitleEnglish);
        notifyListeners();
      });

      _audioPlayer.currentPosition.listen((position) {
        _currentDuration = position;

        notifyListeners();
      });

      _audioPlayerSubscription =
          _audioPlayer.playlistAudioFinished.listen((event) {
        _isCompleted = true;
        _totalCompletedSurahs += 1;
        _totalLettersInSurahs += _surahs[_currentSoundIndex].numberLettersSurah;

        _nameSurahComplatedEnglish.add(_audioPlayer.getCurrentAudioAlbum);

        _nameSurahComplatedArabic.add(_audioPlayer.getCurrentAudioTitle);

        if (_isSliderMove) {
          _totalCompletedSurahs = 0;
          _totalLettersInSurahs = 0;
          _nameSurahComplatedArabic = [];
          _nameSurahComplatedEnglish = [];
        }
        debugPrint(
            "_totalCompletedSurahs :${_totalCompletedSurahs.toString()}");
        notifyListeners();
      });
      notifyListeners();
    } catch (e) {
      debugPrint('Error From Play Method: ${e.toString()}');
      _audioPlayerSubscription?.cancel();
    }
  }

  void nextSurah() {
    _isCompleted = false;
    _isSliderMove = true;
    debugPrint("Calling nextSurah...||||||||||||||||||||| $_currentSoundIndex");
    try {
      _audioPlayer.stop();
      _currentSoundIndex++;
      if (_currentSoundIndex < _surahs.length) {
        playSurah(_surahs[_currentSoundIndex].audioAsset, _currentSoundIndex);

        notifyListeners();
      } else {
        _currentSoundIndex = 0;
        playSurah(_surahs[_currentSoundIndex].audioAsset, _currentSoundIndex);

        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error:..................$e');
    }
  }

  void previousSurah() {
    _isCompleted = false;
    _isSliderMove = true;
    debugPrint(
        "Calling previousSurah...||||||||||||||||||||| $_currentSoundIndex");
    try {
      _audioPlayer.stop();
      _currentSoundIndex--;
      if (_currentSoundIndex > 0) {
        playSurah(_surahs[_currentSoundIndex].audioAsset, _currentSoundIndex);
        notifyListeners();
      } else {
        _currentSoundIndex = _surahs.length - 1;
        playSurah(_surahs[_currentSoundIndex].audioAsset, _currentSoundIndex);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error:..................$e');
    }
  }

  void playAndPauseSurah() {
    _audioPlayer.playOrPause();
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  void setTitle(String newArabicTitle, String newEnglishTitle) {
    _arabicTitle = newArabicTitle;
    _englishTitle = newEnglishTitle;
    notifyListeners();
  }

  void seekTo(Duration position) {
    _isSliderMove = true;
    _audioPlayer.seek(position);
    _sliderValue = position.inSeconds.toDouble();
    notifyListeners();
  }

  void seekForward() {
    Duration position = _currentDuration + const Duration(seconds: 5);
    seekTo(position);
  }

  void seekBackward() {
    Duration position = _currentDuration - const Duration(seconds: 5);
    seekTo(position);
  }

  void repeatAudio() {
    _audioPlayer.setLoopMode(_isRepeat ? LoopMode.playlist : LoopMode.single);
    // ignore: unrelated_type_equality_checks
    if ((_audioPlayer.setLoopMode == LoopMode.single) &&
        isCompleted &&
        isRepeat &&
        !_isSliderMove) {
      _totalCompletedSurahs += 1;
      _totalLettersInSurahs += _surahs[_currentSoundIndex].numberLettersSurah;
    }
    _isRepeat = !_isRepeat;
    notifyListeners();
  }

  void reset() {
    if (_isPlaying || !_isPlaying) {
      _currentSoundIndex = 0;
      _totalCompletedSurahs = 0;
      _totalLettersInSurahs = 0;
      _isPlaying = false;
      _isRepeat = false;
      _isCompleted = false;
      _isSliderMove = false;
      _audioPlayer.stop();
      _audioPlayerSubscription?.cancel();
      _currentDuration = Duration.zero;
      _musicLength = Duration.zero;
      _sliderValue = 0.0;
      _arabicTitle = 'القرآن الكريم';
      _englishTitle = 'Al-Quran Al-Kareem';
      _nameSurahComplatedArabic = [];
      _nameSurahComplatedEnglish = [];
      notifyListeners();
    }
  }

  void disposePlayer() {
    _audioPlayer.dispose();
    _audioPlayerSubscription?.cancel();
  }
}
