import 'package:agrolyn_web/utils/assets_path.dart';
import 'package:agrolyn_web/utils/responsive.dart';
import 'package:agrolyn_web/widget/navbar/navbar_desktop_item.dart';
import 'package:flutter/material.dart';

class NavbarDesktop extends StatelessWidget {
  String activePage;
  NavbarDesktop({super.key, required this.activePage});

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? Container()
        : Container(
            color: Colors.white,
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  ImageAssets.logo,
                  width: 50,
                  height: 50,
                ),
                Row(
                  children: [
                    NavbarDesktopItem(
                        title: "Beranda",
                        route: "/home",
                        icon: Icons.home,
                        activePage: activePage),
                    NavbarDesktopItem(
                        title: "Komunitas",
                        route: "/community",
                        icon: Icons.forum,
                        activePage: activePage),
                    NavbarDesktopItem(
                        title: "Deteksi",
                        route: "/detection",
                        icon: Icons.camera_alt_outlined,
                        activePage: activePage),
                    NavbarDesktopItem(
                        title: "Olahan Makanan",
                        route: "/olahan",
                        icon: Icons.restaurant,
                        activePage: activePage),
                    NavbarDesktopItem(
                        title: "Edukasi",
                        route: "/education",
                        icon: Icons.article,
                        activePage: activePage),
                    NavbarDesktopItem(
                        title: "Resep",
                        route: "/recipe",
                        icon: Icons.emoji_food_beverage,
                        activePage: activePage),
                  ],
                ),
                TextButton.icon(
                    onPressed: () {},
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    label: const Text("Keluar", style: TextStyle(fontSize: 18)),
                    icon: const Icon(Icons.logout))
              ],
            ));
  }
}
