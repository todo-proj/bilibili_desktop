import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {

  static late SharedPreferencesWithCache _prefsWithCache;

  static init() async {
    _prefsWithCache = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        // When an allowlist is included, any keys that aren't included cannot be used.
        // allowList: <String>{'repeat', 'action'},
      ),
    );
  }

  static String getString(String key, {String defaultValue = ""}) {
    return _prefsWithCache.getString(key) ?? defaultValue;
  }

  static Future<void> setString(String key, String value) {
    return _prefsWithCache.setString(key, value);
  }

  static Future<void> setBool(String key, bool value) {
    return _prefsWithCache.setBool(key, value);
  }

  static bool getBool(String key, {bool defaultValue = false}) {
    return _prefsWithCache.getBool(key) ?? defaultValue;
  }

  static Future<void> setInt(String key, int value) {
    return _prefsWithCache.setInt(key, value);
  }

  static int getInt(String key, {int defaultValue = 0}) {
    return _prefsWithCache.getInt(key) ?? defaultValue;
  }
}