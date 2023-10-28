import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import '../../../../provider/settings_provider.dart';
import '../../../theme/theme.dart';

class Divider extends StatelessWidget {
  const Divider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context),
      color: context.watch<SettingsProvider>().themeMode == ThemeMode.dark
          ? Colors.white.withOpacity(0.040)
          : Colors.black.withOpacity(0.040),
      height: 1,
    );
  }
}
