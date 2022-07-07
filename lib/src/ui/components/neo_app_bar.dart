import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neo_player/src/ui/pages/pages.dart';

import 'icon_btn.dart';

PreferredSizeWidget neoAppBar(BuildContext context, String title) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(90.0),
    child: NeumorphicAppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: NeumorphicTheme.accentColor(context),
              fontSize: 26.0,
              fontWeight: FontWeight.w700,
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
          icon: Icons.more_horiz_rounded,
          label: 'Menu',
          onPressed: () {
            // Navigator.pushNamed(context, settingsRoute);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            );
          },
        )
      ],
    ),
  );
}
