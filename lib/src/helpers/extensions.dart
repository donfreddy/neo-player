import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

extension StringExtensions on String {
  // get artist name
  String getArtist() => this == '<unknown>' ? 'unknown_artist'.tr() : this;
}

extension IntExtension on int {
  // get album count
  String getAlbumCount() => plural('album_count', this);

  // get song count
  String getSongCount() => plural('song_count', this);

  /// Get formatted datetime e.g: Feb 20, 2022, 13:16
  String toDateAndTime(Locale currentLocale) {
    String locale = currentLocale.toString();
    var dateTime = DateTime.fromMillisecondsSinceEpoch(this * 1000);
    final date = DateFormat.yMMMd(locale).format(dateTime);
    final time = DateFormat.jm(locale).format(dateTime);
    return '$date, $time';
  }

  String formatMSToHHMMSS() {
    if (this == 0) return '00:00';
    final hours = ((this / (1000 * 60 * 60)) % 24).floor();
    final minutes = ((this / (1000 * 60)) % 60).floor();
    final seconds = (this / 1000).floor() % 60;

    final hoursStr = hours.toString().padLeft(2, '0');
    final minutesStr = minutes.toString().padLeft(2, '0');
    final secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hours == 0) return '$minutesStr:$secondsStr';
    return '$hoursStr:$minutesStr:$secondsStr';
  }

  String toDuration() {
    final int h = ((this / (1000 * 60 * 60)) % 24).floor();
    final int m = ((this / (1000 * 60)) % 60).floor();

    if (h == 0 && m == 1) {
      return '$m minute';
    } else if (h == 0 && m > 1) {
      return '$m minutes';
    } else if (h == 1 && m == 1) {
      return '$h heure $m minute';
    } else if (h > 1 && m == 1) {
      return '$h heures $m minute';
    } else if (h == 1 && m > 1) {
      return '$h heure $m minutes';
    }
    return '$h heures $m minutes';
  }
}
