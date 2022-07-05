import 'package:on_audio_query/on_audio_query.dart';

class AudioQuery {
  static OnAudioQuery audioQuery = OnAudioQuery();

  Future<List<SongModel>> getAlbumsSongs(int albumId) {
    return audioQuery.queryAudiosFrom(AudiosFromType.ALBUM, albumId);
  }
}
