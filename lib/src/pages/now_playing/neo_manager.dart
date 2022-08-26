import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:just_audio/just_audio.dart';

class NeoManager {
  // late AudioPlayer? _player;

  final _player = AudioPlayer();

  final _playlist = ConcatenatingAudioSource(children: []);

  NeoManager() {
    //_init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());

    // _player = AudioPlayer();

    // if (await session.setActive(true)) {
    //   _player = AudioPlayer();
    // } else {
    //   // The request was denied and the app should not play audio
    // }
  }

  void addToNowPlaying({
    required BuildContext context,
    required MediaItem mediaItem,
    bool showNotification = true,
  }) {
    _playlist.add(_createAudioSource(mediaItem));
  }

  void addAllToNowPlaying(List<MediaItem> mediaItems) {
    final audioSource = mediaItems.map(_createAudioSource);
    _playlist.addAll(audioSource.toList());
  }

  UriAudioSource _createAudioSource(MediaItem mediaItem) {
    return AudioSource.uri(
      Uri.parse(mediaItem.extras!['url'].toString()),
      tag: mediaItem,
    );
  }

  void play() async => await _player.play();

  void pause() => _player.hasNext;

  void seek(Duration position) => _player.seek(position);

  void previous() => _player.seekToPrevious();

  void next() => _player.seekToNext();

  void repeat() {}

  void shuffle() {}

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
