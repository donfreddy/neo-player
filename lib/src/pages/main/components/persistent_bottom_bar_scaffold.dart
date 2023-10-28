import 'package:flutter/services.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:neo_player/locator.dart';
import 'package:neo_player/src/pages/now_playing/neo_manager.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../helpers/common.dart';
import '../../../provider/settings_provider.dart';
import '../../../theme/theme.dart';
import '../../now_playing/now_playing.dart';

class PersistentBottomBarScaffold extends StatefulWidget {
  /// pass the required items for the tabs and BottomNavBar
  final List<PersistentTabItem> items;

  const PersistentBottomBarScaffold({Key? key, required this.items})
      : super(key: key);

  @override
  State<PersistentBottomBarScaffold> createState() =>
      _PersistentBottomBarScaffoldState();
}

class _PersistentBottomBarScaffoldState
    extends State<PersistentBottomBarScaffold> {
  int _selectedTab = 0;

  onChangeTap(int index) {
    if (index == _selectedTab) {
      widget.items[index].navigatorKey?.currentState
          ?.popUntil((route) => route.isFirst);
    }
    setState(() {
      _selectedTab = index;
    });
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
          // Check if current tab can be popped
          final NavigatorState? navigator =
              widget.items[_selectedTab].navigatorKey?.currentState;
          if (navigator?.canPop() ?? false) {
            navigator?.pop();
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              IndexedStack(
                index: _selectedTab,
                children: widget.items
                    .map((page) => Navigator(
                          key: page.navigatorKey,
                          onGenerateInitialRoutes: (navigator, initialRoute) {
                            return [
                              MaterialPageRoute(builder: (context) => page.tab)
                            ];
                          },
                        ))
                    .toList(),
              ),
              ValueListenableBuilder<MediaItem?>(
                valueListenable: locator<NeoManager>().currentSongNotifier,
                builder: (_, song, __) {
                  return song != null ? const NowPlaying() : Container();
                },
              ),
            ],
          ),
          bottomNavigationBar: ValueListenableBuilder<double>(
            valueListenable: playerExpandProgressNotifier,
            builder: (_, height, child) {
              final value = percentageFromValueInRange(
                  min: kPlayerMinHeight,
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
              onTap: onChangeTap,
              currentIndex: _selectedTab,
              items: widget.items
                  .map(
                    (item) => BottomNavBarItem(
                      icon: item.icon,
                      tooltip: item.tooltip,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  final List<BottomNavBarItem> items;
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
      elevation: 2,
      child: Neumorphic(
        style: NeumorphicStyle(
          color: NeumorphicTheme.baseColor(context),
          depth: 0,
          boxShape: const NeumorphicBoxShape.rect(),
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
    );
  }
}

/// Model class that holds the tab info for the [PersistentBottomBarScaffold]
class PersistentTabItem {
  final Widget tab;
  final GlobalKey<NavigatorState>? navigatorKey;
  final IconData icon;

  final String? tooltip;

  PersistentTabItem({
    required this.tab,
    this.navigatorKey,
    required this.icon,
    IconData? activeIcon,
    this.tooltip,
  });
}

class BottomNavBarItem {
  final IconData icon;
  final IconData activeIcon;
  final String? tooltip;

  BottomNavBarItem({
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

// https://github.com/right7ctrl/flutter_floating_bottom_navigation_bar/blob/master/lib/src/floating_navbar.dart
