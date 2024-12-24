import 'package:agrolyn_web/provider/home_notifier.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
      create: (_) => HomeNotifier(context: context),
      child: Consumer<HomeNotifier>(builder: (context, value, child) {
        return Scaffold(
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    // // Navbar Desktop
                    // widthScreen > 700
                    //     ? const NavbarDesktop(navbarActive: "beranda")
                    //     : Container(),
                    SizedBox(
                      height: widthScreen > 700
                          ? MediaQuery.of(context).size.height
                          : MediaQuery.of(context).size.height * 0.85,
                      child: Column(
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                // Background Lottie Animation
                                Align(
                                  alignment: Alignment.center,
                                  child: Lottie.asset(
                                    ImageAssets.backgorundAnimation,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),
                                // Teks di atas Lottie Animation
                                Align(
                                  alignment: Alignment
                                      .center, // Posisikan teks di tengah
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'SELAMAT DATANG DI AGROLYN',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        'Solusi pertanian masa depan yang cerdas dan inovatif',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 40),
                                      // Tombol untuk berpindah ke halaman kedua
                                      InkWell(
                                        onTap: () {
                                          value.toggleSecondPageVisibility();
                                        },
                                        child: Container(
                                          height: 40,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.265,
                                          alignment: Alignment
                                              .center, // Posisikan teks di tengah
                                          decoration: BoxDecoration(
                                            color: MyColors
                                                .primaryColorDark, // Warna tombol
                                            borderRadius: BorderRadius.circular(
                                                8), // Sudut melengkung
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                offset: const Offset(0, 4),
                                                blurRadius: 8,
                                              ),
                                            ],
                                          ),
                                          child: const Text(
                                            "Ayo Mulai",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white, // Warna teks
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                              height:
                                  20), // Menambahkan jarak antara teks dan container bawah
                          Container(
                            height: 256,
                            width: double.infinity,
                            color: Colors.white, // Container putih di bawah
                            child: Center(
                              child: Text(
                                'Ini page ke dua',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // // Navbar Mobile
                    // widthScreen <= 700
                    //     ? const NavbarMobile(navbarActive: "beranda")
                    //     : Container(),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
