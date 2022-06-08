import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/core/utils/device_screen_info_utils.dart';

import 'app.dart';
import 'core/inject/inject.dart';
import 'features/movies/presentation/controllers/settings_controller.dart';
import 'features/movies/presentation/services/settings_service.dart';

void main() async {
  // ensure that the application already loaded the widgets
  WidgetsFlutterBinding.ensureInitialized();

  // Dependence Injection Service Locator
  Inject.initialize();

  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Visual Density to provide touch or click depends on device
/*
  double densityAmt = touchMode ? 0.0 : -1.0;
  VisualDensity density =
  VisualDensity(horizontal: densityAmt, vertical: densityAmt);
*/

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.

//var os = getOs();

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

  if (DeviceScreenInfoUtils.isWindows) {
    doWhenWindowReady(() {
      const initialSize = Size(400, 800);
      appWindow.minSize = initialSize;
      appWindow.size = initialSize;
      appWindow.alignment = Alignment.center;
      appWindow.show();
    });
  }
}
