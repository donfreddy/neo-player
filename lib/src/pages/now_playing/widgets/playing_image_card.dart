import 'dart:io';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:just_audio_background/just_audio_background.dart';

import '../../../../locator.dart';
import '../../../constants/constants.dart';
import '../neo_manager.dart';

class PlayingImageCard extends StatelessWidget {
  final double? maxImgSize;

  const PlayingImageCard({Key? key, this.maxImgSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxImgSize ?? double.infinity),
        child: Padding(
          padding: const EdgeInsets.all(kImagePadding / 2),
          child: ValueListenableBuilder<MediaItem?>(
            valueListenable: locator<NeoManager>().currentSongNotifier,
            builder: (_, currentSong, __) {
              return ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(kRadius),
                ),
                child: currentSong != null
                    ? Image.file(
                        File.fromUri(currentSong.artUri!),
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      )
                    : Container(),
              );
            },
          ),
        ),
      ),
    );
  }
}
