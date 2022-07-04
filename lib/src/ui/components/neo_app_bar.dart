import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../constants/constants.dart';
import 'icon_btn.dart';

PreferredSizeWidget neoAppBar(BuildContext context, String title) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(100.0),
    child: NeumorphicAppBar(
      title: Text(
        title,
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
          icon: Icons.search_rounded,
          label: 'Search',
          onPressed: () {
            // Navigator.pushNamed(context, testRoute);
          },
        ),
        IconBtn(
          icon: Icons.settings_rounded,
          label: 'Settings',
          onPressed: () {
            // Navigator.pushNamed(context, settingsRoute);
          },
        )
      ],
    ),
  );
}
