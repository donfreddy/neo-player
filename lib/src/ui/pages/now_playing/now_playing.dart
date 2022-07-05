import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:miniplayer/miniplayer.dart';

import '../../../constants/constants.dart';
import '../../components/icon_btn.dart';
import '../../components/marquee.dart';
import '../../theme/theme.dart';
import '../main/main_page.dart';

final ValueNotifier<double> playerExpandProgress =
    ValueNotifier(kMiniPlayerHeight);

class NowPlaying extends StatefulWidget {
  // final List<SongModel> songs;
  // final int index;
  // final int mode;

  const NowPlaying({
    Key? key,
    // required this.songs,
    // required this.index,
    // required this.mode,
  }) : super(key: key);

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  final MiniplayerController controller = MiniplayerController();

  @override
  Widget build(BuildContext context) {
    return Miniplayer(
      valueNotifier: playerExpandProgress,
      backgroundColor: NeumorphicTheme.baseColor(context),
      minHeight: kMiniPlayerHeight,
      maxHeight: screenHeight(context),
      controller: controller,
      elevation: 8,
      // onDismissed: () => currentlyPlaying.value = null,
      curve: Curves.easeOut,
      builder: (height, percentage) {
        // final bool miniPlayer = percentage < 0.04;
        final bool miniPlayer = percentage < miniPlayerPercentageDeclaration;
        final double width = MediaQuery.of(context).size.width;
        final maxImgSize = width * 0.4;

        // Declare additional widgets (eg. SkipButton) and variables
        if (!miniPlayer) {
          return Neumorphic(
            style: const NeumorphicStyle(
              boxShape: NeumorphicBoxShape.rect(),
            ),
            child: Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 30.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Now Playing",
                            style: Theme.of(context).textTheme.titleLarge,
                            maxLines: 1,
                          ),
                        ),
                        IconBtn(
                          icon: Icons.more_horiz_rounded,
                          label: 'Settings',
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                  // Align(
                  //   alignment: Alignment.centerLeft,
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(
                  //         horizontal: screenWidth(context) * 0.2),
                  //     child: Neumorphic(
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(kCardPadding),
                  //         child: ClipRRect(
                  //           borderRadius: const BorderRadius.all(
                  //             Radius.circular(kRadius),
                  //           ),
                  //           child: Image.asset(
                  //             'assets/images/freddy.jpg',
                  //             fit: BoxFit.cover,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          );
        }

        final percentageMiniPlayer = percentageFromValueInRange(
            min: kMiniPlayerHeight,
            max: screenHeight(context) * miniPlayerPercentageDeclaration +
                kMiniPlayerHeight,
            value: height);

        final elementOpacity = 1 - 1 * percentageMiniPlayer;
        final progressIndicatorHeight = 4 - 4 * percentageMiniPlayer;
        const progressIndicator = LinearProgressIndicator(value: 0.3);

        // Mini player
        return Neumorphic(
          style: const NeumorphicStyle(
            // color: NeumorphicTheme.baseColor(context),
            boxShape: NeumorphicBoxShape.rect(),
            depth: 0,
          ),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: kAppContentPadding),
                  child: Row(
                    children: [
                      Neumorphic(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                              maxHeight: 50.0, maxWidth: 50.0),
                          child: Padding(
                            padding: const EdgeInsets.all(kImagePadding / 2),
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
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Marquee(
                                child: Text(
                                  "BedRock",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  maxLines: 1,
                                ),
                              ),
                              Marquee(
                                child: Opacity(
                                  opacity: 0.6,
                                  child: Text(
                                    "Young Money",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // IconBtn(
                      //   icon: EvaIcons.playCircle,
                      //   label: 'Search',
                      //   onPressed: () {},
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Opacity(
                          opacity: 0.6,
                          child: Text(
                            "4:45",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ),
                      IconBtn(
                        icon: Icons.play_arrow_rounded,
                        label: 'Play',
                        color: NeumorphicTheme.accentColor(context),
                        iconColor: Colors.white,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 3,
                child: LinearProgressIndicator(
                  value: 0.3,
                  color: NeumorphicTheme.accentColor(context),
                  backgroundColor: NeumorphicTheme.defaultTextColor(context)
                      .withOpacity(0.4),
                ),
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
