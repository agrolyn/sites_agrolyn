import 'package:agrolyn_web/service/detection_service.dart';
import 'package:agrolyn_web/provider/detection_notifier.dart';
import 'package:agrolyn_web/utils/assets_path.dart';
import 'package:agrolyn_web/utils/responsive.dart';
import 'package:agrolyn_web/view/detection/card_history.dart';
import 'package:agrolyn_web/widget/footer.dart';
import 'package:agrolyn_web/widget/navbar/nav_drawer.dart';
import 'package:agrolyn_web/widget/navbar/navbar_desktop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryScanScreen extends StatelessWidget {
  const HistoryScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void deleteAllHistory() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Hapus Semua Riwayat"),
              content: const Text(
                  "Apakah anda yakin ingin menghapus semua riwayat deteksi penyakit tanaman?"),
              actions: [
                TextButton(
                  child: const Text("Batal"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text("Ya, Hapus!"),
                  onPressed: () async {
                    await DetectionService().fetchDeleteAllHistory(context);
                  },
                ),
              ],
            );
          });
    }

    return ChangeNotifierProvider(
        create: (_) => DetectionNotifier(context: context, page: 'history'),
        child: Consumer<DetectionNotifier>(
            builder: (context, value, child) => Scaffold(
                  drawer: const NavDrawer(),
                  body: SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          NavbarDesktop(
                            activePage: "",
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () => Navigator.pushReplacementNamed(
                                      context, '/detection'),
                                  child: Row(children: [
                                    const Icon(Icons.arrow_back),
                                    const SizedBox(
                                      width: 22,
                                    ),
                                    const Text("Riwayat Scan Tanaman",
                                        style: TextStyle(fontSize: 20)),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () => deleteAllHistory(),
                                        icon: Icon(
                                          Icons.delete_sweep,
                                          color: Colors.red[300],
                                        ))
                                  ]),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                value.resultHistories.isNotEmpty
                                    ? GridView.builder(
                                        shrinkWrap: true,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount:
                                              Responsive.isDesktop(context)
                                                  ? 3
                                                  : Responsive.isTablet(context)
                                                      ? 2
                                                      : 1, // Jumlah kolom
                                          crossAxisSpacing: 8,
                                          mainAxisSpacing: 8,
                                          childAspectRatio: Responsive
                                                  .isDesktopLarge(context)
                                              ? 4 / 2.3
                                              : Responsive.isDesktop(context)
                                                  ? 4 / 2
                                                  : Responsive.isTablet(context)
                                                      ? 3 / 2
                                                      : 4 / 3,
                                          // Rasio ukuran grid (lebar vs tinggi)
                                        ),
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: value.resultHistories.length,
                                        itemBuilder: (context, index) {
                                          return CardHistory(
                                            history:
                                                value.resultHistories[index],
                                          );
                                        })
                                    : Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            child:
                                                Image.asset(ImageAssets.noScan),
                                          ),
                                          const SizedBox(height: 20),
                                          const Center(
                                              child: Text(
                                            "Belum ada riwayat scan tanaman",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black87),
                                          )),
                                        ],
                                      ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                          const Footer()
                        ],
                      ),
                    ),
                  ),
                )));
  }
}
