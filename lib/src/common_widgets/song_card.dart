import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:neo_player/src/common_widgets/audio_artwork.dart';
import 'package:neo_player/src/helpers/extensions.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../locator.dart';
import '../constants/constants.dart';
import '../pages/now_playing/neo_manager.dart';
import '../theme/style.dart';
import 'custom_material.dart';
import 'icon_btn.dart';
import 'modal_bottom_sheet.dart';

class SongCard extends StatelessWidget {
  final SongModel song;
  final ArtworkType artworkType;
  final VoidCallback? onTap;

  const SongCard({
    Key? key,
    required this.song,
    this.artworkType = ArtworkType.AUDIO,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MaterialWitchInkWell(
      onTap: onTap,
      onLongPress: () {
        showSongOptionsModalBottom(context, song);
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: AudioArtwork(audioId: song.id),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ValueListenableBuilder<MediaItem?>(
                    valueListenable: locator<NeoManager>().currentSongNotifier,
                    builder: (_, currentSong, __) {
                      return Text(
                        song.title,
                        style: theme.textTheme.titleMedium!.copyWith(
                          color: currentSong != null
                              ? currentSong.id == song.id.toString()
                                  ? theme.primaryColor
                                  : null
                              : null,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      );
                    },
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${song.artist!.getArtist()} • ${song.duration?.formatMSToHHMMSS()}',
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: textGrayColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: kAppContentPadding / 2),
            child: SizedBox(
              height: 60,
              child: IconBtn(
                icon: Icons.more_horiz_rounded,
                label: 'Option',
                onPressed: () {
                  showSongOptionsModalBottom(context, song);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
