import 'dart:developer';

import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class ShowSnackBar {
  void showSnackBar(
    BuildContext context,
    String title, {
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 1),
    bool noAction = false,
  }) {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: duration,
          elevation: 6,
          backgroundColor: NeumorphicTheme.baseColor(context),
          behavior: SnackBarBehavior.floating,
          content: Text(
            title,
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          action: noAction
              ? null
              : action ??
                  SnackBarAction(
                    textColor: NeumorphicTheme.accentColor(context),
                    label: "Ok",
                    onPressed: () {},
                  ),
        ),
      );
    } catch (e) {
      log('Failed to show Snack bar with title:$title');
    }
  }
}
