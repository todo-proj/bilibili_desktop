import 'package:bilibili_desktop/src/providers/theme/theme_state.dart';
import 'package:bilibili_desktop/src/utils/app_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themesProvider = NotifierProvider<ThemesProvider, ThemeState>(() {
  return ThemesProvider();
});

const _darkModeKey = "darkMode";

class ThemesProvider extends Notifier<ThemeState> {

  void changeTheme(bool isDark) {
    final mode = isDark ? ThemeMode.dark : ThemeMode.light;
    state = state.copyWith(mode: mode);
    AppStorage.setBool(_darkModeKey, isDark);
  }

  void toggleTheme() {
    changeTheme(!state.isDark);
  }

  @override
  ThemeState build() {
    final isDark = AppStorage.getBool(_darkModeKey, defaultValue: false);
    return ThemeState(mode: isDark? ThemeMode.dark : ThemeMode.light);
  }
}