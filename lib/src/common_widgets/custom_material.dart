import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import '../provider/settings_provider.dart';

class SimpleMaterial extends StatelessWidget {
  const SimpleMaterial({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: NeumorphicTheme.baseColor(context),
      child: child,
    );
  }
}

class MaterialWitchInkWell extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  final void Function()? onLongPress;

  const MaterialWitchInkWell({
    Key? key,
    required this.child,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark =
        context.watch<SettingsProvider>().themeMode == ThemeMode.dark;
    return Material(
      color: NeumorphicTheme.baseColor(context),
      child: InkWell(
        // borderRadius: BorderRadius.circular(kRadius),
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: isDark
            ? Colors.white.withOpacity(0.01)
            : theme.primaryColor.withOpacity(0.2),
        splashColor: isDark
            ? Colors.white.withOpacity(0.1)
            : theme.primaryColor.withOpacity(0.1),
        onTap: onTap,
        onLongPress: onLongPress,
        child: child,
      ),
    );
  }
}
