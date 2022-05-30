import 'package:flutter/material.dart';

class DarkTheme {
  static get() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorSchemeSeed: Colors.lightBlue[900],
    );
  }
}
