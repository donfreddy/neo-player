import 'package:flutter/cupertino.dart';
import 'package:neo_player/src/pages/pages.dart';
import 'package:neo_player/src/player2.dart';

import 'route_constants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  String? routeName = settings.name;
  Object? args = settings.arguments;

  switch (routeName) {
    case loadingRoute:
      return CupertinoPageRoute<Widget>(builder: (_) => const LoadingPage());
    case mainRoute:
      return CupertinoPageRoute<Widget>(builder: (_) => const MainPage());
    case settingsRoute:
      return CupertinoPageRoute<Widget>(builder: (_) => const SettingsPage());
    case storagePermissionRoute:
      return CupertinoPageRoute<Widget>(
        builder: (_) => StoragePermissionPage(isPermanent: args as bool),
      );
    case notFoundSongRoute:
      return CupertinoPageRoute<Widget>(
          builder: (_) => const NotFoundSongPage());
    case testRoute:
      return CupertinoPageRoute<Widget>(builder: (_) => const Player2());
    default:
      return CupertinoPageRoute(builder: (_) => UndefinedPage(name: routeName));
  }
}

Route<dynamic> generateMainRoute(RouteSettings settings) {
  String? routeName = settings.name;
  Object? args = settings.arguments;

  switch (routeName) {
    case loadingRoute:
      return CupertinoPageRoute<Widget>(builder: (_) => const LoadingPage());
    case mainRoute:
      return CupertinoPageRoute<Widget>(builder: (_) => const MainPage());
    case settingsRoute:
    // return CupertinoPageRoute<Widget>(
    //   builder: (_) => const SettingsPage(),
    // //   maintainState: ,
    //   fullscreenDialog: true,
    // );
    case storagePermissionRoute:
      return CupertinoPageRoute<Widget>(
        builder: (_) => StoragePermissionPage(isPermanent: args as bool),
      );
    case notFoundSongRoute:
      return CupertinoPageRoute<Widget>(
          builder: (_) => const NotFoundSongPage());
    case testRoute:
      return CupertinoPageRoute<Widget>(builder: (_) => const Player2());
    default:
      return CupertinoPageRoute(builder: (_) => UndefinedPage(name: routeName));
  }
}
