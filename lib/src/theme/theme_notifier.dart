import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:hive/hive.dart';

class ThemeNotifier extends ValueNotifier<ThemeMode> {
  ThemeNotifier(ThemeMode value) : super(value);

  ThemeMode get themeMode {
    if (Hive.box('settings').get('darkMode', defaultValue: true) as bool) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }

  set themeMode(ThemeMode mode) => Hive.box('settings')
      .put('darkMode', mode != ThemeMode.light)
      .then((_) => notifyListeners());
}

class AccentColorNotifier extends ValueNotifier<int> {
  AccentColorNotifier(int value) : super(value);

  int get accentColor =>
      Hive.box('settings').get('accentColor', defaultValue: 0xFFdd3f5d) as int;

  set accentColor(int color) => Hive.box('settings')
      .put('accentColor', color)
      .then((_) => notifyListeners());
}
