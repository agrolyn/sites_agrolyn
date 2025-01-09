import 'package:agrolyn_web/service/auth_service.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/utils/assets_path.dart';
import 'package:agrolyn_web/utils/responsive.dart';
import 'package:agrolyn_web/widget/navbar/navbar_mobile_item.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: MyColors.primaryColorDark,
                  ),
                  child: Center(
                    child: Column(children: [
                      Image.asset(
                        ImageAssets.logo,
                        width: 85,
                        height: 85,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Agrolyn",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    ]),
                  ),
                ),
                NavbarMobileItem(
                  title: "Beranda",
                  route: "/home",
                  icon: Icons.home,
                ),
                NavbarMobileItem(
                  title: "Komunitas",
                  route: "/community",
                  icon: Icons.forum,
                ),
                NavbarMobileItem(
                  title: "Deteksi",
                  route: "/detection",
                  icon: Icons.camera_alt_rounded,
                ),
                NavbarMobileItem(
                  title: "Olahan Makanan",
                  route: "/olahan",
                  icon: Icons.restaurant,
                ),
                NavbarMobileItem(
                  title: "Edukasi",
                  route: "/education",
                  icon: Icons.article,
                ),
                const Divider(),
                ListTile(
                    title: const Text("Keluar"),
                    leading: const Icon(Icons.logout),
                    style: ListTileStyle.drawer,
                    onTap: () {
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
                    }),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
