import 'package:flutter/material.dart';

import '../../../controllers/settings_controller.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatefulWidget {
  const SettingsView({Key? key, required this.controller}) : super(key: key);

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          // Glue the SettingsController to the theme selection DropdownButton.
          //
          // When a user selects a theme from the dropdown list, the
          // SettingsController is updated, which rebuilds the MaterialApp.
          child: DropdownButton<ThemeMode>(
            // Read the selected themeMode from the controller
            value: widget.controller.themeMode,
            // Call the updateThemeMode method any time the user selects a theme.
            onChanged: widget.controller.updateThemeMode,
            items: [
              DropdownMenuItem(
                value: ThemeMode.system,
                child: Row(
                  children: const [
                    Icon(Icons.settings),
                    SizedBox(width: 8.0),
                    Text('System Theme'),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: ThemeMode.light,
                child: Row(
                  children: const [
                    Icon(Icons.light_mode),
                    SizedBox(width: 8.0),
                    Text('Light Theme'),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: ThemeMode.dark,
                child: Row(
                  children: const [
                    Icon(Icons.dark_mode),
                    SizedBox(width: 8.0),
                    Text('Dark Theme'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
