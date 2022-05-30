import 'package:flutter/material.dart';

class LightTheme {
  static get() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorSchemeSeed: Colors.lightBlue[900],
    );
  }
}