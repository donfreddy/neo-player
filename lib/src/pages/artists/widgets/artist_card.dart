import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neo_player/src/helpers/extensions.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../common_widgets/common_widgets.dart';
import '../../../constants/constants.dart';
import '../../../theme/style.dart';

class ArtistCard extends StatelessWidget {
  final ArtistModel artist;
  final VoidCallback? onTap;

  const ArtistCard({
    Key? key,
    required this.artist,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Neumorphic(
          margin:
              const EdgeInsets.symmetric(horizontal: kAppContentPadding - 4) +
                  const EdgeInsets.only(top: 4),
          style: NeumorphicStyle(
            boxShape:
                NeumorphicBoxShape.roundRect(BorderRadius.circular(kRadius)),
          ),
          child: InkResponse(
            onTap: onTap,
            child: AspectRatio(
              aspectRatio: 16 / 15,
              child: Padding(
                padding: const EdgeInsets.all(kImagePadding),
                child: QueryArtwork(
                  artworkId: artist.id,
                  artworkType: ArtworkType.ARTIST,
                  defaultPath: 'assets/images/artist.png',
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12) +
              const EdgeInsets.only(top: 6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                artist.artist.getArtist(),
                style: theme.textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '${artist.numberOfAlbums!.getAlbumCount()} • ${artist.numberOfTracks!.getSongCount()}',
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: textGrayColor,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
