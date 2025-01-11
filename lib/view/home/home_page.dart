import 'package:agrolyn_web/provider/home_notifier.dart';
import 'package:agrolyn_web/provider/menu_notifier.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/view/community/community_page.dart';
import 'package:agrolyn_web/view/detection/detection_screen.dart';
import 'package:agrolyn_web/view/home/detection_section.dart';
import 'package:agrolyn_web/view/home/harvest_calculator_section.dart';
import 'package:agrolyn_web/view/home/recipe_section.dart';
import 'package:agrolyn_web/widget/carousel.dart';
import 'package:agrolyn_web/widget/footer.dart';
import 'package:agrolyn_web/widget/navbar/nav_drawer.dart';
import 'package:agrolyn_web/widget/navbar/navbar_desktop.dart';
import 'package:agrolyn_web/widget/spacing.dart';
import 'package:agrolyn_web/widget/typography.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return ChangeNotifierProvider(
      create: (_) => HomeNotifier(context: context),
      child: Consumer<HomeNotifier>(builder: (context, value, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          key: scaffoldKey,
          drawer: const NavDrawer(),
          body: SingleChildScrollView(
            child: Column(children: [
              NavbarDesktop(
                activePage: "Beranda",
              ),
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
              HarvestCalculatorSection(),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(color: border)),
                margin: blockMargin,
                padding: const EdgeInsets.all(40),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 780),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                    text:
                                        "Agrolyn adalah sebuah sistem yang membantu petani dalam mengelola lahan pertanian mereka dengan membantu ",
                                    style: headlineSecondaryTextStyle),
                                TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushReplacementNamed(
                                            context, '/detection');
                                      },
                                    text: "deteksi penyakit tanaman",
                                    style: headlineSecondaryTextStyle.copyWith(
                                        color: MyColors.primaryColorDark)),
                                const TextSpan(
                                    text: ", ",
                                    style: headlineSecondaryTextStyle),
                                TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushReplacementNamed(
                                            context, '/detection');
                                      },
                                    text: "prediksi hasil tani",
                                    style: headlineSecondaryTextStyle.copyWith(
                                        color: MyColors.primaryColorDark)),
                                const TextSpan(
                                    text: ", dan ",
                                    style: headlineSecondaryTextStyle),
                                TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushReplacementNamed(
                                            context, '/community');
                                      },
                                    text: "diskusi dengan petani lain",
                                    style: headlineSecondaryTextStyle.copyWith(
                                        color: MyColors.primaryColorDark)),
                                const TextSpan(
                                    text: " dari seluruh Indonesia",
                                    style: headlineSecondaryTextStyle),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 32),
                          child: ResponsiveRowColumn(
                            layout: ResponsiveBreakpoints.of(context)
                                    .smallerThan(DESKTOP)
                                ? ResponsiveRowColumnType.COLUMN
                                : ResponsiveRowColumnType.ROW,
                            rowMainAxisAlignment: MainAxisAlignment.center,
                            rowCrossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ResponsiveRowColumnItem(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, '/community');
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(
                                              MyColors.primaryColorDark),
                                      overlayColor:
                                          WidgetStateProperty.resolveWith<Color>(
                                              (Set<WidgetState> states) {
                                        if (states
                                            .contains(WidgetState.hovered)) {
                                          return MyColors.primaryColor;
                                        }
                                        if (states.contains(
                                                WidgetState.focused) ||
                                            states.contains(
                                                WidgetState.pressed)) {
                                          return MyColors.primaryColor;
                                        }
                                        return MyColors.primaryColorDark;
                                      }),
                                      shape: WidgetStateProperty.resolveWith<OutlinedBorder>(
                                          (Set<WidgetState> states) {
                                        if (states.contains(
                                                WidgetState.focused) ||
                                            states.contains(
                                                WidgetState.pressed)) {
                                          return const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(16)));
                                        }
                                        return const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(16)));
                                      }),
                                      padding:
                                          WidgetStateProperty.all<EdgeInsetsGeometry>(
                                              const EdgeInsets.symmetric(
                                                  vertical: 32,
                                                  horizontal: 84)),
                                      side: WidgetStateProperty.resolveWith<
                                          BorderSide>((Set<WidgetState> states) {
                                        if (states.contains(
                                                WidgetState.focused) ||
                                            states.contains(
                                                WidgetState.pressed)) {
                                          return const BorderSide(
                                              width: 3,
                                              color:
                                                  buttonPrimaryPressedOutline);
                                        }
                                        return const BorderSide(
                                            width: 3, color: Colors.white);
                                      })),
                                  child: Text(
                                    "Komunitas",
                                    style:
                                        buttonTextStyle.copyWith(fontSize: 18),
                                  ),
                                ),
                              ),
                              ResponsiveRowColumnItem(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: TextButton(
                                    onPressed: () => {
                                      context.read<MenuNotifier>().gantiPage(2)
                                    },
                                    style: TextButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16))),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 20),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(right: 8),
                                          child: Icon(
                                            Icons.camera_alt_rounded,
                                            size: 24,
                                            color: MyColors.primaryColorDark,
                                          ),
                                        ),
                                        Text(
                                          "Deteksi Penyakit",
                                          style: buttonTextStyle.copyWith(
                                              fontSize: 16,
                                              color: MyColors.primaryColorDark),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              DetectionSection(),
              RecipeSection(idCat: 0),
              Footer()
            ]),
          ),
        );
      }),
    );
  }
}
