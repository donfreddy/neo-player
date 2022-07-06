import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../../constants/constants.dart';
import '../../../components/query_artwork.dart';

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
                  defaultPath: "assets/images/artist.png",
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
                artist.artist == '<unknown>'
                    ? 'Artiste inconnu'
                    : artist.artist,
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Opacity(
                opacity: 0.6,
                child: Text(
                  artist.numberOfAlbums == 1
                      ? "${artist.numberOfAlbums} album"
                      : "${artist.numberOfAlbums} albums",
                  style: Theme.of(context).textTheme.bodyLarge,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
