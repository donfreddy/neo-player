import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:neo_player/src/helpers/extensions.dart';
import 'package:neo_player/src/pages/now_playing/now_playing.dart';
import 'package:neo_player/src/pages/now_playing/widgets/next_button.dart';
import 'package:neo_player/src/pages/now_playing/widgets/play_pause_button.dart';
import 'package:neo_player/src/pages/now_playing/widgets/playing_image_card.dart';
import 'package:neo_player/src/pages/now_playing/widgets/previous_buttton.dart';
import 'package:neo_player/src/pages/now_playing/widgets/seek_bar.dart';
import 'package:neo_player/src/pages/now_playing/widgets/volume_slider.dart';

import '../../../locator.dart';
import '../../common_widgets/common_widgets.dart';
import '../../constants/constants.dart';
import '../../helpers/common.dart';
import '../../theme/style.dart';
import '../../theme/theme.dart';
import 'neo_manager.dart';

final neoManager = locator<NeoManager>();

class ExpandedPlayer extends StatelessWidget {
  final MiniplayerController miniplayerController;
  final double miniPlayerHeight;
  final double maxImageSize;

  const ExpandedPlayer({
    Key? key,
    required this.miniplayerController,
    required this.miniPlayerHeight,
    required this.maxImageSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final playerMaxHeight = screenHeight(context);
    var percentageExpandedPlayer = percentageFromValueInRange(
      min:
          playerMaxHeight * kMiniPlayerPercentageDeclaration + kPlayerMinHeight,
      max: playerMaxHeight,
      value: miniPlayerHeight,
    );
    if (percentageExpandedPlayer < 0) percentageExpandedPlayer = 0;
    final paddingVertical = valueFromPercentageInRange(
        min: 0, max: 10, percentage: percentageExpandedPlayer);
    final heightWithoutPadding = miniPlayerHeight - paddingVertical * 2;
    final imageSize = heightWithoutPadding > maxImageSize
        ? maxImageSize
        : heightWithoutPadding;
    final paddingLeft = valueFromPercentageInRange(
          min: 0,
          max: screenWidth(context) - imageSize,
          percentage: percentageExpandedPlayer,
        ) /
        2;

    final height = playerMaxHeight - (screenWidth(context) * 0.85);
    final spacerBoxHeight = height * 0.028;
    final infoBoxHeight = height * 0.16;
    final progressBarBoxHeight = height * 0.1;
    final controlBoxHeight = height * 0.2;
    final volumeSliderBoxHeight = height * 0.04;
    final bottomBtnBoxHeight = height * 0.1;

    return GestureDetector(
      onTap: () {},
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            SizedBox(height: height * 0.08),
            // Artwork
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: paddingVertical) +
                    EdgeInsets.only(left: paddingLeft),
                child: SizedBox(
                  height: imageSize,
                  child: PlayingImageCard(maxImgSize: maxImageSize),
                ),
              ),
            ),
            SizedBox(
              width: maxImageSize,
              child: Column(
                children: [
                  SizedBox(height: spacerBoxHeight),
                  SongInfoAndOption(height: infoBoxHeight),
                  SizedBox(height: spacerBoxHeight),
                  SeekBar(barHeight: progressBarBoxHeight),
                  SizedBox(height: spacerBoxHeight),
                  _TopControl(height: controlBoxHeight),
                  SizedBox(height: spacerBoxHeight * 2.2),
                  VolumeSlider(barHeight: volumeSliderBoxHeight),
                  SizedBox(height: spacerBoxHeight * 2.7),
                  _BottomControl(height: bottomBtnBoxHeight),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SongInfoAndOption extends StatelessWidget {
  const SongInfoAndOption({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ValueListenableBuilder<MediaItem?>(
      valueListenable: neoManager.currentSongNotifier,
      builder: (_, song, __) {
        return SizedBox(
          height: height,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedText(
                        text: song != null
                            ? song.title.split(' (')[0].split('|')[0].trim()
                            : '',
                        pauseAfterRound: const Duration(seconds: 3),
                        fadingEdgeEndFraction: 0.1,
                        fadingEdgeStartFraction: 0.1,
                        startAfter: const Duration(seconds: 2),
                        style: theme.textTheme.titleMedium!.copyWith(
                          fontSize: height / 3,
                          fontWeight: FontWeight.bold,
                        ),
                        defaultAlignment: TextAlign.start),
                    AnimatedText(
                        text: song != null ? song.artist!.getArtist() : '',
                        pauseAfterRound: const Duration(seconds: 3),
                        fadingEdgeEndFraction: 0.1,
                        fadingEdgeStartFraction: 0.1,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        startAfter: const Duration(seconds: 2),
                        style: theme.textTheme.titleSmall!.copyWith(
                          color: textGrayColor,
                          fontSize: height / 4.5,
                        ),
                        defaultAlignment: TextAlign.start),
                  ],
                ),
              ),
              const SizedBox(width: 10.0),
              IconBtn(
                icon: Icons.favorite_rounded,
                onPressed: () {
                  unImplementSnackBar(context);
                },
                margin: EdgeInsets.zero,
                padding: const EdgeInsets.all(4.0),
              ),
              const SizedBox(width: 14.0),
              IconBtn(
                icon: Icons.more_horiz_rounded,
                onPressed: () {
                  unImplementSnackBar(context);
                },
                margin: EdgeInsets.zero,
                padding: const EdgeInsets.all(4.0),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TopControl extends StatelessWidget {
  const _TopControl({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Replay10Button(),
          Spacer(),
          PreviousButton(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.all(16.0),
          ),
          SizedBox(width: 20),
          PlayPauseButton(
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.zero,
          ),
          SizedBox(width: 20),
          NextButton(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.all(16.0),
          ),
          Spacer(),
          Forward10Button()
        ],
      ),
    );
  }
}

class Replay10Button extends StatelessWidget {
  const Replay10Button({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: locator<NeoManager>().progressNotifier,
      builder: (_, progressValue, __) {
        return IconBtn(
          icon: Icons.replay_10_rounded,
          onPressed: neoManager.replay10,
          margin: EdgeInsets.zero,
          padding: const EdgeInsets.all(4.0),
        );
        //
      },
    );
  }
}

class Forward10Button extends StatelessWidget {
  const Forward10Button({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: locator<NeoManager>().progressNotifier,
      builder: (_, progressValue, __) {
        return IconBtn(
          icon: Icons.forward_10_rounded,
          onPressed: neoManager.forward10,
          margin: EdgeInsets.zero,
          padding: const EdgeInsets.all(4.0),
        );
      },
    );
  }
}

class _BottomControl extends StatelessWidget {
  const _BottomControl({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconBtn(
            icon: Icons.share_rounded,
            onPressed: () {},
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.all(4.0),
          ),
          const ShuffleButton(),
          const RepeatButton(),
          IconBtn(
            icon: Icons.queue_music_rounded,
            onPressed: () {},
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.all(4.0),
          ),
        ],
      ),
    );
  }
}
