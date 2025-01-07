import 'package:agrolyn_web/provider/home_notifier.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/utils/assets_path.dart';
import 'package:agrolyn_web/view/detection/detection_page.dart';
import 'package:agrolyn_web/widget/spacing.dart';
import 'package:agrolyn_web/widget/typography.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

class DetectionSection extends StatelessWidget {
  const DetectionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeNotifier(context: context),
      child: Consumer<HomeNotifier>(
        builder: (context, value, child) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: MyColors.primaryColorDark,
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: border),
            ),
            margin: blockMargin,
            padding: blockPadding(context),
            child: ResponsiveRowColumn(
              layout: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
                  ? ResponsiveRowColumnType.COLUMN
                  : ResponsiveRowColumnType.ROW,
              rowCrossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ResponsiveRowColumnItem(
                  rowFlex: 2,
                  columnOrder: 1,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Lottie.asset(
                        ImageAssets.backgorundAnimation,
                        width: double.infinity,
                        height: 300, // Adjust height if needed
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                ResponsiveRowColumnItem(
                  rowFlex: 2,
                  columnOrder: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.only(bottom: 16, left: 16, right: 8),
                        child: Text(
                          "Deteksi Penyakit Tanaman Kamu",
                          style: TextStyle(
                            fontSize: 44,
                            color: Colors.white,
                            height: 1.2,
                            fontFamily: fontFamily,
                          ),
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.only(bottom: 16, left: 16, right: 8),
                        child: Text(
                          "Agrolyn menggunakan teknologi AI untuk mendeteksi penyakit tanaman kamu. Dengan teknologi ini, kamu bisa mendeteksi penyakit tanaman kamu dengan mudah dan cepat.",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            height: 1.5,
                            fontFamily: "Roboto",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 8),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, '/detection');
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all<Color>(Colors.white),
                            overlayColor:
                                WidgetStateProperty.resolveWith<Color>(
                                    (Set<WidgetState> states) {
                              if (states.contains(WidgetState.hovered)) {
                                return Colors.white;
                              }
                              if (states.contains(WidgetState.focused) ||
                                  states.contains(WidgetState.pressed)) {
                                return Colors.white.withOpacity(0.5);
                              }
                              return Colors.white;
                            }),
                            shape:
                                WidgetStateProperty.resolveWith<OutlinedBorder>(
                                    (Set<WidgetState> states) {
                              if (states.contains(WidgetState.focused) ||
                                  states.contains(WidgetState.pressed)) {
                                return const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)));
                              }
                              return const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)));
                            }),
                            padding:
                                WidgetStateProperty.all<EdgeInsetsGeometry>(
                                    const EdgeInsets.symmetric(
                                        vertical: 32, horizontal: 84)),
                            side: WidgetStateProperty.resolveWith<BorderSide>(
                                (Set<WidgetState> states) {
                              if (states.contains(WidgetState.focused) ||
                                  states.contains(WidgetState.pressed)) {
                                return const BorderSide(
                                    width: 3,
                                    color: buttonPrimaryPressedOutline);
                              }
                              return const BorderSide(
                                  width: 3, color: Colors.white);
                            }),
                          ),
                          child: const Text(
                            "Deteksi",
                            style: TextStyle(
                                fontSize: 18,
                                color: MyColors.primaryColorDark,
                                height: 1,
                                fontFamily: fontFamily),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
