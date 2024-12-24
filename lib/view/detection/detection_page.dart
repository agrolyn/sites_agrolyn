import 'package:agrolyn_web/provider/home_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetectionPage extends StatelessWidget {
  const DetectionPage({super.key});

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
                Column(
                  children: [
                    // // Navbar Desktop
                    // widthScreen > 700
                    //     ? const NavbarDesktop(
                    //         navbarActive: "beranda",
                    //       )
                    //     : Container(),
                    SizedBox(
                      height: widthScreen > 700
                          ? MediaQuery.of(context).size.height * 0.8
                          : MediaQuery.of(context).size.height * 0.85,
                      child: const SingleChildScrollView(
                          child: Column(
                        children: [
                          // mulai coding disini

                          Text('DetectionPage'),
                        ],
                      )),
                    ),

                    // // Navbar Mobile
                    // widthScreen <= 700
                    //     ? const NavbarMobile(
                    //         navbarActive: "beranda",
                    //       )
                    //     : Container(),
                  ],
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
