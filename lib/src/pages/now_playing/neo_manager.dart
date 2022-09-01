import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:neo_player/locator.dart';

import '../../helpers/helpers.dart';

class NeoManager {
  final queueNotifier = ValueNotifier<List<MediaItem>>([]);
  final currentSongNotifier = ValueNotifier<MediaItem?>(null);

  //
  final queueIndexNotifier = ValueNotifier<int?>(0);
  final volumeNotifier = ValueNotifier<double>(1.0);
  final repeatButtonNotifier = RepeatButtonNotifier();
  final playButtonNotifier = PlayButtonNotifier();
  final isShuffleModeEnabledNotifier = ValueNotifier<bool>(false);
  final speedNotifier = ValueNotifier<double>(1.0);
  final progressNotifier = ProgressNotifier();
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final isLastSongNotifier = ValueNotifier<bool>(true);

  late AudioPlayer _player;
  late ConcatenatingAudioSource _playlist;

  NeoManager() {
    _init();
    _listenForChangesInPlayerState();
    _listenForChangesInPlayerPosition();
    _listenForChangesInBufferedPosition();
    _listenForChangesInTotalDuration();
    _listenForChangesInSequenceState();
  }

  Future<void> _init() async {
    _player = locator<AudioPlayer>();
    _playlist = ConcatenatingAudioSource(children: []);

    // session config
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());

    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      if (kDebugMode) {
        print('A stream error occurred: $e');
      }
    });

    await _player.setAudioSource(_playlist, preload: false);
  }

  // void _setInitialPlaylist() async {
  //   const prefix = 'https://wvv.33rapfr.com/wp-content/uploads';
  //   final song1 = Uri.parse('$prefix/2021/12/Ninho-OG.mp3');
  //   final song2 = Uri.parse('$prefix/2021/12/06-La-zone.mp3');
  //   final song3 = Uri.parse('$prefix/2022/04/09-LA-OU-LE-VENT-NOUS-MENE.mp3');
  //   _playlist = ConcatenatingAudioSource(children: [
  //     AudioSource.uri(song1, tag: 'Ninho OG'),
  //     AudioSource.uri(song2, tag: 'La zone'),
  //     AudioSource.uri(song3, tag: 'LA OU LE VENT NOUS MEME'),
  //   ]);
  //   await _player.setAudioSource(_playlist);
  // }

  Future<void> addQueueItem(MediaItem mediaItem) async {
    await _playlist.add(createAudioSource(mediaItem));
  }

  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    final audioSource = mediaItems.map(createAudioSource);
    await _playlist.addAll(audioSource.toList());
  }

  Future<void> insertQueueItem(int index, MediaItem mediaItem) async {
    await _playlist.insert(index, createAudioSource(mediaItem));
  }

  Future<void> clear() async {
    await _playlist.clear();
  }

  void _listenForChangesInPlayerState() {
    _player.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (!isPlaying) {
        playButtonNotifier.value = ButtonState.paused;
      } else if (processingState != ProcessingState.completed) {
        playButtonNotifier.value = ButtonState.playing;
      } else {
        _player.seek(Duration.zero);
        _player.pause();
      }
    });
  }

  void _listenForChangesInPlayerPosition() {
    _player.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
  }

  void _listenForChangesInBufferedPosition() {
    _player.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: bufferedPosition,
        total: oldState.total,
      );
    });
  }

  void _listenForChangesInTotalDuration() {
    _player.durationStream.listen((totalDuration) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: totalDuration ?? Duration.zero,
      );
    });
  }

  void _listenForChangesInSequenceState() {
    print('############## Start listen for change in sequence state');
    _player.sequenceStateStream.listen((sequenceState) {
      if (sequenceState == null) return;

      // update queue index
      final queueIndex = sequenceState.currentIndex;
      queueIndexNotifier.value = queueIndex;

      // update current song
      final currentItem = sequenceState.currentSource;
      currentSongNotifier.value = currentItem?.tag as MediaItem?;
      print('############## Song title from sequence state');

      // update playlist
      final playlist = sequenceState.effectiveSequence;
      //  final titles = playlist.map((item) => item.tag as String).toList();
      //  playlistNotifier.value = titles;

      // update shuffle mode
      isShuffleModeEnabledNotifier.value = sequenceState.shuffleModeEnabled;

      // update previous and next buttons
      if (playlist.isEmpty || currentItem == null) {
        isFirstSongNotifier.value = true;
        isLastSongNotifier.value = true;
      } else {
        isFirstSongNotifier.value = playlist.first == currentItem;
        isLastSongNotifier.value = playlist.last == currentItem;
      }
    });
  }

  void play() async => _player.play();

  void pause() => _player.pause();

  void stop() => _player.stop();

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

class PlayButtonNotifier extends ValueNotifier<ButtonState> {
  PlayButtonNotifier() : super(_initialValue);
  static const _initialValue = ButtonState.paused;
}

enum ButtonState {
  paused,
  playing,
}

class RepeatButtonNotifier extends ValueNotifier<RepeatState> {
  RepeatButtonNotifier() : super(_initialValue);
  static const _initialValue = RepeatState.off;

  void nextState() {
    final next = (value.index + 1) % RepeatState.values.length;
    value = RepeatState.values[next];
  }
}

enum RepeatState {
  off,
  repeatSong,
  repeatPlaylist,
}

class ProgressNotifier extends ValueNotifier<ProgressBarState> {
  ProgressNotifier() : super(_initialValue);
  static const _initialValue = ProgressBarState(
    current: Duration.zero,
    buffered: Duration.zero,
    total: Duration.zero,
  );
}

class ProgressBarState {
  const ProgressBarState({
    required this.current,
    required this.buffered,
    required this.total,
  });

  final Duration current;
  final Duration buffered;
  final Duration total;
}

class QueueState {
  final List<MediaItem> queue;
  final int? queueIndex;
  final List<int>? shuffleIndices;
  final RepeatState repeatMode;

  const QueueState._({
    required this.queue,
    this.queueIndex,
    this.shuffleIndices,
    required this.repeatMode,
  });
}
