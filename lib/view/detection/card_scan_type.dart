import 'package:agrolyn_web/utils/responsive.dart';
import 'package:agrolyn_web/view/detection/choose_types_scan.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardScanType extends StatelessWidget {
  final String title;
  final String image;

  const CardScanType({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('scan_type', title);
        Navigator.pushReplacementNamed(context, '/upload-detection');
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(2, 2),
            )
          ],
        ),
        width: Responsive.isMobile(context)
            ? double.infinity
            : MediaQuery.of(context).size.width * 0.4,
        child: Row(children: [
          Image.asset(
            image,
            width: 50,
            height: 50,
          ),
          const SizedBox(width: 20),
          Text(
            "Scan Tanaman $title",
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.black54,
          )
        ]),
      ),
    );
  }
}
