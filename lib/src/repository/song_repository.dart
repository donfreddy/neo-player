import 'package:neo_player/src/dao/song_dao.dart';

class SongRepository {
  final songDao = SongDao();

  Future<int> insertSongs() => songDao.insertSongs();
}
