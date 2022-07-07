import 'package:audio_service/audio_service.dart';

class MediaItemConverter {
  static Map mediaItemToMap(MediaItem mediaItem) {
    return {
      'id': mediaItem.id,
      'album': mediaItem.album.toString(),
      'album_id': mediaItem.extras?['album_id'],
      'artist': mediaItem.artist.toString(),
      'duration': mediaItem.duration?.inSeconds.toString(),
      'genre': mediaItem.genre.toString(),
      'has_lyrics': mediaItem.extras!['has_lyrics'],
      'image': mediaItem.artUri.toString(),
      'language': mediaItem.extras?['language'].toString(),
      'release_date': mediaItem.extras?['release_date'],
      'subtitle': mediaItem.extras?['subtitle'],
      'title': mediaItem.title,
      'url': mediaItem.extras!['url'].toString(),
      'lowUrl': mediaItem.extras!['lowUrl']?.toString(),
      'highUrl': mediaItem.extras!['highUrl']?.toString(),
      'year': mediaItem.extras?['year'].toString(),
      '320kbps': mediaItem.extras?['320kbps'],
      'quality': mediaItem.extras?['quality'],
      'perma_url': mediaItem.extras?['perma_url'],
    };
  }

  static MediaItem mapToMediaItem(Map song,
      {bool addedByAutoplay = false,
      bool autoplay = true,
     bool loadThumbnailUri = false}) {
    return MediaItem(
      id: song['_id'].toString(),
      album: song['album'].toString(),
      artist: song['artist'].toString(),
      duration: Duration(
        seconds: int.parse(
          (song['duration'] == null || song['duration'] == 'null')
              ? '180'
              : song['duration'].toString(),
        ),
      ),
      title: song['title'].toString(),
      artUri: Uri.parse(song['_uri'].toString()),
      genre: song['genre'].toString(),
      extras: {
        'url': song['_data'] ,
        'display_name': song['_display_name'],
        'display_name_wo_ext': song['_display_name_wo_ext'],
        'size': song['_size'],
        'year': song['year'],
        'date_added': song['date_added'],
        'date_modified': song['date_modified'],
        'track': song['track'],
        'album_id': song['album_id'],
        'artist_id': song['artist_id'],
        'genre_id': song['genre_id'] ?? '',
        'bookmark': song['bookmark'],
        'composer': song['composer'] ?? '',
        'is_alarm': song['is_alarm'],
        'is_audiobook': song['is_audiobook'],
        'is_music': song['is_music'],
        'is_notification': song['is_notification'],
        'is_podcast': song['is_podcast'],
        'is_ringtone': song['is_ringtone'],
        'file_extension': song['file_extension'],
        'loadThumbnailUri': loadThumbnailUri,
        'addedByAutoplay': addedByAutoplay,
        'autoplay': autoplay,
      },
    );
  }
}
