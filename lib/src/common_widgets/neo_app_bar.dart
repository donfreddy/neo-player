import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../constants/constants.dart';
import '../pages/pages.dart';
import '../theme/style.dart';
import 'icon_btn.dart';

PreferredSizeWidget neoAppBar(BuildContext context,
    {required String title, VoidCallback? onTapSorting}) {
  final theme = Theme.of(context);
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
      actions: <Widget>[
        // IconBtn(
        //   icon: Icons.search_rounded,
        //   label: 'Search',
        //   onPressed: () {
        //     unImplementSnackBar(context);
        //   },
        // ),
        Visibility(
          visible: onTapSorting != null ? true : false,
          child: IconBtn(
            icon: Icons.sort_rounded,
            label: 'Sort',
            onPressed: onTapSorting,
          ),
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
