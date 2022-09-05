import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:neo_player/src/pages/now_playing/widgets/play_button.dart';
import 'package:neo_player/src/pages/now_playing/widgets/playing_image_card.dart';
import 'package:neo_player/src/theme/style.dart';

import '../../../locator.dart';
import '../../common_widgets/common_widgets.dart';
import '../../constants/constants.dart';
import '../../helpers/helpers.dart';
import '../../theme/theme.dart';
import 'expanded_player.dart';
import 'neo_manager.dart';

final playerExpandProgressNotifier = ValueNotifier(kPlayerMinHeight);
final neoManager = locator<NeoManager>();

class NowPlaying extends HookWidget {
  const NowPlaying({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final kPlayerMaxHeight = screenHeight(context);

    final controller = useMemoized(() => MiniplayerController());
    final animationController =
        useAnimationController(duration: kMediumDuration);

    useEffect(() {
      animationController.addListener(() {});
      return;
    }, [animationController]);

    return Miniplayer(
      valueNotifier: playerExpandProgressNotifier,
      backgroundColor: NeumorphicTheme.baseColor(context),
      minHeight: kPlayerMinHeight,
      maxHeight: screenHeight(context),
      controller: controller,
      elevation: 5,
      builder: (double height, double percentage) {
        final miniPlayer = percentage < kMiniPlayerPercentageDeclaration;
        final maxImgSize = screenWidth(context) * 0.8;

        // ========================== Expanded Player ==========================
        if (!miniPlayer) {
          var percentageExpandedPlayer = percentageFromValueInRange(
            min: kPlayerMaxHeight * kMiniPlayerPercentageDeclaration +
                kPlayerMinHeight,
            max: kPlayerMaxHeight,
            value: height,
          );
          if (percentageExpandedPlayer < 0) percentageExpandedPlayer = 0;
          final paddingVertical = valueFromPercentageInRange(
              min: 0, max: 10, percentage: percentageExpandedPlayer);
          final heightWithoutPadding = height - paddingVertical * 2;
          final imageSize = heightWithoutPadding > maxImgSize
              ? maxImgSize
              : heightWithoutPadding;
          final paddingLeft = valueFromPercentageInRange(
                min: 0,
                max: screenWidth(context) - imageSize,
                percentage: percentageExpandedPlayer,
              ) /
              2;

          return ExpandedPlayer(
            miniplayerController: controller,
            animationController: animationController,
            miniPlayerHeight: height,
            maxImageSize: maxImgSize,
          );
          return GestureDetector(
            onTap: () {},
            child: Neumorphic(
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
                                controller.animateToHeight(
                                    state: PanelState.MIN);
                              },
                            ),
                            Text(
                              'now_playing'.tr(),
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
                        child: PlayingImageCard(
                          maxImgSize: maxImgSize,
                        ),
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
                                      icon: true
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
                                baseBarColor:
                                    theme.primaryColor.withOpacity(0.2),
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
            ),
          );
        }

        // ========================== Mini player ==============================
        final percentageMiniPlayer = percentageFromValueInRange(
          min: kPlayerMinHeight,
          max: kPlayerMaxHeight * kMiniPlayerPercentageDeclaration +
              kPlayerMinHeight,
          value: height,
        );
        final elementOpacity = 1 - 1 * percentageMiniPlayer;
        final progressIndicatorHeight = 3 - 3 * percentageMiniPlayer;

        return Neumorphic(
          style: const NeumorphicStyle(
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

                        return LinearProgressIndicator(
                          value: progressValue,
                          color: Theme.of(context).primaryColor,
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
                        child: PlayingImageCard(maxImgSize: maxImgSize),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Opacity(
                          opacity: elementOpacity,
                          child: PlayButton(
                            animationController: animationController,
                            // onPressed: (value) {
                            //   if (value == ButtonState.playing) {
                            //     neoManager.pause();
                            //     animationController.forward();
                            //   } else {
                            //     neoManager.play();
                            //     animationController.reverse();
                            //   }
                            // },
                          ),
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
                                label: 'next'.tr(),
                                onPressed:
                                    (isLast) ? null : neoManager.skipToNext,
                              );
                            },
                          ),
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
}

// •

// https://github.com/peterscodee/miniplayer/blob/master/example/lib/widgets/player.dart
// https://github.com/MarcusNg/flutter_youtube_ui/blob/main/lib/screens/nav_screen.dart
