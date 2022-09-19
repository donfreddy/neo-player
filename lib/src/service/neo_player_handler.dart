import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart';

import '../pages/now_playing/neo_manager.dart';

abstract class NeoPlayerHandler {
  Stream<QueueState> get queueState;

  Future<void> moveQueueItem(int currentIndex, int newIndex);

  ValueStream<double> get volume;

  Future<void> setVolume(double volume);

  ValueStream<double> get speed;
}

class NeoPlayerHandlerImpl {}

class NeoHandler {}

class FavoriteNotifier extends ValueNotifier<bool> {
  FavoriteNotifier() : super(false);

  void addToFavorite(SongModel song) {
    // value
  }
}
