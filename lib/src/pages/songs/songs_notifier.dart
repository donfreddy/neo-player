import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../locator.dart';
import '../../helpers/sort_types.dart';
import '../../service/audio_query.dart';

class SongsNotifier extends ValueNotifier<List<SongModel>> {
  SongsNotifier() : super([]);

  void loadSongs(int sortVal, int order) async {
    value = (await locator<AudioQuery>().getSongs(
      sortType: songSortTypes[sortVal],
      orderType: orderTypes[order],
    ))
        .where((i) => (i.isNotification == false || i.isAlarm == false))
        .toList();
  }
}
