import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:neo_player/src/pages/now_playing/widgets/control_button.dart';
import 'package:neo_player/src/pages/now_playing/widgets/playing_image_card.dart';
import 'package:neo_player/src/theme/style.dart';

import '../../../locator.dart';
import '../../common_widgets/common_widgets.dart';
import '../../constants/constants.dart';
import '../../helpers/common.dart';
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

    final controller = useMemoized(() => MiniplayerController(), [key]);

    useEffect(() {
      controller.dispose;
      return;
    }, [controller]);

    return Miniplayer(
      valueNotifier: playerExpandProgressNotifier,
      backgroundColor: NeumorphicTheme.baseColor(context),
      minHeight: kPlayerMinHeight,
      maxHeight: screenHeight(context),
      controller: controller,
      elevation: 5,
      builder: (double height, double percentage) {
        final miniPlayer = percentage < kMiniPlayerPercentageDeclaration;
        final maxImgSize = screenWidth(context) * 0.9;

        // ========================== Expanded Player ==========================
        if (!miniPlayer) {
          return ExpandedPlayer(
            miniPlayerHeight: height,
            maxImageSize: maxImgSize,
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
                          child: const PlayPauseButton(

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
                          child: const NextButton(),
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
