import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'common_widgets.dart';

class AudioArtwork extends StatelessWidget {
  final int audioId;

  const AudioArtwork({Key? key, required this.audioId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 50.0, maxWidth: 50.0),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: QueryArtwork(
            artworkId: audioId,
            artworkType: ArtworkType.AUDIO,
            defaultPath: 'assets/images/artist.png',
          ),
        ),
      ),
    );
  }
}
