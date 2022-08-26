import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neo_player/src/pages/albums/albums_page.dart';
import 'package:neo_player/src/pages/artists/artists_page.dart';
import 'package:neo_player/src/pages/songs/songs_page.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../../../../locator.dart';
import '../../provider/settings_provider.dart';
import '../../provider/song_provider.dart';
import 'components/persistent_bottom_bar_scaffold.dart';

ValueNotifier<SongModel?> currentlyPlaying = ValueNotifier(null);

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final SongProvider songProvider = locator<SongProvider>();
  final _tab1navigatorKey = GlobalKey<NavigatorState>();
  final _tab2navigatorKey = GlobalKey<NavigatorState>();
  final _tab3navigatorKey = GlobalKey<NavigatorState>();
  final _tab4navigatorKey = GlobalKey<NavigatorState>();
  final _tab5navigatorKey = GlobalKey<NavigatorState>();

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
      child: PersistentBottomBarScaffold(
        items: [
          PersistentTabItem(
            tab: const SongsPage(),
            icon: Icons.music_note_outlined,
            activeIcon: Icons.music_note_rounded,
            navigatorKey: _tab3navigatorKey,
          ),
          PersistentTabItem(
            tab: const ArtistsPage(),
            icon: Icons.mic_none_outlined,
            activeIcon: Icons.mic,
            navigatorKey: _tab1navigatorKey,
            tooltip: 'Artists',
          ),
          PersistentTabItem(
            tab: const AlbumsPage(),
            icon: Icons.album_outlined,
            activeIcon: Icons.album_rounded,
            navigatorKey: _tab2navigatorKey,
          ),
          PersistentTabItem(
            tab: const Scaffold(body: Center(child: Text('Folders'))),
            icon: Icons.folder_outlined,
            activeIcon: Icons.folder_rounded,
            navigatorKey: _tab4navigatorKey,
          ),
          PersistentTabItem(
            tab: const Scaffold(body: Center(child: Text('Playlists'))),
            icon: Icons.playlist_play_outlined,
            activeIcon: Icons.playlist_play_rounded,
            navigatorKey: _tab5navigatorKey,
          )
        ],
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