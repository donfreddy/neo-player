import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neo_player/src/ui/pages/albums/albums_page.dart';
import 'package:neo_player/src/ui/pages/artists/artists_page.dart';
import 'package:neo_player/src/ui/pages/songs/songs_page.dart';
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

  final _screens = [
    const ArtistsPage(),
    const AlbumsPage(),
    const SongsPage(),
    const Scaffold(body: Center(child: Text('Genres'))),
    const Scaffold(body: Center(child: Text('Playlists'))),
  ];

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
      child: Scaffold(
        body: _screens[currentPage],
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
          child: BottomNavBar(
            onTap: onChangePage,
            currentIndex: currentPage,
            items: [
              BottomNavItem(
                icon: Icons.person_rounded,
                tooltip: 'Artists',
              ),
              BottomNavItem(
                icon: Icons.album_rounded,
                tooltip: 'Albums',
              ),
              BottomNavItem(
                icon: Icons.library_music_rounded,
                tooltip: 'Songs',
              ),
              BottomNavItem(
                icon: Icons.music_note_rounded,
                tooltip: 'Genre',
              ),
              BottomNavItem(
                icon: Icons.playlist_play_rounded,
                tooltip: 'Playlists',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  final List<BottomNavItem> items;
  final int currentIndex;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final String? tooltip;
  final bool isTapped;
  final bool isActive;
  final void Function(int val)? onTap;

  const BottomNavBar({
    Key? key,
    required this.items,
    this.tooltip,
    this.isTapped = false,
    this.onTap,
    this.isActive = false,
    required this.currentIndex,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
  })  : assert(items.length >= 2),
        assert(items.length <= 5),
        assert(0 <= currentIndex && currentIndex < items.length),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      notchMargin: 0,
      color: Colors.transparent,
      elevation: 0,
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
            children: items
                .asMap()
                .map((i, item) {
                  return MapEntry(
                    i,
                    BottomNaveItem(
                      currentIndex: currentIndex,
                      onTap: onTap,
                      backgroundColor: backgroundColor,
                      selectedItemColor: selectedItemColor,
                      unselectedItemColor: unselectedItemColor,
                      index: i,
                      icon: item.icon,
                    ),
                  );
                })
                .values
                .toList(),
          ),
        ),
      ),
    );
  }
}

class BottomNavItem {
  final IconData icon;
  final IconData activeIcon;
  final String? tooltip;

  BottomNavItem({
    required this.icon,
    IconData? activeIcon,
    this.tooltip,
  }) : activeIcon = activeIcon ?? icon;
}

class BottomNaveItem extends StatelessWidget {
  final IconData icon;
  final int index;
  final int currentIndex;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;

  // final bool selected;
  final String? tooltip;
  final void Function(int val)? onTap;

  const BottomNaveItem({
    Key? key,
    required this.icon,
    this.tooltip,
    this.onTap,
    // this.selected = false,
    required this.index,
    required this.currentIndex,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isActiveTab = currentIndex == index;
    return Expanded(
      child: NeumorphicButton(
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        minDistance: 0.25,
        onPressed: () => onTap!(index),
        tooltip: tooltip,
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
