import 'package:agrolyn_web/view/community/community_page.dart';
import 'package:agrolyn_web/view/home/detection_section.dart';
import 'package:agrolyn_web/view/home/home_page.dart';
import 'package:agrolyn_web/view/home/recipe_section.dart';
import 'package:agrolyn_web/view/splash_screen.dart';
import 'package:agrolyn_web/widget/block_wraper.dart';
import 'package:agrolyn_web/widget/carousel.dart';
import 'package:agrolyn_web/widget/footer.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: (context, widget) => ResponsiveBreakpoints.builder(
              child: Builder(builder: (context) {
                return ResponsiveScaledBox(
                    width: ResponsiveValue<double?>(context,
                        defaultValue: null,
                        conditionalValues: [
                          const Condition.equals(
                              name: 'MOBILE_SMALL', value: 480),
                        ]).value,
                    child: ClampingScrollWrapper.builder(context, widget!));
              }),
              breakpoints: [
                const Breakpoint(start: 0, end: 480, name: 'MOBILE_SMALL'),
                const Breakpoint(start: 481, end: 850, name: MOBILE),
                const Breakpoint(start: 850, end: 1080, name: TABLET),
                const Breakpoint(
                    start: 1081, end: double.infinity, name: DESKTOP),
              ],
            ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen());
  }
}

List<Widget> blocks = [
  MaxWidthBox(
    maxWidth: 1200,
    child: FittedBox(
      fit: BoxFit.fitWidth,
      alignment: Alignment.topCenter,
      child: Container(
        width: 1200,
        height: 640,
        alignment: Alignment.center,
        child: Carousel(),
      ),
    ),
  ),
  const BlockWrapper(HomePage()),
  const BlockWrapper(DetectionSection()),
  const BlockWrapper(RecipeSection()),
  const Footer()
];
