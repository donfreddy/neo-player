import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'undefined_page.dart';
import 'route_constants.dart';
import '../../presentation/pages/pages.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  String? routeName = settings.name;
  // Object? args = settings.arguments;

  switch (routeName) {
    case initialRoute:
      return CupertinoPageRoute<Widget>(builder: (_) => const MainPage());
    case settingsRoute:
      return CupertinoPageRoute<Widget>(builder: (_) => const SettingsPage());
    default:
      return CupertinoPageRoute(builder: (_) => UndefinedPage(name: routeName));
  }
}
