import 'package:neo_player/locator.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../dao/song_dao.dart';

class SongRepository {
  final SongDao songDao = locator<SongDao>();

  Future<int> insertSongs(SongModel songModel) => songDao.insertSongs();
}
