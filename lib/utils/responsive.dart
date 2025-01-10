import 'package:flutter/material.dart';

class Responsive {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 800;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 800 &&
        MediaQuery.of(context).size.width < 1200;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }

  static bool isDesktopLarge(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1440;
  }

  static double widthScreen(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double heightScreen(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
