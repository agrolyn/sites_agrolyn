import 'dart:ui';

import 'package:agrolyn_web/utils/assets_path.dart';
import 'package:agrolyn_web/widget/navbar/item_navbar.dart';
import 'package:agrolyn_web/widget/navbar/item_navbar_mobile.dart';
import 'package:flutter/material.dart';

class NavbarMobile extends StatelessWidget {
  final String navbarActive;
  const NavbarMobile({super.key, required this.navbarActive});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1), // Semi-transparent color
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: Colors.green.withOpacity(0.4), // Border color
                width: 1.5,
              ),
            ),
            width: MediaQuery.of(context).size.width - 10,
            child: Row(
              children: [
                ItemNavbarMobile(
                  name: "Beranda",
                  iconName: Icons.home,
                  onClick: () {},
                  isActive: navbarActive == "beranda",
                ),
                const Spacer(),
                ItemNavbarMobile(
                    name: "Komunitas",
                    iconName: Icons.forum,
                    onClick: () {},
                    isActive: navbarActive == "komunitas"),
                const Spacer(),
                ItemNavbarMobile(
                    name: "Deteksi",
                    iconName: Icons.camera_alt,
                    onClick: () {},
                    isActive: navbarActive == "deteksi"),
                const Spacer(),
                ItemNavbarMobile(
                    name: "Resep Olahan",
                    iconName: Icons.restaurant,
                    onClick: () {},
                    isActive: navbarActive == "resep"),
                const Spacer(),
                ItemNavbarMobile(
                    name: "Edukasi",
                    iconName: Icons.article,
                    onClick: () {},
                    isActive: navbarActive == "edukasi"),
              ],
            )),
      ),
    );
  }
}
