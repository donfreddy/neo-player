import 'package:flutter/material.dart';
import 'package:neo_player/src/ui/theme/style.dart';

double valueFromPercentageInRange(
    {required final double min, max, percentage}) {
  return percentage * (max - min) + min;
}

double percentageFromValueInRange({required final double min, max, value}) {
  return (value - min) / (max - min);
}

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
