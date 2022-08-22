extension StringExtensions on String {
  String capitalize() => '${this[0].toUpperCase()}${substring(1)}';

  // get artist name
  String getArtist() => this == '<unknown>' ? 'Artiste Inconnu' : this;
}

extension DateTimeExtension on int {
  // get album count
  String getAlbumCount() {
    return this == 1 ? '${this} album' : '${this} albums';
  }

  // get song count
  String getSongCount() {
    return this == 1 ? '${this} track' : '${this} tracks';
  }

  String formatMSToHHMMSS() {
    if (this != 0) {
      final int hours = ((this / (1000 * 60 * 60)) % 24).floor();
      final int minutes = ((this / (1000 * 60)) % 60).floor();
      final int seconds = (this / 1000).floor() % 60;

      final String hoursStr = hours.toString().padLeft(2, '0');
      final String minutesStr = minutes.toString().padLeft(2, '0');
      final String secondsStr = (seconds % 60).toString().padLeft(2, '0');

      if (hours == 0) {
        return '$minutesStr:$secondsStr';
      }
      return '$hoursStr:$minutesStr:$secondsStr';
    } else {
      return '';
    }
  }

  String formatSToHHMMSS() {
    if (this != 0) {
      final int hours = this ~/ 3600;
      final int seconds = this % 3600;
      final int minutes = seconds ~/ 60;

      final String hoursStr = hours.toString().padLeft(2, '0');
      final String minutesStr = minutes.toString().padLeft(2, '0');
      final String secondsStr = (seconds % 60).toString().padLeft(2, '0');

      if (hours == 0) {
        return '$minutesStr:$secondsStr';
      }
      return '$hoursStr:$minutesStr:$secondsStr';
    } else {
      return '';
    }
  }
}
