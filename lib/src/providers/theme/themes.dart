import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'extension/app_color.dart';

class Themes {
  static Color lightColor = Colors.white;
  static Color darkColor = const Color(0xFF17181A);

  static final lightTheme = ThemeData(
    extensions: [
      const AppColor(
        refreshButtonColor: Colors.white,
        refreshButtonHoverColor: Colors.grey,
        hoverColor: Color(0XFFC7356A),
      ),
    ],
    colorScheme: ColorScheme.light(surface: lightColor, onSurface: darkColor, surfaceContainer: Color(0xFFEDEDED)),
    // For light theming
    scaffoldBackgroundColor: lightColor,
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(foregroundColor: Colors.black).copyWith(
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.selected)) {
            return Colors.blue;
          } else {
            return Colors.black;
          }
        }),
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.selected)) {
            return Colors.blue;
          } else {
            return Colors.black;
          }
        }),
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
      ),
    ),
    listTileTheme: const ListTileThemeData(iconColor: Colors.black),
    dividerColor: darkColor,
    tabBarTheme: TabBarThemeData(
      unselectedLabelStyle: TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      labelStyle: TextStyle(
        fontSize: 16,
        color: Colors.pink,
        fontWeight: FontWeight.bold,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: lightColor,
      titleTextStyle: const TextStyle(color: Colors.black, fontSize: 18),
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.black),
      toolbarTextStyle: const TextStyle(color: Colors.black),
      systemOverlayStyle: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: lightColor,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.black,
    ),
    textTheme: Typography.blackCupertino,
  );

  static final darkTheme = ThemeData(
    extensions: [
      AppColor(
        refreshButtonColor: Colors.grey,
        refreshButtonHoverColor: Colors.grey.withValues(alpha: 0.5),
        hoverColor: Color(0XFFC7356A),
      ),
    ],
    colorScheme: ColorScheme.light(surface: darkColor, onSurface: lightColor, surfaceContainer: Color(0xFF1E2022)),
    // For dark theming
    scaffoldBackgroundColor: darkColor,
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(foregroundColor: Colors.white).copyWith(
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.selected)) {
            return Colors.blue;
          } else {
            return Colors.white;
          }
        }),
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.selected)) {
            return Colors.blue;
          } else {
            return Colors.white;
          }
        }),
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
      ),
    ),
    listTileTheme: const ListTileThemeData(iconColor: Colors.white),
    dividerColor: lightColor,
    tabBarTheme: TabBarThemeData(
      unselectedLabelStyle: TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      labelStyle: TextStyle(
        fontSize: 16,
        color: Colors.pink,
        fontWeight: FontWeight.bold,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: darkColor,
      titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      toolbarTextStyle: const TextStyle(color: Colors.white),
      systemOverlayStyle: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: darkColor,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.white,
    ),
    textTheme: Typography.whiteCupertino,
  );

  static SystemUiOverlayStyle getSystemUIOverlayStyle(bool isDark) {
    if (isDark) {
      return darkTheme.appBarTheme.systemOverlayStyle!;
    } else {
      return lightTheme.appBarTheme.systemOverlayStyle!;
    }
  }

  static Color getBackgroundColor(bool isDark) {
    if (isDark) {
      return darkColor;
    } else {
      return lightColor;
    }
  }
}
