import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import '../pages/now_playing/neo_manager.dart';

Future<AudioHandler> initAudioService() async {
  return await AudioService.init(
    builder: () => NeoPlayerHandlerImpl(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.freddydev.neo_player',
      androidNotificationChannelName: 'Neo Player',
      // androidNotificationIcon: 'drawable/ic_stat_music_note',
      androidNotificationOngoing: true,
      androidShowNotificationBadge: true,
      androidStopForegroundOnPause: true,
      // notificationColor: Colors.grey[900],
    ),
  );
}

abstract class NeoPlayerHandler1 {
  Stream<QueueState> get queueState;

  Future<void> moveQueueItem(int currentIndex, int newIndex);

  ValueStream<double> get volume;

  Future<void> setVolume(double volume);

  ValueStream<double> get speed;
}

class NeoPlayerHandlerImpl extends BaseAudioHandler
    with QueueHandler, SeekHandler
    implements NeoPlayerHandler1 {
  late AudioPlayer? _player;

  //
  final _playlist = ConcatenatingAudioSource(children: []);

  @override
  final BehaviorSubject<double> volume = BehaviorSubject.seeded(1.0);
  @override
  final BehaviorSubject<double> speed = BehaviorSubject.seeded(1.0);

  NeoPlayerHandlerImpl() {
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());

    _player = AudioPlayer();

    // // Activate the audio session before playing audio.
    // if (await session.setActive(true)) {
    //   _player = AudioPlayer();
    // } else {
    //   // The request was denied and the app should not play audio
    // }
  }

  int? getQueueIndex(
    int? currentIndex,
    List<int>? shuffleIndices, {
    bool shuffleModeEnabled = false,
  }) {
    final effectiveIndices = _player!.effectiveIndices ?? [];
    final shuffleIndicesInv = List.filled(effectiveIndices.length, 0);
    for (var i = 0; i < effectiveIndices.length; i++) {
      shuffleIndicesInv[effectiveIndices[i]] = i;
    }
    return (shuffleModeEnabled &&
            ((currentIndex ?? 0) < shuffleIndicesInv.length))
        ? shuffleIndicesInv[currentIndex ?? 0]
        : currentIndex;
  }

  @override
  // Stream<QueueState> get queueState =>
  //     Rx.combineLatest3<List<MediaItem>, PlaybackState, List<int>, QueueState>(
  //       queue,
  //       playbackState,
  //       _player!.shuffleIndicesStream.whereType<List<int>>(),
  //       (queue, playbackState, shuffleIndices) => QueueState.currentValue(
  //         queue,
  //         playbackState.queueIndex,
  //         playbackState.shuffleMode == AudioServiceShuffleMode.all
  //             ? shuffleIndices
  //             : null,
  //         playbackState.repeatMode,
  //       ),
  //     ).where(
  //       (state) =>
  //           state.shuffleIndices == null ||
  //           state.queue.length == state.shuffleIndices!.length,
  //     );

  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {
    await _playlist.add(_createAudioSource(mediaItem));
  }

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    // gère Just Audio
    final audioSource = mediaItems.map(_createAudioSource);
    await _playlist.addAll(audioSource.toList());

    // // notifie le système
    // final newQueue = queue.value..addAll(mediaItems);
    // queue.add(newQueue);
  }

  UriAudioSource _createAudioSource(MediaItem mediaItem) {
    return AudioSource.uri(
      Uri.parse(mediaItem.extras!['url']),
      tag: mediaItem,
    );
    // second
  }

  @override
  Future<void> moveQueueItem(int currentIndex, int newIndex) {
    // TODO: implement moveQueueItem
    throw UnimplementedError();
  }

  @override
  Future<void> play() => _player!.play();

  @override
  Future<void> pause() => _player!.pause();

  @override
  Future<void> seek(Duration position) => _player!.seek(position);

  @override
  Future<void> skipToNext() => _player!.seekToNext();

  @override
  Future<void> skipToPrevious() => _player!.seekToPrevious();

  @override
  Future<void> skipToQueueItem(int index) async {
    if (index < 0 || index >= _playlist.children.length) return;

    _player!.seek(
      Duration.zero,
      index:
          _player!.shuffleModeEnabled ? _player!.shuffleIndices![index] : index,
    );
  }

  @override
  Future<void> stop() async {
    await _player!.stop();
    await playbackState.firstWhere(
      (state) => state.processingState == AudioProcessingState.idle,
    );
  }

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode mode) async {
    final enabled = mode == AudioServiceShuffleMode.all;
    if (enabled) {
      await _player!.shuffle();
    }
    playbackState.add(playbackState.value.copyWith(shuffleMode: mode));
    await _player!.setShuffleModeEnabled(enabled);
  }

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    playbackState.add(playbackState.value.copyWith(repeatMode: repeatMode));
    await _player!.setLoopMode(LoopMode.values[repeatMode.index]);
  }

  @override
  Future<void> setSpeed(double speed) async {
    this.speed.add(speed);
    await _player!.setSpeed(speed);
  }

  @override
  Future<void> setVolume(double volume) async {
    this.volume.add(volume);
    await _player!.setVolume(volume);
  }

  @override
  Future<void> click([MediaButton button = MediaButton.media]) async {
    switch (button) {
      case MediaButton.media:
        _handleMediaActionPressed();
        break;
      case MediaButton.next:
        await skipToNext();
        break;
      case MediaButton.previous:
        await skipToPrevious();
        break;
    }
  }

  void _handleMediaActionPressed() {}

  @override
  // TODO: implement queueState
  Stream<QueueState> get queueState => throw UnimplementedError();
}
