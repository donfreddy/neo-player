import '../dao/song_dao.dart';

class SongRepository {
  final songDao = SongDao();

  Future<int> insertSongs() => songDao.insertSongs();
}
