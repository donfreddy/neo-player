import 'package:flutter/cupertino.dart';
import 'package:neo_player/src/player.dart';

import '../../presentation/pages/pages.dart';
import 'route_constants.dart';
import 'undefined_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  String? routeName = settings.name;
  // Object? args = settings.arguments;

  switch (routeName) {
    case initialRoute:
      return CupertinoPageRoute<Widget>(builder: (_) => const MainPage());
    case settingsRoute:
      return CupertinoPageRoute<Widget>(builder: (_) => const SettingsPage());
    case testRoute:
      return CupertinoPageRoute<Widget>(builder: (_) => const Player());
    default:
      return CupertinoPageRoute(builder: (_) => UndefinedPage(name: routeName));
  }
}
