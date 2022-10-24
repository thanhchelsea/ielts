import 'package:flutter/material.dart';
import 'index.dart';

class AppThemes {
  ///Config ThemeData For LightMode
  static ThemeData lightTheme(BuildContext context) {
    final baseTheme = ThemeData.light();
    TextTheme textTheme = getTextTheme(baseTheme.textTheme);
    textTheme = textTheme.copyWith(
      subtitle1: textTheme.subtitle1!.copyWith(color: const Color(0xFF212633)),
      bodyText1: textTheme.bodyText1!.copyWith(color: const Color(0xFF59637E)),
    );
    return baseTheme.copyWith(
      textTheme: textTheme,
      primaryColor: const Color(0xFF3366FF),
      canvasColor: const Color(0xFFFFFFFF),
      buttonTheme: const ButtonThemeData(
        buttonColor: Color(0xFF3366FF),
      ),
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: Color(0xFF3366FF), foregroundColor: Colors.white),
      cardColor: Colors.white,
      toggleableActiveColor: const Color(0xFF3366FF),
      errorColor: Colors.redAccent,
      backgroundColor: Colors.white,
      primaryIconTheme: baseTheme.iconTheme.copyWith(
        color: const Color(0xFF9C9C9C),
      ),
      indicatorColor: const Color(0xFF565656),
      iconTheme: baseTheme.iconTheme.copyWith(
        color: Colors.black,
      ),
      scaffoldBackgroundColor: Colors.white,
      dividerTheme: const DividerThemeData(
        thickness: 1.0,
        color: Color(0xFFEAF0FD),
      ),
      dividerColor: const Color(0xFFEAF0FD),
      bottomAppBarColor: Colors.white,
      disabledColor: Colors.grey[400],
      elevatedButtonTheme: getElevatedButtonTheme(
        textTheme,
        primaryColor: Colors.white,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: getOutlinedButtonTheme(textTheme).style?.copyWith(
              textStyle: MaterialStateProperty.all(
                textTheme.caption?.copyWith(color: const Color(0xFF3366FF)),
              ),
              side: MaterialStateProperty.all(
                const BorderSide(color: Color(0xFF3366FF), width: 1),
              ),
            ),
      ),
      textButtonTheme: getTextButtonTheme(textTheme),
      tabBarTheme: baseTheme.tabBarTheme.copyWith(
        labelColor: const Color(0xFF3366FF),
        labelStyle: tabBarTextStyle(textTheme)?.copyWith(fontWeight: FontWeight.bold),
        unselectedLabelStyle: tabBarTextStyle(textTheme),
        unselectedLabelColor: const Color(0xFF8E9ABB),
        indicatorSize: TabBarIndicatorSize.tab,
      ),
      appBarTheme: AppBarTheme(
        color: baseTheme.cardColor,
        titleTextStyle: textTheme.subtitle2,
        iconTheme: const IconThemeData(color: Color(0xFF212633)),
      ),
      colorScheme: const ColorScheme.light().copyWith(
        secondary: const Color(0xFF8E9ABB),
        onSecondary: const Color(0xFF6AA4D2),
        background: const Color(0xFFEAEAF0),
        onPrimary: Colors.white,
        primary: const Color(0xFF3366FF),
        onBackground: const Color(0xFF0095DE),
        onSurface: Colors.black87,
        surface: const Color(0xFFEDEDED),
      ),
      cardTheme: baseTheme.cardTheme.copyWith(
        elevation: 0.0,
        shadowColor: const Color(0xFFEAF0FD),
      ),
    );
  }

  ///Config ThemeData For DarkMode
  static ThemeData darkTheme(BuildContext context) {
    final baseTheme = ThemeData.dark();
    TextTheme textTheme = getTextTheme(baseTheme.textTheme);
    return baseTheme.copyWith(
      textTheme: textTheme,
      dividerColor: const Color(0xFF353F4A),
      scaffoldBackgroundColor: const Color(0xFF2A3139),
      cardColor: const Color(0xFF1E252D),
      primaryColor: const Color(0xFF3366FF),
      backgroundColor: const Color(0xFF2A3139),
      buttonTheme: const ButtonThemeData(
        buttonColor: Color(0xFF3366FF),
      ),
      toggleableActiveColor: const Color(0xFF0095DE),
      bottomAppBarColor: const Color(0xFF171717),
      appBarTheme: AppBarTheme(
        color: const Color(0xFF171717),
        titleTextStyle: textTheme.subtitle2,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      elevatedButtonTheme: getElevatedButtonTheme(
        textTheme,
        primaryColor: const Color(0xFF3366FF),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: getOutlinedButtonTheme(textTheme).style?.copyWith(
              textStyle: MaterialStateProperty.all(
                textTheme.caption?.copyWith(color: const Color(0xFF3366FF)),
              ),
              side: MaterialStateProperty.all(
                const BorderSide(color: Color(0xFF3366FF), width: 1),
              ),
            ),
      ),
      textButtonTheme: getTextButtonTheme(textTheme),
      tabBarTheme: baseTheme.tabBarTheme.copyWith(
        labelColor: const Color(0xFFFFFFFF),
        unselectedLabelColor: const Color(0xFFB1B1B1),
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: tabBarTextStyle(textTheme)?.copyWith(fontWeight: FontWeight.bold),
        unselectedLabelStyle: tabBarTextStyle(textTheme),
      ),
      colorScheme: const ColorScheme.dark().copyWith(
        secondary: const Color(0xFF8A89A0),
        onSecondary: Colors.white,
        background: Colors.black,
        surface: const Color(0xFF121212),
        onBackground: Colors.grey,
        onPrimary: Colors.white,
      ),
      cardTheme: baseTheme.cardTheme.copyWith(elevation: 0.0),
    );
  }

  ThemeData getTheme(BuildContext context, bool isLight) {
    if (isLight) {
      return lightTheme(context);
    } else {
      return darkTheme(context);
    }
  }
}
