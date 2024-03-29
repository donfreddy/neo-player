import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../../constants/constants.dart';
import '../../../components/query_artwork.dart';

class AlbumCard extends StatelessWidget {
  final AlbumModel album;
  final VoidCallback? onTap;

  const AlbumCard({
    Key? key,
    required this.album,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          tag: 'album ${album.id}',
          child: Neumorphic(
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
                    artworkId: album.id,
                    artworkType: ArtworkType.ALBUM,
                    defaultPath: "assets/images/album.jpg",
                  ),
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
                album.album,
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Opacity(
                opacity: 0.6,
                child: Text(
                  album.artist == '<unknown>'
                      ? 'Artiste inconnu'
                      : album.artist!,
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
