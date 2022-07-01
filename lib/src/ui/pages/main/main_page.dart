import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../provider/settings_provider.dart';
import '../../../routes/route_constants.dart';
import '../../components/icon_btn.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String currentName = 'Artists';
  int currentPage = 0;

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
      child: Scaffold(
        key: scaffoldKey,
        appBar: NeumorphicAppBar(
          title: Text(
            currentName,
            style: TextStyle(
              fontFamily: Constants.fontFamily,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: NeumorphicTheme.defaultTextColor(context),
            ),
          ),
          // centerTitle: true,
          actions: <Widget>[
            IconBtn(
              icon: EvaIcons.playCircle,
              label: 'Search',
              onPressed: () {
                Navigator.pushNamed(context, testRoute);
              },
            ),
            IconBtn(
              icon: EvaIcons.menuArrowOutline,
              label: 'Settings',
              onPressed: () {
                Navigator.pushNamed(context, settingsRoute);
              },
            )
          ],
        ),
        body: const Text("name"),
        bottomNavigationBar: BottomAppBar(
          notchMargin: 0,
          color: Colors.transparent,
          elevation: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Neumorphic(
                style: NeumorphicStyle(
                  color: NeumorphicTheme.baseColor(context),
                  boxShape: const NeumorphicBoxShape.rect(),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      BottomNaveItem(
                        icon: FontAwesomeIcons.user,
                        activeIcon: FontAwesomeIcons.solidUser,
                        currentIndex: currentPage,
                        index: 0,
                        isPressed: false,
                        isActive: true,
                        onPressed: onChangePage(0),
                      ),
                      BottomNaveItem(
                        icon: FontAwesomeIcons.music,
                        activeIcon: EvaIcons.person,
                        currentIndex: currentPage,
                        index: 1,
                        onPressed: () {},
                      ),
                      BottomNaveItem(
                        icon: EvaIcons.person,
                        activeIcon: EvaIcons.person,
                        currentIndex: currentPage,
                        index: 2,
                        onPressed: () {},
                      ),
                      BottomNaveItem(
                        icon: EvaIcons.settings2,
                        activeIcon: EvaIcons.person,
                        currentIndex: currentPage,
                        index: 3,
                        onPressed: () {},
                      ),
                      BottomNaveItem(
                        icon: EvaIcons.settings2,
                        activeIcon: EvaIcons.person,
                        currentIndex: currentPage,
                        index: 4,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNaveItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final int currentIndex;
  final int index;
  final EdgeInsets margin;
  final String? label;
  final bool isPressed;
  final bool isActive;
  final void Function()? onPressed;

  const BottomNaveItem({
    Key? key,
    required this.icon,
    required this.activeIcon,
    this.label,
    this.isPressed = false,
    this.onPressed,
    this.margin = const EdgeInsets.symmetric(horizontal: 6, vertical: 8.0),
    this.isActive = false,
    required this.currentIndex,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isActiveTab = currentIndex == index;
    return Expanded(
      child: NeumorphicButton(
        margin: margin,
        minDistance: 0.25,
        onPressed: isActiveTab ? null : () {},
        tooltip: label,
        drawSurfaceAboveChild: true,
        pressed: false,
        style: NeumorphicStyle(
          depth: isActiveTab ? -2 : 2,
          color: isActiveTab ? NeumorphicTheme.accentColor(context) : null,
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.roundRect(
            const BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
        child: FaIcon(
          isActiveTab ? activeIcon : icon,
          size: 22.0,
          color: isActiveTab
              ? Colors.white
              : NeumorphicTheme.defaultTextColor(context),
        ),
      ),
    );
  }
}

// https://github.com/right7ctrl/flutter_floating_bottom_navigation_bar/blob/master/lib/src/floating_navbar.dart
