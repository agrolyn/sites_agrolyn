import 'dart:ui';

import 'package:agrolyn_web/provider/detection_notifier.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/utils/assets_path.dart';
import 'package:agrolyn_web/utils/responsive.dart';
import 'package:agrolyn_web/view/chatbot/chatbot.dart';
import 'package:agrolyn_web/view/detection/card_scan_type.dart';
import 'package:agrolyn_web/view/detection/history_scan_screen.dart';
import 'package:agrolyn_web/widget/footer.dart';
import 'package:agrolyn_web/widget/navbar/nav_drawer.dart';
import 'package:agrolyn_web/widget/navbar/navbar_desktop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetectionScreen extends StatelessWidget {
  const DetectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    void showPopup(BuildContext context) {
      showDialog(
        context: context,
        barrierColor: Colors.black54, // Latar belakang semi-transparan
        builder: (context) {
          final isMobile =
              MediaQuery.of(context).size.width < 600; // Deteksi mobile
          return Stack(
            children: [
              Align(
                alignment: Alignment.bottomRight, // Posisi di bawah kanan
                child: Container(
                  width: isMobile
                      ? MediaQuery.of(context).size.width *
                          0.9 // Hampir penuh pada mobile
                      : 400, // Lebar tetap untuk desktop/tablet
                  height: isMobile
                      ? MediaQuery.of(context).size.height *
                          0.8 // Hampir penuh pada mobile
                      : 550, // Tinggi tetap untuk desktop/tablet
                  margin: const EdgeInsets.only(
                    bottom: 80, // Jarak dari bawah (di atas FAB)
                    right: 16, // Jarak dari tepi kanan
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white, // Warna latar popup
                    borderRadius:
                        BorderRadius.circular(12), // Membulatkan sudut
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26, // Warna bayangan
                        blurRadius: 10, // Intensitas blur bayangan
                        offset: Offset(0, 4), // Posisi bayangan
                      ),
                    ],
                  ),
                  child: const Chatbot(),
                ),
              ),
            ],
          );
        },
      );
    }

    return ChangeNotifierProvider(
      create: (_) => DetectionNotifier(context: context),
      child: Consumer<DetectionNotifier>(
        builder: (context, value, child) => Scaffold(
          backgroundColor: Colors.white,
          key: scaffoldKey,
          floatingActionButton: FloatingActionButton(
            onPressed: () => showPopup(context),
            backgroundColor: MyColors.secondaryColorDark, // Memanggil popup
            child: const Icon(
              Icons.smart_toy,
              color: Colors.white,
            ),
          ),
          drawer: const NavDrawer(),
          body: SafeArea(
              bottom: false,
              child: SingleChildScrollView(
                child: Column(children: [
                  NavbarDesktop(
                    activePage: "Deteksi",
                  ),
                  Container(
                    width: widthScreen,
                    height: Responsive.isMobile(context)
                        ? 350
                        : Responsive.heightScreen(context) * 0.92,
                    decoration: const BoxDecoration(
                      color: MyColors.primaryColorDark,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Image.asset(
                          ImageAssets.bgDetect,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                                child: Container(
                                  width: Responsive.isMobile(context)
                                      ? widthScreen * 0.7
                                      : widthScreen * 0.5,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(
                                        0.5), // Semi-transparent color
                                    borderRadius: BorderRadius.circular(20.0),
                                    border: Border.all(
                                      color: Colors.white
                                          .withOpacity(0.4), // Border color
                                      width: 1.5,
                                    ),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: Responsive.isMobile(context)
                                              ? 20
                                              : 28,
                                          horizontal:
                                              Responsive.isMobile(context)
                                                  ? 20
                                                  : 28),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            ImageAssets.logo,
                                            width: 100,
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            "Deteksi Penyakit Tanaman",
                                            style: TextStyle(
                                              fontSize:
                                                  Responsive.isMobile(context)
                                                      ? 18
                                                      : 24,
                                              fontWeight: FontWeight.bold,
                                              color: MyColors.primaryColorDark,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            "Memprediksi Jenis Penyakit Tanaman Dan Memberi Panduan Agar Petani Dapat Bertindak Tepat Dan Menjaga Hasil Panen Lebih Optimal",
                                            textAlign: TextAlign.center,
                                            maxLines: 4,
                                            style: TextStyle(
                                              fontSize:
                                                  Responsive.isMobile(context)
                                                      ? 16
                                                      : 20,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text("Deteksi Penyakit Tanaman",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Colors.black)),
                        const SizedBox(
                          height: 20,
                        ),
                        widthScreen > 850
                            ? const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CardScanType(
                                    title: "Padi",
                                    image: ImageAssets.logoPadi,
                                  ),
                                  SizedBox(width: 16),
                                  CardScanType(
                                    title: "Jagung",
                                    image: ImageAssets.logoJagung,
                                  ),
                                ],
                              )
                            : const Column(
                                children: [
                                  CardScanType(
                                    title: "Jagung",
                                    image: ImageAssets.logoJagung,
                                  ),
                                  CardScanType(
                                    title: "Padi",
                                    image: ImageAssets.logoPadi,
                                  ),
                                ],
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                              width: Responsive.isMobile(context)
                                  ? double.infinity
                                  : widthScreen * 0.5,
                              height: 55,
                              decoration: BoxDecoration(
                                color: MyColors.secondaryColorDark,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/history-detection');
                                  },
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.history, color: Colors.white),
                                      SizedBox(width: 12),
                                      Text("Lihat Riwayat Deteksi",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white))
                                    ],
                                  ))),
                        )
                      ],
                    ),
                  ),
                  const Footer()
                ]),
              )),
        ),
      ),
    );
  }
}
