import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neo_player/src/ui/theme/style.dart';

import '../../constants/constants.dart';

//--------------------------- Neo Player Theme -------------------------------

NeumorphicThemeData lightTheme(int accentColor) {
  return NeumorphicThemeData(
    defaultTextColor: lightTextColor,
    baseColor: lightBgColor,
    accentColor: Color(accentColor),
    variantColor: Color(accentColor),
    intensity: 0.8,
    lightSource: LightSource.topLeft,
    depth: 2,
    textTheme: textTheme(ThemeData.light().textTheme, lightTextColor),
    iconTheme: _customIconTheme(ThemeData.light().iconTheme, lightTextColor),
    shadowDarkColor: const Color(0xFFA3B1C6),
    shadowLightColor: Colors.white,
  );
}

NeumorphicThemeData darkTheme(int accentColor) {
  final darkTextColor = Colors.white.withOpacity(0.8);
  return NeumorphicThemeData(
    defaultTextColor: darkTextColor,
    baseColor: darkBgColor,
    accentColor: Color(accentColor),
    variantColor: Color(accentColor),
    intensity: 0.8,
    lightSource: LightSource.topLeft,
    shadowDarkColor: Colors.black87,
    shadowLightColor: whiteColor.withOpacity(0.5),
    depth: 2,
    iconTheme: _customIconTheme(ThemeData.dark().iconTheme, darkTextColor),
    textTheme: textTheme(ThemeData.dark().textTheme, darkTextColor),
  );
}

IconThemeData _customIconTheme(IconThemeData original, Color color) {
  return original.copyWith(color: color);
}

//--------------------------- screen height & width ----------------------------

double screenHeight(context) {
  return MediaQuery.of(context).size.height;
}

double screenWidth(context) {
  return MediaQuery.of(context).size.width;
}

//----------------------------- Text theme -------------------------------------

TextTheme textTheme(TextTheme mode, Color color) {
  return mode
      .copyWith(
        headline1: mode.headline1?.copyWith(
          fontWeight: FontWeight.w300,
          fontSize: 96.0,
        ),
        headline2: mode.headline2?.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 60.0,
        ),
        headline3: mode.headline3?.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 48.0,
        ),
        headline4: mode.headline4?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 34.0,
        ),
        headline5: mode.headline5?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 24.0,
        ),
        headline6: mode.headline6?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 20.0,
        ),
        subtitle1: mode.subtitle1?.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 16.0,
        ),
        subtitle2: mode.subtitle2?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 15.0,
        ),
        bodyText1: mode.bodyText1?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 14.0,
        ),
        bodyText2: mode.bodyText2?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 12.0,
        ),
        button: mode.button?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 14.0,
        ),
        caption: mode.caption?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 10.0,
        ),
        overline: mode.overline?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 10.0,
        ),
      )
      .apply(
        fontFamily: Constants.fontFamily,
        displayColor: color,
        bodyColor: color,
        fontSizeFactor: 1.0,
      );
}
