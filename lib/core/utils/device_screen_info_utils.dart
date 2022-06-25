/*
device_screen_info_utils.dart
@author Sérgio Henrique D. de Oliveira
@version 1.0.17
*/

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

///////////////////////////////////////////////////////////////////
///
///
///
/// ## Screen Formulas
///
/// ARw = Aspect Ratio Width
/// ARh = Aspect Ratio Height
///
/// Screen Width = ARw × diagonal / √(ARw^2 + ARh^2)
/// Screen Height = ARh × diagonal / √(ARw^2 + ARh^2)
///
/// ////////////////////////////////////////////////////////////////

enum ScreenType { handset, tablet, desktop, watch }

enum ScreenSize { small, normal, large, hd, extraLarge, fHD, uHD4k, uHD8k }

enum Os { ios, android, windows, macos, linux, fuchsia, web }

/// Device Screen Info
///
/// Contains information about the device screen
/// Flutter uses the dimension of handset of 360x800
class DeviceScreenInfoUtils {
  /// Device Breakpoint DESKTOP
  static const double desktop = 1024;

  /// Device Breakpoint TABLET
  static const double tablet = 768;

  /// Device Breakpoint HANDSET
  static const double handset = 320;

  static const double uHD8k = 7680;
  static const double uHD4k = 3840; // UHD TV 60''
  static const double fHD = 1920; // desktop 27''
  static const double extraLarge = 1440; // laptop 17''
  static const double hd = 1280;
  static const double large = 1024; // tablet 9''
  static const double normal = 768; // phone 4''
  static const double small = 320; // watch 1''

  // Syntax sugar, proxy the Platform methods so our views can reference a single class
  static final bool isIOS = Platform.isIOS;
  static final bool isAndroid = Platform.isAndroid;
  static final bool isMacOS = Platform.isMacOS;
  static final bool isLinux = Platform.isLinux;
  static final bool isWindows = Platform.isWindows;
  static final bool isFuchsia = Platform.isFuchsia;
  //static const bool isWebview = kIsWeb;

  // Higher level device class abstractions (more syntax sugar for the views)
  static bool get isWeb => kIsWeb;
  static bool get isDesktop => isWindows || isMacOS || isLinux;
  static bool get isMobile => isAndroid || isIOS || isFuchsia;
  static bool get isDesktopOrWeb => isDesktop || isWeb;
  static bool get isMobileOrWeb => isMobile || isWeb;

  static Os getOs() {
    if (isAndroid) {
      return Os.android;
    }
    if (isLinux) {
      return Os.linux;
    }
    if (isIOS) {
      return Os.ios;
    }
    if (isMacOS) {
      return Os.macos;
    }
    if (isWindows) {
      return Os.windows;
    }
    if (isFuchsia) {
      return Os.fuchsia;
    }
    return Os.web;
  }

  String platformDescription() {
    if (kIsWeb) {
      return 'Web';
    } else if (Platform.isAndroid) {
      return 'Android';
    } else if (Platform.isIOS) {
      return 'iOS';
    } else if (Platform.isWindows) {
      return 'Windows';
    } else if (Platform.isMacOS) {
      return 'macOS';
    } else if (Platform.isLinux) {
      return 'Linux';
    } else if (Platform.isFuchsia) {
      return 'Fuchsia';
    } else {
      return 'Unknown';
    }
  }

  /// Get the type based on context
  static ScreenType getDeviceType(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.shortestSide;
    if (deviceWidth >= DeviceScreenInfoUtils.extraLarge) {
      return ScreenType.desktop;
    }
    if (deviceWidth >= DeviceScreenInfoUtils.tablet) return ScreenType.tablet;
    if (deviceWidth >= DeviceScreenInfoUtils.handset) return ScreenType.handset;
    return ScreenType.watch;
  }

  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Get the size based on context
  static ScreenSize getScreenSize(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    /// watch 1''
    if (deviceWidth <= DeviceScreenInfoUtils.small) {
      return ScreenSize.small;
    }

    /// phone 4''
    if (deviceWidth <= DeviceScreenInfoUtils.normal) {
      return ScreenSize.normal;
    }

    /// tablet 9''
    if (deviceWidth <= DeviceScreenInfoUtils.large) {
      return ScreenSize.large;
    }

    /// High Definition / laptop 17''
    if (deviceWidth <= DeviceScreenInfoUtils.hd) {
      return ScreenSize.hd;
    }

    /// desktop 27''
    if (deviceWidth <= DeviceScreenInfoUtils.extraLarge) {
      return ScreenSize.extraLarge;
    }

    /// TV Full HD
    if (deviceWidth <= DeviceScreenInfoUtils.fHD) {
      return ScreenSize.fHD;
    }

    /// TV Ultra HD 4K
    if (deviceWidth <= DeviceScreenInfoUtils.uHD4k) {
      return ScreenSize.uHD4k;
    }

    /// TV Ultra HD 8K or greater
    return ScreenSize.uHD8k;
  }
}
