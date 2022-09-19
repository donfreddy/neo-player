import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neo_player/src/constants/constants.dart';
import 'package:neo_player/src/pages/songs/widgets/song_options.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../pages/now_playing/playing_now_options.dart';
import '../pages/settings/help_feedback.dart';

ShapeBorder modalBottomShape = const RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(kBottomSheetRadius),
    topRight: Radius.circular(kBottomSheetRadius),
  ),
);

void showSongOptionsModalBottom(BuildContext context, SongModel song) {
  showModalBottomSheet<Widget>(
    isScrollControlled: true,
    useRootNavigator: true,
    barrierColor: Colors.black38,
    backgroundColor: NeumorphicTheme.baseColor(context),
    shape: modalBottomShape,
    context: context,
    builder: (_) => SongOptions(song: song),
  );
}

void showHelpFeedBackModalBottom(BuildContext context) {
  showModalBottomSheet<Widget>(
    isScrollControlled: true,
    useRootNavigator: true,
    barrierColor: Colors.black38,
    backgroundColor: NeumorphicTheme.baseColor(context),
    shape: modalBottomShape,
    context: context,
    builder: (_) => const HelpFeedback(),
  );
}

void showPlayingNowOptionsModalBottom(BuildContext context) {
  showModalBottomSheet<Widget>(
    isScrollControlled: true,
    useRootNavigator: true,
    barrierColor: Colors.black38,
    backgroundColor: NeumorphicTheme.baseColor(context),
    shape: modalBottomShape,
    context: context,
    builder: (_) => const PlayingNowOptions(),
  );
}
