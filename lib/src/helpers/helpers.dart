import 'package:flutter/material.dart';
import 'package:neo_player/src/ui/theme/style.dart';

void showSnackBar(BuildContext context, String message) {
  final theme = Theme.of(context);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: theme.primaryColor,
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        style: theme.textTheme.titleSmall!.copyWith(color: textWhiteColor),
      ),
    ),
  );
}

void unImplementSnackBar(BuildContext context) {
  final theme = Theme.of(context);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: theme.primaryColor,
      behavior: SnackBarBehavior.floating,
      content: Text(
        'We are working on it! 😊, It will be available soon. Thanks for your patience!',
        style: theme.textTheme.titleSmall!.copyWith(color: textWhiteColor),
      ),
    ),
  );
}
