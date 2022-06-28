import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import '../../../../common/shared/theme.dart';
import '../../../bloc/settings/settings.dart';

class Divider extends StatelessWidget {
  const Divider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context),
      color: context.watch<Settings>().themeMode == ThemeMode.dark
          ? Colors.white.withOpacity(0.040)
          : Colors.black.withOpacity(0.040),
      height: 1,
    );
  }
}
