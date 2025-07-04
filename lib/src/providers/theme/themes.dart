import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class Themes {
  static Color lightColor = const Color(0xffededed);
  static Color darkColor = Colors.black;


  static final lightTheme = ThemeData(
      colorScheme: ColorScheme.light(
        onSurface: lightColor,
      ),
      // For light theming
      scaffoldBackgroundColor: Colors.grey.shade100,
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: Colors.black).copyWith(
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered) || states.contains(WidgetState.selected)) {
              return Colors.blue;
            }else {
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
              if (states.contains(WidgetState.hovered) || states.contains(WidgetState.selected)) {
                return Colors.blue;
              }else {
                return Colors.black;
              }
            }),
            backgroundColor: WidgetStateProperty.all(Colors.transparent),
            overlayColor: WidgetStateProperty.all(Colors.transparent),
          )
      ),
      listTileTheme: const ListTileThemeData(iconColor: Colors.black),
      dividerColor: darkColor,
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
            statusBarColor: Colors.transparent),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: lightColor,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black),
      textTheme: Typography.blackCupertino);

  static final darkTheme = ThemeData(
      colorScheme: ColorScheme.light(
          onSurface: darkColor
      ),
      // For dark theming
      scaffoldBackgroundColor: Colors.grey.shade900,
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: Colors.white).copyWith(
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered)) {
              return Colors.blue;
            }else {
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
              if (states.contains(WidgetState.hovered)) {
                return Colors.blue;
              }else {
                return Colors.white;
              }
            }),
            backgroundColor: WidgetStateProperty.all(Colors.transparent),
            overlayColor: WidgetStateProperty.all(Colors.transparent),
          )
      ),
      listTileTheme: const ListTileThemeData(iconColor: Colors.white),
      dividerColor: lightColor,
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
            statusBarColor: Colors.transparent),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: darkColor,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.white),
      textTheme: Typography.whiteCupertino);

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