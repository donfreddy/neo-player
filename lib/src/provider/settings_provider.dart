import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  final SharedPreferences prefs;

  SettingsProvider(this.prefs);

  // ---------------- THeme
  ThemeMode get themeMode {
    if (prefs.getBool('darkMode') == true) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }

  set themeMode(ThemeMode mode) => prefs
      .setBool('darkMode', mode != ThemeMode.light)
      .then((_) => notifyListeners());

  bool get isDarkMode => prefs.getBool('darkMode') == true;

  // ---------------- Accent Color
  int? get accentColor => prefs.getInt("AccentColor");

  set color(int color) =>
      prefs.setInt("AccentColor", color).then((value) => notifyListeners());
}

// Color color = new Color(0x12345678);
// String colorString = color.toString(); // Color(0x12345678)
// String valueString = colorString.split('(0x')[1].split(')')[0]; // kind of hacky..
// int value = int.parse(valueString, radix: 16);
// Color otherColor = new Color(value);
