import 'package:flutter/material.dart';
import 'package:agrolyn_web/utils/responsive.dart';

class NavbarDesktopItem extends StatelessWidget {
  String title, route;
  IconData icon;
  String activePage;

  NavbarDesktopItem(
      {super.key,
      required this.title,
      required this.route,
      required this.icon,
      required this.activePage});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        iconAlignment: IconAlignment.start,
        style: ButtonStyle(
          padding:
              WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(
                  horizontal: Responsive.isTablet(context)
                      ? 16
                      : Responsive.isDesktop(context)
                          ? 18
                          : 20,
                  vertical: Responsive.isTablet(context)
                      ? 16
                      : Responsive.isDesktop(context)
                          ? 18
                          : 20)),
          foregroundColor: activePage == title
              ? WidgetStateProperty.all<Color>(Colors.white)
              : WidgetStateProperty.all<Color>(Colors.black),
          backgroundColor: activePage == title
              ? WidgetStateProperty.all<Color>(Colors.green)
              : WidgetStateProperty.all<Color>(Colors.transparent),
        ),
        icon: Icon(
          icon,
          size: Responsive.isTablet(context)
              ? 16
              : Responsive.isDesktop(context)
                  ? 18
                  : 20,
        ),
        onPressed: () {
          Navigator.pushNamed(
            context,
            route,
          );
        },
        label: Text(title,
            style: TextStyle(
                fontSize: Responsive.isTablet(context)
                    ? 16
                    : Responsive.isDesktop(context)
                        ? 18
                        : 20)));
  }
}
