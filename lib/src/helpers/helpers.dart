import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:neo_player/src/theme/style.dart';

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
