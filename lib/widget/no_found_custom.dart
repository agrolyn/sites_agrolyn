import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/utils/assets_path.dart';
import 'package:agrolyn_web/widget/typography.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_framework/responsive_framework.dart';

class NoFoundCustom extends StatelessWidget {
  final String message; // Pesan kustom yang ingin ditampilkan
  final String subMessage; // Sub pesan yang menjelaskan lebih lanjut

  const NoFoundCustom({
    super.key,
    this.message = "No Result Found", // Default pesan
    this.subMessage =
        "We can’t find any item matching your search", // Default sub pesan
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: ResponsiveRowColumn(
        layout: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
            ? ResponsiveRowColumnType.COLUMN
            : ResponsiveRowColumnType.ROW,
        rowMainAxisAlignment: MainAxisAlignment.center,
        rowCrossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ResponsiveRowColumnItem(
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Gambar (bisa menggunakan image asset atau lottie animation)
                Lottie.asset(
                  ImageAssets.error,
                  width: 222,
                  height: 222,
                ),
                const SizedBox(height: 16),
                // Pesan Utama
                Text(
                  message,
                  style: headlineSecondaryTextStyle,
                ),
                const SizedBox(height: 8),
                // Sub Pesan
                Text(
                  subMessage,
                  style: bodyTextStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class NoFoundCustomWhite extends StatelessWidget {
  final String message; // Pesan kustom yang ingin ditampilkan
  final String subMessage; // Sub pesan yang menjelaskan lebih lanjut

  const NoFoundCustomWhite({
    super.key,
    this.message = "No Result Found", // Default pesan
    this.subMessage =
        "We can’t find any item matching your search", // Default sub pesan
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: ResponsiveRowColumn(
        layout: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
            ? ResponsiveRowColumnType.COLUMN
            : ResponsiveRowColumnType.ROW,
        rowMainAxisAlignment: MainAxisAlignment.center,
        rowCrossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ResponsiveRowColumnItem(
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Gambar (bisa menggunakan image asset atau lottie animation)
                Lottie.asset(
                  ImageAssets.error,
                  width: 222,
                  height: 222,
                ),
                const SizedBox(height: 16),
                // Pesan Utama
                Text(
                  message,
                  style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      height: 1.2,
                      fontFamily: fontFamily),
                ),
                const SizedBox(height: 8),
                // Sub Pesan
                Text(
                  subMessage,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      height: 1.5,
                      fontFamily: "Roboto"),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
