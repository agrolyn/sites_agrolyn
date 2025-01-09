import 'package:agrolyn_web/provider/menu_notifier.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/utils/assets_path.dart';
import 'package:agrolyn_web/utils/responsive.dart';
import 'package:agrolyn_web/widget/navbar/navbar_desktop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrolyn_web/widget/navbar/navbar_mobile_item.dart';

class NavbarWrapper extends StatelessWidget {
  String activePage;
  Widget child;
  NavbarWrapper({super.key, required this.child, required this.activePage});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MenuNotifier(context: context),
      child: Consumer<MenuNotifier>(
        builder: (context, value, child) {
          return Scaffold(
            key: value.scaffoldKey,
            backgroundColor: Colors.white,
            drawer: Responsive.isMobile(context)
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
                      ],
                    ),
                  )
                : null,
            body: Column(
              children: [
                NavbarDesktop(
                  activePage: activePage,
                ),
                Expanded(
                  child: child!,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
