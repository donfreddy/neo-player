import 'package:flutter/material.dart';
import 'package:neo_player/src/routes/route_constants.dart';
import 'package:neo_player/src/routes/undefined_page.dart';

import '../neo_player_app.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  String? routeName = settings.name;
  // Object? args = settings.arguments;

  switch (routeName) {
    case initialRoute:
      return MaterialPageRoute<Widget>(builder: (_) => const HomePage());
    default:
      return MaterialPageRoute(builder: (_) => UndefinedPage(name: routeName));
  }
}
