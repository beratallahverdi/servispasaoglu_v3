import 'package:flutter/material.dart';

class ServisPasaogluConstants {
  static const bool production = true;
  static const String appName = "Servis Paşaoğlu";
  static const String appVersion = "1.0.0";
  static const String appBuild = "1";
  static const String appPackage = "com.servispasaoglu.app";
  static const String appIcon = "assets/images/icon.png";
  static const String appSplash = "assets/images/splash.png";
  static const String appLogo = "assets/images/logo.png";
  static const String appLogoDark = "assets/images/logo_dark.png";
  static const String appLogoUrl = "assets/images/logo_light.png";
  static const String baseUrl = "https://bayi.servispasaoglu.com.tr";
  static const String apiUrl =
      production ? "$baseUrl/api/v1" : "$devUrl:$devPort/api/v1";
  static const String devUrl = "http://192.168.1.100";
  static const String devPort = "8000";

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
}
