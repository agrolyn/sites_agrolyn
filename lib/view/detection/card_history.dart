import 'package:agrolyn_web/service/detection_service.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/view/detection/detail_history_scan_screen.dart';
import 'package:flutter/material.dart';
import 'package:agrolyn_web/utils/date.dart';

class CardHistory extends StatelessWidget {
  final history;
  const CardHistory({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    void deleteHistory() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Hapus Riwayat"),
              content: const Text(
                  "Apakah anda yakin ingin menghapus riwayat scan tanaman ini?"),
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
                    await DetectionService()
                        .fetchDeleteHistory(context, history['id']);
                  },
                ),
              ],
            );
          });
    }

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailHistoryScanScreen(id: history['id'])));
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          child: Column(
            children: [
              Stack(children: [
                Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Image.network(
                              "https://agrolyn.online/static/uploads/${history['image_detection']}")
                          .image,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                        color: MyColors.secondaryColorDark,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        )),
                    child: IconButton(
                        onPressed: () => deleteHistory(),
                        icon: const Icon(
                          Icons.delete_forever,
                          color: Colors.white,
                        )),
                  ),
                )
              ]),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    history['disease_indonesian_name'],
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "(${history['disease_name']})",
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.calendar_month_outlined,
                      size: 11, color: Colors.grey),
                  const SizedBox(width: 4),
                  FutureBuilder(
                    future: formatRelativeTime(history['history_date']),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data.toString(),
                          style: const TextStyle(color: Colors.grey),
                        );
                      } else {
                        return const CircularProgressIndicator(); // or some other loading indicator
                      }
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
