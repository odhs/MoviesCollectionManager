import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '/features/movies/presentation/ui/views/navigation_page.dart';
import '/features/movies/presentation/ui/views/pages/account_page.dart';
import '/features/movies/presentation/ui/views/pages/settings_view.dart';
import '/features/movies/presentation/controllers/settings_controller.dart';
import '/core/utils/device_screen_info_utils.dart';
import '/core/themes/dark_theme.dart';
import '/core/themes/light_theme.dart';

class AndroidApp extends StatelessWidget {
  const AndroidApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'main',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
            Locale('pt', 'BR'),
          ],

          /// Use AppLocalizations to configure the correct application title
          /// depending on the user's locale.
          ///
          /// The appTitle is defined in .arb files found in the localization
          /// directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          /// Define a light and dark color theme. Then, read the user's
          /// preferred ThemeMode (light, dark, or system default) from the
          /// SettingsController to display the correct theme.
          theme: LightTheme.getTheme(),
          darkTheme: DarkTheme.getTheme(),
          themeMode: settingsController.themeMode,

          /// Define a function to handle named routes in order to support
          /// Flutter web url navigation and deep linking.
          /// For first page default is "/", and NavigationPage has named as "/"
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                /// If the Title-Bar is supported define the name
                if (DeviceScreenInfoUtils.isDesktop) {
                  appWindow.title = AppLocalizations.of(context)!.appTitle;
                }
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return applyTheme(
                      context,
                      SettingsView(
                        controller: settingsController,
                      ),
                    );
                  case AccountPage.routeName:
                    return applyTheme(
                      context,
                      const AccountPage(),
                    );
                  case NavigationPage.routeName:
                  default:
                    return applyTheme(
                      context,
                      const NavigationPage(),
                    );
                }
              },
            );
          },
        );
      },
    );
  }

  /// Apply the theme overlay support in a scaffold widget
  applyTheme(BuildContext context, Widget widget) {
    return AnnotatedRegion(value: barTheme(context), child: widget);
  }

  /// Theme overlay to colors of the StatusBar and NavigationBar
  SystemUiOverlayStyle barTheme(BuildContext context) {
    return SystemUiOverlayStyle(
      // TOP: STATUS BAR
      statusBarColor: Theme.of(context).colorScheme.background,
      statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
      // BOTTOM: NAVIGATION BAR
      systemNavigationBarColor: Theme.of(context).colorScheme.onInverseSurface,
      systemNavigationBarIconBrightness:
          Theme.of(context).brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark,
    );
  }
}
