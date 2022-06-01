import 'package:flutter/material.dart';
import 'package:movieapp/core/themes/core_theme.dart';

class LightTheme implements CoreTheme {

  static getTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorSchemeSeed: Colors.lightBlue[900],
      fontFamily: CoreTheme.fontFamily,
    );
  }
}
