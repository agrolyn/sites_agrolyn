import 'package:agrolyn_web/provider/detection_notifier.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/utils/responsive.dart';
import 'package:agrolyn_web/widget/navbar/navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailHistoryScanScreen extends StatelessWidget {
  final int id;
  const DetailHistoryScanScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Detail Riwayat Deteksi"),
          backgroundColor: Colors.white70,
          elevation: 0,
        ),
        backgroundColor: MyColors.primaryColorDark,
        body: ChangeNotifierProvider(
            create: (_) => DetectionNotifier(
                context: context, page: 'detail-history', idHistory: id),
            child: Consumer<DetectionNotifier>(
                builder: (context, value, child) => SingleChildScrollView(
                        child: Center(
                      child: Container(
                        padding: Responsive.isDesktop(context)
                            ? const EdgeInsets.all(16)
                            : const EdgeInsets.all(8),
                        color: Colors.white,
                        width: Responsive.isDesktop(context)
                            ? MediaQuery.of(context).size.width * 0.7
                            : double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: MyColors.primaryColorDark),
                                  child: Text(
                                      value.detailHistoryResult[
                                              'disease_indonesian_name'] +
                                          " (" +
                                          value.detailHistoryResult[
                                              'disease_name'] +
                                          ")",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: Colors.white)),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    "https://agrolyn.online/static/uploads/${value.detailHistoryResult['image_detection']}",
                                    width: double.infinity,
                                    height: Responsive.isDesktop(context)
                                        ? 400
                                        : 256,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(value.detailHistoryResult["description"]),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Text(
                                  "Penanganan",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(value.detailHistoryResult["handling"]),
                                const SizedBox(
                                  height: 16,
                                ),
                                ElevatedButton(
                                    style: ButtonStyle(
                                      minimumSize: WidgetStateProperty.all(
                                          const Size(double.maxFinite, 50)),
                                      backgroundColor: WidgetStateProperty.all(
                                          MyColors.primaryColorDark),
                                      foregroundColor:
                                          WidgetStateProperty.all(Colors.white),
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Navbar()));
                                    },
                                    child: const Text(
                                        "Diskusikan Lebih lanjut di Komunitas",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16))),
                                const SizedBox(
                                  height: 8,
                                ),
                                ElevatedButton(
                                    style: ButtonStyle(
                                      minimumSize: WidgetStateProperty.all(
                                          const Size(double.maxFinite, 50)),
                                      backgroundColor:
                                          WidgetStateProperty.all(Colors.white),
                                      foregroundColor: WidgetStateProperty.all(
                                          MyColors.primaryColorDark),
                                      side: WidgetStateProperty.all(
                                          const BorderSide(
                                              width: 1,
                                              color:
                                                  MyColors.primaryColorDark)),
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Navbar()));
                                    },
                                    child: const Text("Kembali Ke Beranda",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16)))
                              ]),
                        ),
                      ),
                    )))));
  }
}
