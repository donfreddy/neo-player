import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neo_player/src/provider/settings_provider.dart';
import 'package:neo_player/src/routes/route.dart';
import 'package:neo_player/src/routes/route_constants.dart';
import 'package:neo_player/src/theme/theme.dart';
import 'package:provider/provider.dart';

import 'constants/constants.dart';


class NeoPlayerApp extends StatelessWidget {
  const NeoPlayerApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: Constants.appName,
      themeMode: context.watch<SettingsProvider>().themeMode,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      initialRoute: loadingRoute,
      onGenerateRoute: generateRoute,
    );
  }
}
