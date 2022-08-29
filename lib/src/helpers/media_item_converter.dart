import 'dart:io';

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

  static MediaItem mapToMediaItem(Map song, Directory tempDir) {
    final imagePath = '${tempDir.path}/${song['_display_name_wo_ext']}.jpg';
    return MediaItem(
      id: song['_id'].toString(),
      title: song['title'] == '' ? song['_display_name_wo_ext'] : song['title'],
      artist: song['artist'] == '<unknown>' ? 'Unknown' : song['artist'],
      duration: Duration(milliseconds: song['duration'] ?? 180000),
      album: song['album'],
      artUri: Uri.file(imagePath),
      genre: song['genre'],
      extras: {
        'url': song['_data'],
        'display_name': song['_display_name'],
        'size': song['_size'],
        'year': song['year'],
        'date_added': song['date_added'],
        'date_modified': song['date_modified'],
        'file_extension': song['file_extension']
      },
    );
  }
}
