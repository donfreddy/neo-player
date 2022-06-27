import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neo_player/src/constants/constants.dart';
import 'package:neo_player/src/routes/route.dart';
import 'package:neo_player/src/routes/route_constants.dart';

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
      theme: const NeumorphicThemeData(
        baseColor: Colors.blue,
      ),
      initialRoute: initialRoute,
      onGenerateRoute: generateRoute,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: NeumorphicButton(
          padding: const EdgeInsets.all(10.0),
          onPressed: () => {},
          child: const Text('home page'),
        ),
      ),
    );
  }
}
