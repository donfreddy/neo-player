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
        PopupMenuButton(
            // add icon, by default "3 dot" icon
            // icon: Icon(Icons.book)
            itemBuilder: (context) {
          return [
            const PopupMenuItem<int>(
              value: 0,
              child: Text("My Account"),
            ),
            const PopupMenuItem<int>(
              value: 1,
              child: Text("Settings"),
            ),
            const PopupMenuItem<int>(
              value: 2,
              child: Text("Logout"),
            ),
          ];
        }, onSelected: (value) {
          if (value == 0) {
            print("My account menu is selected.");
          } else if (value == 1) {
            print("Settings menu is selected.");
          } else if (value == 2) {
            print("Logout menu is selected.");
          }
        }),
        IconBtn(
          icon: Icons.sort_rounded,
          label: 'Sort',
          onPressed: () {},
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
