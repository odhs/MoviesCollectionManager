import 'dart:io' show Platform;
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'core/inject/inject.dart';
import 'features/movies/presentation/controllers/settings_controller.dart';
import 'features/movies/presentation/services/settings_service.dart';

void main() async {
  // ensure that the application already loaded the widgets
  WidgetsFlutterBinding.ensureInitialized();

// Visual Density to provide touch or click depends on device
/*
  double densityAmt = touchMode ? 0.0 : -1.0;
  VisualDensity density =
  VisualDensity(horizontal: densityAmt, vertical: densityAmt);
*/

  // Windows OS minimal size
  //Size size = await DesktopWindow.getWindowSize();
  //DesktopWindow.setWindowSize(Size(800,600));
  //DesktopWindow.setFullScreen(true);
  if (Platform.isWindows) {
    DesktopWindow.setWindowSize(const Size(400, 800));
    DesktopWindow.setMinWindowSize(const Size(400, 800));
  }

  // Dependence Injection Service Locator
  Inject.initialize();

  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.

// FUTURE
/*
  if (kIsWeb) {
    runApp(AndroidApp(settingsController: settingsController));
  } else {
    if (Platform.isAndroid) {
      runApp(AndroidApp(settingsController: settingsController));
    } else if (Platform.isIOS) {
      runApp(AndroidApp(settingsController: settingsController));
    } else if (Platform.isFuchsia) {
      runApp(AndroidApp(settingsController: settingsController));
    } else if (Platform.isLinux) {
      runApp(AndroidApp(settingsController: settingsController));
    } else if (Platform.isMacOS) {
      runApp(AndroidApp(settingsController: settingsController));
    } else if (Platform.isWindows) {
      runApp(AndroidApp(settingsController: settingsController));
    }
  }
  */
  runApp(AndroidApp(settingsController: settingsController));
}
