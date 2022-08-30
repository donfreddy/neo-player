// Convert minutes to duration string
import 'package:on_audio_query/on_audio_query.dart';

String getDuration(int? duration) {
  double time = duration?.toDouble() ?? 0;
  final double hour = time / 60;
  final double minutes = time % 60;
  // return '${hour.toString().padLeft(2, "0")}:${minutes.toString().padLeft(
  //     2, "0")}'
  if (hour == 0) return '$minutes minutes';
  return '$hour heures $minutes minutes';
}

String durationToString(int minutes) {
  var d = Duration(minutes: minutes);
  List<String> parts = d.toString().split(':');
  return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
}
// print(durationToString(100)); //returns 01:40

String intToDuration(int time) {
  final int h = ((time / (1000 * 60 * 60)) % 24).floor();
  final int m = ((time / (1000 * 60)) % 60).floor();

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

String intToDuration2(int value) {
  // 00:00:00
  int h, m, s;

  h = value ~/ 3600;

  m = ((value - h * 3600)) ~/ 60;

  s = value - (h * 3600) - (m * 60);

  String hourLeft = h.toString().length < 2 ? "0$h" : h.toString();

  String minuteLeft = m.toString().length < 2 ? "0$m" : m.toString();

  String secondsLeft = s.toString().length < 2 ? "0$s" : s.toString();

  String result = "$hourLeft:$minuteLeft:$secondsLeft";

  return result;
}

int getTotalInt(List<SongModel> songs) {
  int total = 0;

  for (var s in songs) {
    if (s.duration != null) {
      total += s.duration!;
    }
  }

  return total;
}
