import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../../constants/constants.dart';

class AlbumArtwork extends StatelessWidget {
  final AlbumModel album;

  const AlbumArtwork({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(
      id: album.id,
      type: ArtworkType.ALBUM,
      artworkBorder: const BorderRadius.all(
        Radius.circular(kRadius),
      ),
      artworkFit: BoxFit.cover,
      keepOldArtwork: true,
      artworkRepeat: ImageRepeat.noRepeat,
      nullArtworkWidget: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(kRadius),
        ),
        child: Image.asset(
          "assets/images/album.jpg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
