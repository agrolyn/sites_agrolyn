import 'package:agrolyn_web/provider/detection_notifier.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/widget/navbar/navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailHistoryScanScreen extends StatelessWidget {
  List<String> list = [
    "Penggunaan Varietas Tahan PenyakitPilih varietas padi yang memiliki ketahanan terhadap Hawar Daun Bakteri. Penggunaan varietas tahan adalah salah satu cara paling efektif untuk mengurangi risiko penyakit ini.",
    "Pengaturan Irigasi dan Drainase yang Baik, Hindari genangan air yang dapat meningkatkan kelembapan dan memudahkan penyebaran bakteri. Pastikan saluran drainase berfungsi dengan baik untuk mencegah air tergenang.",
    "Penggunaan Benih Sehat dan Bebas Penyakit Pilih benih yang sehat dan bebas dari kontaminasi penyakit. Benih yang terinfeksi dapat menjadi sumber utama penyebaran penyakit ini.",
    "Sanitasi dan Pemangkasan Daun Terinfeksi. Potong daun yang terinfeksi untuk mengurangi sumber infeksi. Buang daun terinfeksi jauh dari lahan tanam agar tidak menyebar ke tanaman lain.",
    "Penggunaan Bakterisida Sesuai Anjuran. Jika serangan sudah meluas, aplikasi bakterisida dapat digunakan"
  ];
  final int id;
  DetailHistoryScanScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Detail Riwayat Deteksi"),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: ChangeNotifierProvider(
            create: (_) => DetectionNotifier(
                context: context, page: 'detail-history', idHistory: id),
            child: Consumer<DetectionNotifier>(
                builder: (context, value, child) => SafeArea(
                      bottom: false,
                      child: SingleChildScrollView(
                          padding: const EdgeInsets.only(bottom: 20),
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
                                      height: 180,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                      value.detailHistoryResult["description"]),
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
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                                MyColors.primaryColorDark),
                                        foregroundColor:
                                            WidgetStateProperty.all(
                                                Colors.white),
                                      ),
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Navbar()));
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
                                            WidgetStateProperty.all(
                                                Colors.white),
                                        foregroundColor:
                                            WidgetStateProperty.all(
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
                                                builder: (context) =>
                                                    Navbar()));
                                      },
                                      child: const Text("Kembali Ke Beranda",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16)))
                                ]),
                          )),
                    ))));
  }
}
