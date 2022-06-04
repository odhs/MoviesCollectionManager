import 'dart:io' show Platform;
import 'package:flutter/material.dart';

enum ScreenType { handset, tablet, desktop, watch }

enum ScreenSize { small, normal, large, extraLarge }

/// Device Screen Info
///
/// Contains information about the device screen
class DeviceScreenInfoUtils {
  // device breakpointss
  static const double desktop = 900;
  static const double tablet = 600;
  static const double handset = 300;

  // Syntax sugar, proxy the Platform methods so our views can reference a single class
  static final bool isIOS = Platform.isIOS;
  static final bool isAndroid = Platform.isAndroid;
  static final bool isMacOS = Platform.isMacOS;
  static final bool isLinux = Platform.isLinux;
  static final bool isWindows = Platform.isWindows;

  // Higher level device class abstractions (more syntax sugar for the views)
  static final bool isWeb = !(isWindows || isMacOS || isLinux || isAndroid || isIOS);
  static bool get isDesktop => isWindows || isMacOS || isLinux;
  static bool get isMobile => isAndroid || isIOS;
  static bool get isDesktopOrWeb => isDesktop || isWeb;
  static bool get isMobileOrWeb => isMobile || isWeb;

  /// Get the type based on context
  ScreenType getFormFactor(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.shortestSide;
    if (deviceWidth > DeviceScreenInfoUtils.desktop) return ScreenType.desktop;
    if (deviceWidth > DeviceScreenInfoUtils.tablet) return ScreenType.tablet;
    if (deviceWidth > DeviceScreenInfoUtils.handset) return ScreenType.handset;
    return ScreenType.watch;
  }

  /// Get the size based on context
  ScreenSize getSize(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.shortestSide;
    if (deviceWidth > 900) return ScreenSize.extraLarge;
    if (deviceWidth > 600) return ScreenSize.large;
    if (deviceWidth > 300) return ScreenSize.normal;
    return ScreenSize.small;
  }
}