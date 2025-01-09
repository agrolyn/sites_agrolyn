import 'dart:ui';

import 'package:agrolyn_web/provider/detection_notifier.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/utils/assets_path.dart';
import 'package:agrolyn_web/widget/navbar/navbar_desktop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseTypesScan extends StatelessWidget {
  const ChooseTypesScan({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetectionNotifier(context: context),
      child: Consumer<DetectionNotifier>(builder: (context, value, child) {
        return Scaffold(
          body: Stack(
            children: [
              Image.asset(
                ImageAssets.bgScan, // Path animasi Anda
                width: double.infinity, // Lebar penuh
                height: double.infinity, // Tinggi penuh
                fit: BoxFit.cover, // Menyesuaikan animasi agar memenuhi area
              ),
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: NavbarDesktop(activePage: "")),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white
                              .withOpacity(0.5), // Semi-transparent color
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color:
                                Colors.white.withOpacity(0.4), // Border color
                            width: 1.5,
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 32.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Deteksi Penyakit Tanaman",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.primaryColorDark,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "Temukan solusi terbaik untuk tanamanmu",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: value.pickAndUploadFile,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                    ),
                                    child: value.predictionIsLoading
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : const Text(
                                            'Unggah Foto',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                  ),
                                ),
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
        );
      }),
    );
  }
}
