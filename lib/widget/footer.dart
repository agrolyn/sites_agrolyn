import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/utils/assets_path.dart';
import 'package:agrolyn_web/utils/responsive.dart';
import 'package:agrolyn_web/widget/typography.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundDark,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: ResponsiveRowColumn(
        layout: ResponsiveBreakpoints.of(context).isMobile
            ? ResponsiveRowColumnType.COLUMN
            : ResponsiveRowColumnType.ROW,
        columnMainAxisSize: MainAxisSize.min,
        rowCrossAxisAlignment: CrossAxisAlignment.center,
        rowMainAxisAlignment: MainAxisAlignment.center,
        children: [
          ResponsiveRowColumnItem(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
              child: Image.asset(ImageAssets.logo,
                  height: 100, fit: BoxFit.contain),
            ),
          ),
          ResponsiveRowColumnItem(
            rowFit: FlexFit.loose,
            columnFit: FlexFit.loose,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    style: bodyTextStyle.copyWith(
                        fontSize: 14, color: Colors.white, height: 2),
                    children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacementNamed(context, '/home');
                            },
                          text: "Beranda",
                          style: bodyTextStyle.copyWith(
                              fontSize: Responsive.isMobile(context) ? 16 : 18,
                              color: Colors.white)),
                      const TextSpan(text: "  •  "),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacementNamed(
                                  context, '/community');
                            },
                          text: "Komunitas",
                          style: bodyTextStyle.copyWith(
                              fontSize: Responsive.isMobile(context) ? 16 : 18,
                              color: Colors.white)),
                      const TextSpan(text: "  •  "),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacementNamed(
                                  context, '/detection');
                            },
                          text: "Deteksi",
                          style: bodyTextStyle.copyWith(
                              fontSize: Responsive.isMobile(context) ? 16 : 18,
                              color: Colors.white)),
                      const TextSpan(text: "  •  "),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacementNamed(
                                  context, '/olahan');
                            },
                          text: "Olahan Makanan",
                          style: bodyTextStyle.copyWith(
                              fontSize: Responsive.isMobile(context) ? 16 : 18,
                              color: Colors.white)),
                      const TextSpan(text: "  •  "),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacementNamed(
                                  context, '/education');
                            },
                          text: "Edukasi",
                          style: bodyTextStyle.copyWith(
                              fontSize: Responsive.isMobile(context) ? 16 : 18,
                              color: Colors.white)),
                    ],
                  ),
                ),
                const Divider(),
                RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                      style: bodyTextStyle.copyWith(
                          fontSize: 14, color: Colors.white, height: 1),
                      children: [
                        const TextSpan(text: '\n'),
                        TextSpan(
                            text:
                                "Agrolyn © 2025. All rights reserved - Web Dev ITC 2025 - CtrlADelete",
                            style: bodyTextStyle.copyWith(
                                fontSize:
                                    Responsive.isMobile(context) ? 14 : 16,
                                color: Colors.white)),
                      ]),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
