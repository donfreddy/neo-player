import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:neo_player/src/ui/pages/albums/albums_page.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../../../../locator.dart';
import '../../../constants/constants.dart';
import '../../../provider/settings_provider.dart';
import '../../../provider/song_provider.dart';
import '../../theme/theme.dart';
import '../now_playing/now_playing.dart';

const double kBottomNavBarHeight = 58;
const miniPlayerPercentageDeclaration = 0.1;

ValueNotifier<SongModel?> currentlyPlaying = ValueNotifier(null);

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  final SongProvider songProvider = locator<SongProvider>();

  String currentName = 'artists';
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    initSongs();
  }

  void initSongs() async {
    await songProvider.getSongs();
    await songProvider.getArtists();
    await songProvider.getAlbums();
    await songProvider.getAlbums();
    await songProvider.getGenres();
  }

  onChangePage(int index) {
    setState(() => {currentPage = index});
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: NeumorphicTheme.baseColor(context),
        systemNavigationBarIconBrightness:
            context.watch<SettingsProvider>().isDarkMode
                ? Brightness.light
                : Brightness.dark,
      ),
      child: MiniplayerWillPopScope(
        onWillPop: () async {
          final NavigatorState navigator = _navigatorKey.currentState!;
          if (!navigator.canPop()) return true;
          navigator.pop();

          return false;
        },
        child: Scaffold(
          key: scaffoldKey,
          body: Stack(
            children: <Widget>[
              Navigator(
                key: _navigatorKey,
                onGenerateRoute: (RouteSettings settings) => CupertinoPageRoute(
                  settings: settings,
                  builder: (BuildContext context) => const AlbumsPage(),
                ),
              ),
              ValueListenableBuilder(
                valueListenable: currentlyPlaying,
                builder: (context, SongModel? song, Widget? child) {
                  // return song != null ? const NowPlaying() : Container();
                  return const NowPlaying();
                },
              ),
            ],
          ),
          bottomNavigationBar: ValueListenableBuilder(
            valueListenable: playerExpandProgress,
            builder: (BuildContext context, double height, Widget? child) {
              final value = percentageFromValueInRange(
                  min: kMiniPlayerHeight,
                  max: screenHeight(context),
                  value: height);

              var opacity = 1 - value;
              if (opacity < 0) opacity = 0;
              if (opacity > 1) opacity = 1;

              return SizedBox(
                height: kBottomNavBarHeight - kBottomNavBarHeight * value,
                child: Transform.translate(
                  offset: Offset(0.0, kBottomNavBarHeight * value * 0.5),
                  child: Opacity(
                    opacity: opacity,
                    child: OverflowBox(
                      maxHeight: kBottomNavBarHeight,
                      child: child,
                    ),
                  ),
                ),
              );
            },
            child: BottomAppBar(
              notchMargin: 0,
              color: Colors.transparent,
              elevation: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Neumorphic(
                      style: NeumorphicStyle(
                        color: NeumorphicTheme.baseColor(context),
                        depth: 0,
                        boxShape: const NeumorphicBoxShape.rect(),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kAppContentPadding,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            BottomNaveItem(
                              icon: Icons.person_rounded,
                              currentIndex: currentPage,
                              index: 0,
                              isPressed: false,
                              isActive: true,
                              onPressed: onChangePage(0),
                            ),
                            BottomNaveItem(
                              icon: Icons.album_rounded,
                              currentIndex: currentPage,
                              index: 1,
                              onPressed: () {},
                            ),
                            BottomNaveItem(
                              icon: Icons.library_music_rounded,
                              currentIndex: currentPage,
                              index: 2,
                              onPressed: () {},
                            ),
                            BottomNaveItem(
                              icon: Icons.music_note_rounded,
                              currentIndex: currentPage,
                              index: 3,
                              onPressed: () {},
                            ),
                            BottomNaveItem(
                              icon: Icons.playlist_play_rounded,
                              currentIndex: currentPage,
                              index: 4,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNaveItem extends StatelessWidget {
  final IconData icon;
  final int currentIndex;
  final int index;
  final String? label;
  final bool isPressed;
  final bool isActive;
  final void Function()? onPressed;

  const BottomNaveItem({
    Key? key,
    required this.icon,
    this.label,
    this.isPressed = false,
    this.onPressed,
    this.isActive = false,
    required this.currentIndex,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isActiveTab = currentIndex == index;
    return Expanded(
      child: NeumorphicButton(
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        minDistance: 0.25,
        onPressed: () {},
        tooltip: label,
        drawSurfaceAboveChild: true,
        pressed: false,
        style: NeumorphicStyle(
          depth: isActiveTab ? -2 : 2,

          // color: isActiveTab ? NeumorphicTheme.accentColor(context) : null,
          shape: NeumorphicShape.flat,
          boxShape: const NeumorphicBoxShape.circle(),
        ),
        child: Icon(
          icon,
          size: 26.0,
          color: isActiveTab
              ? NeumorphicTheme.accentColor(context)
              : NeumorphicTheme.defaultTextColor(context),
        ),
      ),
    );
  }
}

double valueFromPercentageInRange(
    {required final double min, max, percentage}) {
  return percentage * (max - min) + min;
}

double percentageFromValueInRange({required final double min, max, value}) {
  return (value - min) / (max - min);
}

// https://github.com/right7ctrl/flutter_floating_bottom_navigation_bar/blob/master/lib/src/floating_navbar.dart
