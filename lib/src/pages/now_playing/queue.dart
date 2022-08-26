import 'package:audio_service/audio_service.dart';

class QueueState {
  final List<MediaItem> queue;
  final int? queueIndex;
  final List<int>? shuffleIndices;
  final AudioServiceRepeatMode repeatMode;

  const QueueState._({
    required this.queue,
    this.queueIndex,
    this.shuffleIndices,
    required this.repeatMode,
  });

  QueueState.empty()
      : this._(
          queue: [],
          queueIndex: 0,
          shuffleIndices: [],
          repeatMode: AudioServiceRepeatMode.none,
        );

  QueueState.currentValue(
    List<MediaItem> queue,
    int? queueIndex,
    List<int>? shuffleIndices,
    AudioServiceRepeatMode repeatMode,
  ) : this._(
          queue: queue,
          queueIndex: queueIndex,
          shuffleIndices: shuffleIndices,
          repeatMode: repeatMode,
        );

  bool get hasPrevious =>
      repeatMode != AudioServiceRepeatMode.none || (queueIndex ?? 0) > 0;

  bool get hasNext =>
      repeatMode != AudioServiceRepeatMode.none ||
      (queueIndex ?? 0) + 1 < queue.length;

  List<int> get indices =>
      shuffleIndices ?? List.generate(queue.length, (i) => i);
}
