import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:neo_player/src/theme/style.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../locator.dart';
import '../../common_widgets/common_widgets.dart';
import '../../constants/constants.dart';
import '../../helpers/helpers.dart';
import '../../theme/theme.dart';
import 'neo_manager.dart';

final ValueNotifier<double> playerExpandProgress =
    ValueNotifier(kPlayerMinHeight);

class NowPlaying extends StatefulWidget {
  // final List<SongModel> tracks;
  // final int index;
  // final int mode;

  const NowPlaying({
    Key? key,
    // required this.tracks,
    // required this.index,
    // required this.mode,
  }) : super(key: key);

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

final neoManager = locator<NeoManager>();

class _NowPlayingState extends State<NowPlaying> {
  final MiniplayerController controller = MiniplayerController();
  bool isMuted = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final kPlayerMaxHeight = screenHeight(context);

    return Miniplayer(
      valueNotifier: playerExpandProgress,
      backgroundColor: NeumorphicTheme.baseColor(context),
      minHeight: kPlayerMinHeight,
      maxHeight: kPlayerMaxHeight,
      controller: controller,
      elevation: 5,
      // onDismissed: () => currentlyPlaying.value = null,
      curve: Curves.easeOut,
      builder: (height, percentage) {
        final bool miniPlayer = percentage < kMiniPlayerPercentageDeclaration;
        final double width = screenWidth(context);
        final maxImgSize = width * 0.8;

        // Declare additional widgets (eg. SkipButton) and variables
        if (!miniPlayer) {
          var percentageExpandedPlayer = percentageFromValueInRange(
              min: kPlayerMaxHeight * kMiniPlayerPercentageDeclaration +
                  kPlayerMinHeight,
              max: kPlayerMaxHeight,
              value: height);
          if (percentageExpandedPlayer < 0) percentageExpandedPlayer = 0;
          final paddingVertical = valueFromPercentageInRange(
              min: 0, max: 10, percentage: percentageExpandedPlayer);
          final double heightWithoutPadding = height - paddingVertical * 2;
          final double imageSize = heightWithoutPadding > maxImgSize
              ? maxImgSize
              : heightWithoutPadding;
          final paddingLeft = valueFromPercentageInRange(
                min: 0,
                max: width - imageSize,
                percentage: percentageExpandedPlayer,
              ) /
              2;
          const progressIndicator = LinearProgressIndicator(value: 0.3);

          const buttonSkipForward = IconButton(
            icon: Icon(Icons.forward_30),
            iconSize: 33,
            onPressed: onTap,
          );
          const buttonSkipBackwards = IconButton(
            icon: Icon(Icons.replay_10),
            iconSize: 33,
            onPressed: onTap,
          );
          const buttonPlayExpanded = IconButton(
            icon: Icon(Icons.pause_circle_filled),
            iconSize: 50,
            onPressed: onTap,
          );

          // =============== Full Page =================
          return Neumorphic(
            style: const NeumorphicStyle(
              boxShape: NeumorphicBoxShape.rect(),
              depth: 2,
            ),
            child: Column(
              children: [
                const SizedBox(height: 25.0),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Opacity(
                      opacity: percentageExpandedPlayer,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconBtn(
                            icon: Icons.expand_more_rounded,
                            label: 'Settings',
                            onPressed: () {
                              controller.animateToHeight(state: PanelState.MIN);
                            },
                          ),
                          Text(
                            'Now Playing',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          IconBtn(
                            icon: Icons.more_horiz_rounded,
                            label: 'Menu',
                            onPressed: () {
                              unImplementSnackBar(context);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: paddingLeft,
                      top: paddingVertical,
                      bottom: paddingVertical,
                    ),
                    child: SizedBox(
                      height: imageSize,
                      child: _buildImage(),
                    ),
                  ),
                ),
                //const SizedBox(height: 10.0),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kAppContentPadding),
                    child: Opacity(
                      opacity: percentageExpandedPlayer,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kAppContentPadding),
                            child: Column(
                              children: [
                                AnimatedText(
                                  text:
                                      'All My Love Ft. Arianna Grande and Marvin',
                                  pauseAfterRound: const Duration(seconds: 3),
                                  fadingEdgeEndFraction: 0.1,
                                  fadingEdgeStartFraction: 0.1,
                                  startAfter: const Duration(seconds: 2),
                                  style: theme.textTheme.titleLarge!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                AnimatedText(
                                  text: 'Major Lazer',
                                  pauseAfterRound: const Duration(seconds: 3),
                                  fadingEdgeEndFraction: 0.1,
                                  fadingEdgeStartFraction: 0.1,
                                  startAfter: const Duration(seconds: 2),
                                  style: theme.textTheme.titleMedium!
                                      .copyWith(color: textGrayColor),
                                  startPadding: 0.0,
                                ),
                              ],
                            ),
                          )),
                          const SizedBox(height: 20.0),
                          Flexible(
                              child: Column(
                            children: [
                              Row(
                                children: [
                                  IconBtn(
                                    icon: Icons.playlist_add,
                                    onPressed: () {},
                                    margin: EdgeInsets.zero,
                                    padding: const EdgeInsets.all(4.0),
                                    // iconColor: NeumorphicTheme.defaultTextColor(
                                    //     context),
                                  ),
                                  const SizedBox(width: 16),
                                  IconBtn(
                                    icon: isMuted
                                        ? Icons.headset
                                        : Icons.headset_off,
                                    onPressed: () {},
                                    margin: EdgeInsets.zero,
                                    padding: const EdgeInsets.all(4.0),
                                    //depth: isMuted ? -3.0 : 3.0,
                                    // iconColor: isMuted
                                    //     ? primaryColor
                                    //     : NeumorphicTheme.defaultTextColor(
                                    //         context),
                                  ),
                                ],
                              )
                            ],
                          )),
                          Flexible(
                            child: ProgressBar(
                              progress: const Duration(seconds: 100),
                              // buffered: value.buffered,
                              total: const Duration(seconds: 600) -
                                  const Duration(seconds: 200),
                              progressBarColor: theme.primaryColor,
                              baseBarColor: theme.primaryColor.withOpacity(0.2),
                              thumbGlowColor: theme.primaryColor,
                              thumbColor: theme.primaryColor,
                              timeLabelTextStyle: theme.textTheme.bodyMedium!
                                  .copyWith(color: textGrayColor),
                              timeLabelType: TimeLabelType.remainingTime,
                              barHeight: 4.0,
                              // onSeek: _pageManager.seek,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconBtn(
                                  icon: Icons.shuffle,
                                  onPressed: () {},
                                  margin: EdgeInsets.zero,
                                  padding: const EdgeInsets.all(4.0),
                                  // iconColor: NeumorphicTheme.defaultTextColor(
                                  //     context),
                                ),
                                const SizedBox(width: 24),
                                IconBtn(
                                  icon: Icons.skip_previous,
                                  onPressed: () {},
                                  iconSize: 24.0,
                                  margin: EdgeInsets.zero,
                                  padding: const EdgeInsets.all(14.0),
                                  // iconColor: NeumorphicTheme.defaultTextColor(
                                  //     context),
                                ),
                                const SizedBox(width: 20),
                                IconBtn(
                                  icon: Icons.play_arrow_rounded,
                                  onPressed: () {},
                                  margin: EdgeInsets.zero,
                                  color: theme.primaryColor,
                                  iconSize: 24.0,
                                  padding: const EdgeInsets.all(20.0),
                                  // iconColor: NeumorphicTheme.defaultTextColor(
                                  //     context),
                                ),
                                const SizedBox(width: 20),
                                IconBtn(
                                  icon: Icons.skip_next,
                                  onPressed: () {},
                                  iconSize: 24.0,
                                  margin: EdgeInsets.zero,
                                  padding: const EdgeInsets.all(14.0),
                                  // iconColor: NeumorphicTheme.defaultTextColor(
                                  //     context),
                                ),
                                const SizedBox(width: 24),
                                IconBtn(
                                  icon: Icons.repeat,
                                  onPressed: () {},
                                  margin: EdgeInsets.zero,
                                  padding: const EdgeInsets.all(4.0),
                                  // iconColor: NeumorphicTheme.defaultTextColor(
                                  //     context),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        // =============== Mini player =================
        final percentageMiniPlayer = percentageFromValueInRange(
            min: kPlayerMinHeight,
            max: kPlayerMaxHeight * kMiniPlayerPercentageDeclaration +
                kPlayerMinHeight,
            value: height);

        final elementOpacity = 1 - 1 * percentageMiniPlayer;
        final progressIndicatorHeight = 3 - 2.5 * percentageMiniPlayer;

        return Neumorphic(
          style: const NeumorphicStyle(
            // color: NeumorphicTheme.baseColor(context),
            boxShape: NeumorphicBoxShape.rect(),
            depth: 0,
          ),
          child: Column(
            children: [
              SizedBox(
                height: progressIndicatorHeight,
                child: Opacity(
                  opacity: elementOpacity,
                  child: ValueListenableBuilder<ProgressBarState>(
                      valueListenable: neoManager.progressNotifier,
                      builder: (_, value, __) {
                        double progressValue;
                        if (value.current == Duration.zero ||
                            value.total == Duration.zero) {
                          progressValue = 0.0;
                        } else {
                          progressValue =
                              value.current.inMicroseconds.toDouble() /
                                  value.total.inMicroseconds.toDouble();
                        }

                        return LinearPercentIndicator(
                          padding: EdgeInsets.zero,
                          percent: progressValue,
                          barRadius: const Radius.circular(kRadius),
                          progressColor: Theme.of(context).primaryColor,
                          backgroundColor: textGrayColor.withOpacity(0.2),
                        );
                      }),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: kAppContentPadding),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 50.0,
                        child: _buildImage(maxImgSize: maxImgSize),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Opacity(
                            opacity: elementOpacity,
                            child: ValueListenableBuilder<MediaItem?>(
                                valueListenable: neoManager.currentSongNotifier,
                                builder: (_, song, __) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      AnimatedText(
                                        text: song != null ? song.title : '',
                                        pauseAfterRound:
                                            const Duration(seconds: 3),
                                        fadingEdgeEndFraction: 0.1,
                                        fadingEdgeStartFraction: 0.1,
                                        startAfter: const Duration(seconds: 2),
                                        style: theme.textTheme.titleMedium,
                                        defaultAlignment: TextAlign.start,
                                      ),
                                      AnimatedText(
                                        text: song != null ? song.artist! : '',
                                        pauseAfterRound:
                                            const Duration(seconds: 3),
                                        fadingEdgeEndFraction: 0.1,
                                        fadingEdgeStartFraction: 0.1,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        startAfter: const Duration(seconds: 2),
                                        style: theme.textTheme.bodyLarge!
                                            .copyWith(color: textGrayColor),
                                        defaultAlignment: TextAlign.start,
                                        startPadding: 0.0,
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Opacity(
                          opacity: elementOpacity,
                          child: ValueListenableBuilder<ButtonState>(
                              valueListenable: neoManager.playButtonNotifier,
                              builder: (_, value, __) {
                                if (value == ButtonState.paused) {
                                  return IconBtn(
                                    icon: Icons.play_arrow_rounded,
                                    label: 'Play',
                                    color: NeumorphicTheme.accentColor(context),
                                    iconColor: Colors.white,
                                    padding: const EdgeInsets.all(10),
                                    onPressed: neoManager.play,
                                  );
                                } else {
                                  return IconBtn(
                                    icon: Icons.pause_rounded,
                                    label: 'Play',
                                    color: NeumorphicTheme.accentColor(context),
                                    iconColor: Colors.white,
                                    padding: const EdgeInsets.all(10),
                                    onPressed: neoManager.pause,
                                  );
                                }
                              }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Opacity(
                          opacity: elementOpacity,
                          child: ValueListenableBuilder<bool>(
                              valueListenable: neoManager.isLastSongNotifier,
                              builder: (_, isLast, __) {
                                return IconBtn(
                                  icon: Icons.fast_forward,
                                  label: 'Next',
                                  iconColor: Colors.white,
                                  onPressed: (isLast) ? null : neoManager.next,
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 1,
                color: textWhiteColor.withOpacity(0.01),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImage({double? maxImgSize}) {
    return Neumorphic(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxImgSize ?? double.infinity),
        child: Padding(
          padding: const EdgeInsets.all(kImagePadding),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(kRadius),
            ),
            child: Image.asset(
              'assets/images/freddy.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

void onTap() {}

// •

// https://github.com/peterscodee/miniplayer/blob/master/example/lib/widgets/player.dart
// https://github.com/MarcusNg/flutter_youtube_ui/blob/main/lib/screens/nav_screen.dart
