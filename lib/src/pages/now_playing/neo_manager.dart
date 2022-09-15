import 'dart:async';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:neo_player/locator.dart';

import '../../helpers/common.dart';

class NeoManager {
  late AudioPlayer _player;
  late ConcatenatingAudioSource _playlist;
  late ValueNotifier<double> volumeNotifier;

  //
  Box settingsBox = Hive.box('settings');

  final queueNotifier = ValueNotifier<List<MediaItem>>([]);
  final currentSongNotifier = ValueNotifier<MediaItem?>(null);

  //
  final queueIndexNotifier = ValueNotifier<int?>(0);
  final speedNotifier = ValueNotifier<double>(1.0);
  final repeatButtonNotifier = RepeatButtonNotifier();
  final playButtonNotifier = PlayButtonNotifier();
  final isShuffleModeEnabledNotifier = ValueNotifier<bool>(false);
  final progressNotifier = ProgressNotifier();
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final isLastSongNotifier = ValueNotifier<bool>(true);

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
    volumeNotifier = ValueNotifier<double>(
      settingsBox.get('volume', defaultValue: 1.0) as double,
    );

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

  void _listenForChangesInPlaybackEvent() {
    _player.playbackEventStream.listen((event) {});
  }

  void _listenForChangesInCurrentIndex() {
    _player.currentIndexStream.listen((queueIndex) {
      queueIndexNotifier.value = queueIndex;
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

  Future<void> updateQueue(List<MediaItem> newQueue) async {
    final audioSource = newQueue.map(createAudioSource);
    await _playlist.clear();
    await _playlist.addAll(audioSource.toList());
  }

  Future<void> updateMediaItem(MediaItem mediaItem) async {
    // final index = queue.value.indexWhere((item) => item.id == mediaItem.id);
    // _mediaItemExpando[_player.sequenceState?.effectiveSequence= mediaItem;
  }

  void play() async {
    // final userVolume = settingsBox.get('volume', defaultValue: 1.0) as double;
    // int volume = (userVolume * 10).round();
    //
    // for (int i = 1; i <= volume; i++) {
    //   final oneSec = Duration(milliseconds: i * 10);
    //   await Future.delayed(oneSec, () async {
    //     await _player.setVolume(i / 10);
    //   });
    // }
    await _player.play();
  }

  void pause() async {
    // final volume = _player.volume;
    // print('############################# Volume Start: $volume');
    //
    // for (var i = 0.6; 0.0 <= i && i <= 1.0; i -= 0.1) {
    //   print('############################# Volume: $i');
    //   const oneSec = Duration(milliseconds: 100);
    //   await Future.delayed(oneSec, () async {
    //     final newValue = (0 + (1 - 0.0) * i).clamp(0.0, 1.0);
    //     await _player.setVolume(newValue);
    //   });
    // }
    await _player.pause();
  }

  void stop() async {
    await _player.stop();
  }

  void seek(Duration position) => _player.seek(position);

  void skipToNext() => _player.seekToNext();

  void skipToPrevious() async {
    await _player.seekToPrevious();
  }

  void skipToQueueItem(int index) async {
    if (index < 0 || index >= _playlist.children.length) return;

    _player.seek(
      Duration.zero,
      index:
          _player.shuffleModeEnabled ? _player.shuffleIndices![index] : index,
    );
  }

  void repeat() {}

  void shuffle() {}

  void replay10() {
    final position = _player.position.inSeconds;
    if (position >= 10) {
      _player.seek(Duration(seconds: position - 10));
    } else {
      _player.seek(Duration.zero);
    }
  }

  void forward10() {
    final position = _player.position.inSeconds;
    final duration = _player.duration?.inSeconds ?? 0;
    if (position <= duration - 10) {
      _player.seek(Duration(seconds: position + 10));
    }
  }

  void playNext(
    MediaItem mediaItem,
    BuildContext context,
  ) {}

  Future<void> setVolume(double volume) async {
    volumeNotifier.value = volume;
    await settingsBox.put('volume', volume);
    await _player.setVolume(volume);
  }

  void onRepeatButtonPressed() {
    repeatButtonNotifier.nextState();
    switch (repeatButtonNotifier.value) {
      case RepeatState.off:
        _player.setLoopMode(LoopMode.off);
        break;
      case RepeatState.repeatPlaylist:
        _player.setLoopMode(LoopMode.all);
        break;
      case RepeatState.repeatSong:
        _player.setLoopMode(LoopMode.one);
    }
  }

  void onShuffleButtonPressed() async {
    final enable = !_player.shuffleModeEnabled;
    if (enable) {
      await _player.shuffle();
    }
    await _player.setShuffleModeEnabled(enable);
  }

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
  repeatPlaylist,
  repeatSong,
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
