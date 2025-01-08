import 'package:flutter/material.dart';
import 'package:agrolyn_web/utils/responsive.dart';

class NavbarMobileItem extends StatelessWidget {
  String title, route;
  IconData icon;

  NavbarMobileItem({
    super.key,
    required this.title,
    required this.route,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title),
        leading: Icon(icon),
        style: ListTileStyle.drawer,
        onTap: () {
          Navigator.pushNamed(context, route);
        });
  }
}
