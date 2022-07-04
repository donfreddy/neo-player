import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../../constants/constants.dart';
import '../../../routes/route_constants.dart';
import '../../components/icon_btn.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: Text(
          "artists",
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
            icon: Icons.abc_outlined,
            label: 'Search',
            onPressed: () {
              Navigator.pushNamed(context, testRoute);
            },
          ),
          IconBtn(
            icon: Icons.face,
            label: 'Settings',
            onPressed: () {
              Navigator.pushNamed(context, settingsRoute);
            },
          )
        ],
      ),
      body: Center(
        child: NeumorphicButton(
            onPressed: () {
              Navigator.pushNamed(context, notFoundSongRoute);
            },
            child: const Text("Home page")),
      ),
    );
  }
}
