import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:neo_player/src/common_widgets/query_artwork.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../locator.dart';
import '../constants/constants.dart';
import '../pages/now_playing/neo_manager.dart';
import '../theme/style.dart';
import 'custom_material.dart';
import 'icon_btn.dart';
import 'modal_bottom_sheet.dart';

class SongItem extends StatelessWidget {
  final SongModel song;
  final ArtworkType artworkType;
  final VoidCallback? onPressed;

  const SongItem({
    Key? key,
    required this.song,
    this.artworkType = ArtworkType.AUDIO,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialWitchInkWell(
      onTap: onPressed,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Neumorphic(
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxHeight: 50.0, maxWidth: 50.0),
                child: Padding(
                  padding: const EdgeInsets.all(kImagePadding / 2),
                  child: QueryArtwork(
                    artworkId: song.id,
                    artworkType: artworkType,
                    defaultPath: 'assets/images/artist.png',
                  ),
                ),
              ),
            ),
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
                      valueListenable:
                          locator<NeoManager>().currentSongNotifier,
                      builder: (_, currentSong, __) {
                        return Text(
                          song.title,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: currentSong != null
                                      ? currentSong.id == song.id.toString()
                                          ? Theme.of(context).primaryColor
                                          : null
                                      : null),
                          maxLines: 1,
                        );
                      }),
                  Text(
                    song.artist == '<unknown>'
                        ? 'Artiste inconnu'
                        : song.artist!,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: textGrayColor,
                        ),
                    maxLines: 1,
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
