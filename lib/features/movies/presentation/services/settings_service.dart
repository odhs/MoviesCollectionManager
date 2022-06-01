import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service that stores and retrieves user settings.
class SettingsService {
  static const _themeModeKey = 'theme_mode';

  /// Loads the User's preferred ThemeMode
  Future<ThemeMode> themeMode() async {
    var prefs = await SharedPreferences.getInstance();

    var themeModeValue = prefs.getInt(_themeModeKey);

    if (themeModeValue == null) {
      await updateThemeMode(ThemeMode.system);
    }

    themeModeValue = prefs.getInt(_themeModeKey);

    if (kDebugMode) {
      print('Theme loaded from cache' + themeMode.toString());
    }

    return ThemeMode.values.elementAt(themeModeValue!);
  }

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> updateThemeMode(ThemeMode theme) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt(_themeModeKey, theme.index);
    if (kDebugMode) {
      print('Theme saved in cache' + theme.toString());
    }
  }
}
