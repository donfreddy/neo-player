import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  final SharedPreferences prefs;

  SettingsProvider(this.prefs);

  // ---------------- THeme ----------------
  ThemeMode get themeMode {
    // if (prefs.getBool('darkMode') == true) {
    //   return ThemeMode.dark;
    // } else {
    //   return ThemeMode.light;
    // }
    return ThemeMode.dark;
  }

  set themeMode(ThemeMode mode) => prefs
      .setBool('darkMode', mode != ThemeMode.light)
      .then((_) => notifyListeners());

  bool get isDarkMode => prefs.getBool('darkMode') == true;

  // ---------------- Accent Color ----------------
  int get accentColor =>
      prefs.getInt('accentColor') ?? 0xFF1DB854; // return default color if null

  set accentColor(int color) =>
      prefs.setInt('accentColor', color).then((_) => notifyListeners());

  bool get isDefaultAccentColor => prefs.getInt('accentColor') == 0xffdd3f5d;
}
