import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neo_player/src/ui/pages/pages.dart';

import '../../constants/constants.dart';
import '../theme/style.dart';
import 'icon_btn.dart';

PreferredSizeWidget neoAppBar(BuildContext context, String title) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(kAppBarHeight),
    child: AppBar(
      backgroundColor: NeumorphicTheme.baseColor(context),
      elevation: 0.0,
      title: Text(
        title,
        style: appBarTextStyle.copyWith(
            color: NeumorphicTheme.accentColor(context)),
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
          icon: Icons.settings_outlined,
          label: 'Menu',
          onPressed: () {
            // Navigator.pushNamed(context, settingsRoute);
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (_) => const SettingsPage()),
            );
          },
        ),
        const SizedBox(width: kAppContentPadding / 2),
      ],
    ),
  );
}
