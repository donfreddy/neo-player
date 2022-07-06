import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:neo_player/src/page_manager.dart';
import 'package:neo_player/src/service/locator.dart';

class NeoManager {
  // Listeners: Updates going to the UI
  final currentSongNotifier = ValueNotifier<String>('');
  final playlistNotifier = ValueNotifier<List<String>>([]);
  final progressNotifier = ProgressNotifier();
  final repeatButtonNotifier = RepeatButtonNotifier();
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final playButtonNotifier = PlayButtonNotifier();
  final isLastSongNotifier = ValueNotifier<bool>(true);
  final isShuffleModeEnabledNotifier = ValueNotifier<bool>(false);

  final _audioHandler = locator<AudioHandler>();

  // Events: Calls coming from the UI
  void init() {}

  void play() => _audioHandler.play();

  void pause() => _audioHandler.pause();

  void seek(Duration position) => _audioHandler.seek(position);

  void previous() => _audioHandler.skipToPrevious();

  void next() => _audioHandler.skipToNext();

  void repeat() {}

  void shuffle() {}

  void addToNowPlaying({
    required BuildContext context,
    required MediaItem mediaItem,
    bool showNotification = true,
  }) {
    final MediaItem? currentMediaItem = _audioHandler.mediaItem.value;
  }

  void addAllToNowPlaying() {}

  void playNext(
    MediaItem mediaItem,
    BuildContext context,
  ) {}

  void remove() {}

  void dispose() {}
}

// https://suragch.medium.com/background-audio-in-flutter-with-audio-service-and-just-audio-3cce17b4a7d
// https://github.com/KarimElghamry/chillify
// https://github.com/koel/player
