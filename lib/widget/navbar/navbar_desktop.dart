import 'dart:ui';

import 'package:agrolyn_web/utils/assets_path.dart';
import 'package:agrolyn_web/widget/navbar/item_navbar.dart';
import 'package:flutter/material.dart';

class NavbarDesktop extends StatelessWidget {
  final String navbarActive;
  const NavbarDesktop({super.key, required this.navbarActive});

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    return Positioned(
      left: 0,
      top: 0,
      right: 0,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
            padding: widthScreen > 950
                ? const EdgeInsets.symmetric(horizontal: 85, vertical: 16)
                : const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.6)),
            width: double.infinity,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 80,
              // decoration: const BoxDecoration(color: Colors.red),
              child: Row(
                children: [
                  MediaQuery.of(context).size.width > 950
                      ? Image.asset(
                          ImageAssets.logo,
                          width: 80,
                          height: 80,
                        )
                      : Container(),
                  const Spacer(),
                  Row(
                    children: [
                      ItemNavbar(
                        name: "Beranda",
                        iconName: Icons.home,
                        onClick: () {},
                        isActive: navbarActive == "beranda",
                      ),
                      const SizedBox(width: 10),
                      ItemNavbar(
                        name: "Komunitas",
                        iconName: Icons.forum,
                        onClick: () {},
                        isActive: navbarActive == "komunitas",
                      ),
                      const SizedBox(width: 10),
                      ItemNavbar(
                        name: "Deteksi",
                        iconName: Icons.camera_alt,
                        onClick: () {},
                        isActive: navbarActive == "deteksi",
                      ),
                      const SizedBox(width: 10),
                      ItemNavbar(
                        name: "Resep Olahan",
                        iconName: Icons.restaurant,
                        onClick: () {},
                        isActive: navbarActive == "resep",
                      ),
                      const SizedBox(width: 10),
                      ItemNavbar(
                        name: "Edukasi",
                        iconName: Icons.article,
                        onClick: () {},
                        isActive: navbarActive == "edukasi",
                      ),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
