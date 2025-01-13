import 'package:agrolyn_web/service/auth_service.dart';
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
        ? Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/home");
                    },
                    child: Image.asset(
                      ImageAssets.logo,
                      width: 50,
                      height: 50,
                    ),
                  ),
                  IconButton(
                      style:
                          TextButton.styleFrom(foregroundColor: Colors.green),
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      })
                ]))
        : Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, "/home");
                  },
                  child: Image.asset(
                    ImageAssets.logo,
                    width: 50,
                    height: 50,
                  ),
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
                        title: "Olahan Pertanian",
                        route: "/olahan",
                        icon: Icons.restaurant,
                        activePage: activePage),
                    NavbarDesktopItem(
                        title: "Edukasi",
                        route: "/education",
                        icon: Icons.article,
                        activePage: activePage),
                  ],
                ),
                TextButton.icon(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Konfirmasi Keluar"),
                              content: const Text(
                                  "Apakah anda yakin ingin keluar dari agrolyn?"),
                              actions: [
                                TextButton(
                                  child: const Text("Batal"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text("Ya, Keluar!"),
                                  onPressed: () async {
                                    await AuthService().logout(context);
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    label: const Text("Keluar", style: TextStyle(fontSize: 18)),
                    icon: const Icon(Icons.logout))
              ],
            ));
  }
}
