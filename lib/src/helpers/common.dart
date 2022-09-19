import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:neo_player/locator.dart';
import 'package:neo_player/src/theme/style.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';

import 'media_item_converter.dart';

double valueFromPercentageInRange(
    {required final double min, max, percentage}) {
  return percentage * (max - min) + min;
}

///Calculates the percentage of a value within a given range of values
double percentageFromValueInRange({required final double min, max, value}) {
  return (value - min) / (max - min);
}

UriAudioSource createAudioSource(MediaItem mediaItem) {
  return AudioSource.uri(
    Uri.parse(mediaItem.extras!['url'].toString()),
    tag: mediaItem,
  );
}

Future<String> getFileSize(String filepath, {int decimals = 2}) async {
  int bytes = await File(filepath).length();
  if (bytes <= 0) return '0 B';
  const k = 1024;
  const suffixes = ['B', 'KB', 'MB'];

  var i = (log(bytes) / log(k)).floor();
  return '${(bytes / pow(k, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
}

int getTotalSongDuration(List<SongModel> songs) {
  int total = 0;
  for (var s in songs) {
    if (s.duration != null) {
      total += s.duration!;
    }
  }
  return total;
}

Future<File> getFileFromArtwork(int songId, String path) async {
  final imageInUnit8List = await locator<OnAudioQuery>().queryArtwork(
    songId,
    ArtworkType.AUDIO,
    format: ArtworkFormat.PNG,
  );
  final file = File('${(await getTemporaryDirectory()).path}/$path.png');
  if (!await file.exists()) {
    if (imageInUnit8List != null) {
      file.writeAsBytesSync(imageInUnit8List);
    } else {
      final byteData = await rootBundle.load('assets/images/artist.png');
      await file.writeAsBytes(byteData.buffer.asUint8List(
        byteData.offsetInBytes,
        byteData.lengthInBytes,
      ));
    }
  }
  return file;
}

Future<MediaItem> getMediaItem(SongModel song) async {
  final file = await getFileFromArtwork(song.id, song.displayNameWOExt);
  return MediaItemConverter.mapToMediaItem(song.getMap, file);
}

Future<List<MediaItem>> getMediaItems(List<SongModel> songs) async {
  final List<MediaItem> mediaItems = [];
  for (int i = 0; i < songs.length; i++) {
    mediaItems.add(await getMediaItem(songs[i]));
  }
  return mediaItems;
}

void showSnackBar(BuildContext context, String message) {
  final theme = Theme.of(context);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: theme.primaryColor,
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        style: theme.textTheme.titleSmall!.copyWith(color: textWhiteColor),
      ),
    ),
  );
}

void unImplementSnackBar(BuildContext context) {
  final theme = Theme.of(context);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: theme.primaryColor,
      behavior: SnackBarBehavior.floating,
      content: Text(
        'We are working on it! 😊, It will be available soon. Thanks for your patience!',
        style: theme.textTheme.titleSmall!.copyWith(color: textWhiteColor),
      ),
    ),
  );
}
