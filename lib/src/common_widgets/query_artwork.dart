import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../constants/constants.dart';

class QueryArtwork extends StatelessWidget {
  final int artworkId;
  final ArtworkType artworkType;
  final String defaultPath;

  const QueryArtwork({
    Key? key,
    required this.artworkId,
    required this.artworkType,
    required this.defaultPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(
      id: artworkId,
      type: artworkType,
      artworkBorder: const BorderRadius.all(Radius.circular(kRadius)),
      artworkFit: BoxFit.cover,
      keepOldArtwork: true,
      artworkRepeat: ImageRepeat.noRepeat,
      nullArtworkWidget: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(kRadius)),
        child: Image.asset(defaultPath, fit: BoxFit.cover),
      ),
    );
  }
}
