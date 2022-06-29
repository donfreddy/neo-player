import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neo_player/src/common/routes/route_constants.dart';

import '../../components/icon_btn.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String currentName = 'Home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: NeumorphicAppBar(
          title: Text(
            currentName,
            style: TextStyle(
              fontFamily: 'Nunito',
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
          ]),
      //  drawer: const MainDrawer(),
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
