import 'package:flutter/material.dart';
import '/core/themes/core_theme.dart';

class DarkTheme extends CoreTheme {

  static getTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorSchemeSeed: Colors.lightBlue[900],
      fontFamily: CoreTheme.fontFamily,
    );
  }
}
