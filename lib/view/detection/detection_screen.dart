import 'package:agrolyn_web/provider/detection_notifier.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/utils/assets_path.dart';
import 'package:agrolyn_web/view/detection/card_scan_type.dart';
import 'package:agrolyn_web/view/detection/history_scan_screen.dart';
import 'package:agrolyn_web/widget/footer.dart';
import 'package:agrolyn_web/widget/navbar/navbar_desktop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetectionScreen extends StatelessWidget {
  const DetectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
      create: (_) => DetectionNotifier(context: context),
      child: Consumer<DetectionNotifier>(
        builder: (context, value, child) => Scaffold(
          body: SafeArea(
              bottom: false,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 70),
                child: Column(children: [
                  NavbarDesktop(
                    activePage: "Deteksi",
                  ),
                  Container(
                      width: widthScreen,
                      height: 250,
                      decoration: const BoxDecoration(
                        color: MyColors.primaryColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(ImageAssets.bannerScan),
                      )),
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
                              width: 300,
                              height: 55,
                              decoration: BoxDecoration(
                                color: MyColors.secondaryColorDark,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: InkWell(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(
                                        context, '/history-detection');
                                  },
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.history, color: Colors.white),
                                      SizedBox(width: 12),
                                      Text("Lihat Riwayat Scan Tanaman",
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
