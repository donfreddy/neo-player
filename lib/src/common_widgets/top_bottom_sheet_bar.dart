import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neo_player/src/constants/constants.dart';
import 'package:neo_player/src/theme/style.dart';
import 'package:provider/provider.dart';

import '../provider/settings_provider.dart';

class TopBottomSheetBar extends StatelessWidget {
  const TopBottomSheetBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();
    return Center(
      child: Container(
        height: 4.5,
        width: 45,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: settingsProvider.themeMode == ThemeMode.dark
              ? textGrayColor
              : textGrayColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(kRadius),
        ),
      ),
    );
  }
}
