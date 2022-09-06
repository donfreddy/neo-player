import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:neo_player/src/pages/now_playing/now_playing.dart';
import 'package:neo_player/src/pages/now_playing/widgets/play_button.dart';
import 'package:neo_player/src/pages/now_playing/widgets/playing_image_card.dart';
import 'package:neo_player/src/pages/now_playing/widgets/volume_slider.dart';

import '../../../locator.dart';
import '../../common_widgets/common_widgets.dart';
import '../../constants/constants.dart';
import '../../helpers/helpers.dart';
import '../../theme/style.dart';
import '../../theme/theme.dart';
import 'neo_manager.dart';

final neoManager = locator<NeoManager>();

class ExpandedPlayer extends StatelessWidget {
  final MiniplayerController miniplayerController;
  final AnimationController animationController;
  final double miniPlayerHeight;
  final double maxImageSize;

  const ExpandedPlayer({
    Key? key,
    required this.miniplayerController,
    required this.animationController,
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

    //
    final height = playerMaxHeight - (screenWidth(context) * 0.85);
    final titleBoxHeight = height * 0.16;
    final progressBarBoxHeight = height * 0.1;
    final volumeSliderBoxHeight = height * 0.1;

    return GestureDetector(
      onTap: () {},
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            SizedBox(height: height * 0.1),
            // Artwork
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: paddingVertical) +
                    EdgeInsets.only(left: paddingLeft),
                child: SizedBox(
                  height: imageSize,
                  child: PlayingImageCard(
                    maxImgSize: maxImageSize,
                  ),
                ),
              ),
            ),
            // title and controls
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kAppContentPadding,
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: height * 0.02),
                  // Title, subtitle and button
                  SizedBox(
                    height: titleBoxHeight,
                    child: Center(
                      child: Container(
                        // color: Colors.yellow,
                        child: ValueListenableBuilder<MediaItem?>(
                          valueListenable: neoManager.currentSongNotifier,
                          builder: (_, song, __) {
                            return Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    //  mainAxisSize: MainAxisSize.min,
                                    children: [
                                      AnimatedText(
                                          text: song != null
                                              ? song.title
                                                  .split(' (')[0]
                                                  .split('|')[0]
                                                  .trim()
                                              : '',
                                          pauseAfterRound:
                                              const Duration(seconds: 3),
                                          fadingEdgeEndFraction: 0.1,
                                          fadingEdgeStartFraction: 0.1,
                                          startAfter:
                                              const Duration(seconds: 2),
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                            fontSize: titleBoxHeight / 2.8,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          defaultAlignment: TextAlign.start),
                                      AnimatedText(
                                          text:
                                              song != null ? song.artist! : '',
                                          pauseAfterRound:
                                              const Duration(seconds: 3),
                                          fadingEdgeEndFraction: 0.1,
                                          fadingEdgeStartFraction: 0.1,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          startAfter:
                                              const Duration(seconds: 2),
                                          style: theme.textTheme.titleSmall!
                                              .copyWith(
                                            color: textGrayColor,
                                            fontSize: titleBoxHeight / 4,
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
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.06),

                  // Progress Bar
                  SizedBox(
                    height: progressBarBoxHeight,
                    child: Container(
                      // color: Colors.green,
                      child: const AudioProgressBar(),
                    ),
                  ),

                  // SizedBox(
                  //   height: height * 0.09,
                  //   child: Container(
                  //     // color: Colors.deepOrange,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         IconBtn(
                  //           icon: Icons.replay_10_rounded,
                  //           onPressed: () {},
                  //           margin: EdgeInsets.zero,
                  //           padding: const EdgeInsets.all(4.0),
                  //         ),
                  //         IconBtn(
                  //           icon: Icons.forward_10_rounded,
                  //           onPressed: () {},
                  //           margin: EdgeInsets.zero,
                  //           padding: const EdgeInsets.all(4.0),
                  //           // iconColor: NeumorphicTheme.defaultTextColor(
                  //           //     context),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: height * 0.07),
                  // Control
                  SizedBox(
                    height: height * 0.18,
                    child: Container(
                      // color: Colors.deepOrange,
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconBtn(
                                icon: Icons.replay_10_rounded,
                                onPressed: () {},
                                margin: EdgeInsets.zero,
                                padding: const EdgeInsets.all(4.0),
                              ),
                              const ShuffleButton()
                            ],
                          ),
                          const Spacer(),
                          const PreviousSongButton(
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.all(12.0),
                          ),
                          const SizedBox(width: 10),
                          PlayButton(
                            animationController: animationController,
                            padding: const EdgeInsets.all(20.0),
                            margin: EdgeInsets.zero,
                          ),
                          const SizedBox(width: 10),
                          const NextSongButton(
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.all(12.0),
                          ),
                          const Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconBtn(
                                icon: Icons.forward_10_rounded,
                                onPressed: () {},
                                margin: EdgeInsets.zero,
                                padding: const EdgeInsets.all(4.0),
                              ),
                              const RepeatButton()
                            ],
                          )
                        ],
                      ),
                    ),
                  ),

                  // Volume
                  SizedBox(height: height * 0.07),
                  SizedBox(
                    height: volumeSliderBoxHeight,
                    child: Container(
                      //  color: Colors.yellow,
                      child: VolumeSlider(height: volumeSliderBoxHeight),
                    ),
                  ),
                  SizedBox(height: height * 0.04),
                  SizedBox(
                    height: height * 0.09,
                    child: Container(
                      // color: Colors.deepOrange,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconBtn(
                            icon: Icons.playlist_add_rounded,
                            onPressed: () {},
                            margin: EdgeInsets.zero,
                            padding: const EdgeInsets.all(4.0),
                          ),
                          IconBtn(
                            icon: Icons.queue_music_rounded,
                            onPressed: () {},
                            margin: EdgeInsets.zero,
                            padding: const EdgeInsets.all(4.0),
                            // iconColor: NeumorphicTheme.defaultTextColor(
                            //     context),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: volumeSliderBoxHeight,
                  //   child: Container(
                  //     color: Colors.yellow,
                  //     child: const NeumorphicProgress(
                  //       percent: 0.5,
                  //       style: ProgressStyle(
                  //         accent: Colors.grey,
                  //         variant: Colors.green,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AudioProgressBar extends StatelessWidget {
  const AudioProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: neoManager.progressNotifier,
      builder: (_, value, __) {
        return ProgressBar(
          progress: value.current,
          buffered: value.buffered,
          total: value.total,
          progressBarColor: theme.primaryColor,
          thumbGlowColor: theme.primaryColor,
          thumbGlowRadius: 20,
          bufferedBarColor: theme.primaryColor.withOpacity(0.1),
          thumbColor: theme.primaryColor,
          timeLabelType: TimeLabelType.remainingTime,
          timeLabelLocation: TimeLabelLocation.above,
          barHeight: 4.0,
          thumbRadius: 6,
          onSeek: neoManager.seek,
          baseBarColor: textGrayColor.withOpacity(0.2),
          timeLabelTextStyle:
              theme.textTheme.bodyMedium!.copyWith(color: textGrayColor),
          onDragStart: (details) {},
          onDragUpdate: (details) {
            if (kDebugMode) print(details.toString());
          },
          onDragEnd: () {},
        );
      },
    );
  }
}
