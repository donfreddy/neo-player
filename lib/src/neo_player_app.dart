import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neo_player/src/presentation/bloc/settings/settings.dart';
import 'package:provider/provider.dart';

import 'common/routes/route.dart';
import 'common/constants/constants.dart';
import 'common/routes/route_constants.dart';
import 'common/shared/theme.dart';

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
      themeMode: context.watch<Settings>().themeMode,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      initialRoute: initialRoute,
      onGenerateRoute: generateRoute,
    );
  }
}
