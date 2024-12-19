import 'package:agrolyn_web/provider/home_notifier.dart';
import 'package:agrolyn_web/utils/assets_path.dart';
import 'package:agrolyn_web/widget/navbar/navbar_mobile.dart';
import 'package:agrolyn_web/widget/navbar/navbar_desktop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (_) => HomeNotifier(context: context),
      child: Consumer<HomeNotifier>(
        builder: (context, value, child) {
          return Scaffold(
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      // Navbar Desktop
                      widthScreen > 700
                          ? const NavbarDesktop(
                              navbarActive: "beranda",
                            )
                          : Container(),
                      SizedBox(
                        height: widthScreen > 700
                            ? MediaQuery.of(context).size.height
                            : MediaQuery.of(context).size.height * 0.85,
                        child: const Column(
                          children: [
                            // mulai coding disini
                            Text('Homepage'),
                          ],
                        ),
                      ),

                      // Navbar Mobile
                      widthScreen <= 700
                          ? const NavbarMobile(
                              navbarActive: "beranda",
                            )
                          : Container(),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
// home, community, deteksi, recipe, edukasi
