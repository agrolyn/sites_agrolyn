import 'package:agrolyn_web/provider/home_notifier.dart';
import 'package:agrolyn_web/provider/menu_notifier.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/utils/responsive.dart';
import 'package:agrolyn_web/view/chatbot/chatbot.dart';
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
    void _showPopup(BuildContext context) {
      showDialog(
        context: context,
        barrierColor: Colors.black54, // Latar belakang semi-transparan
        builder: (context) {
          final isMobile =
              MediaQuery.of(context).size.width < 600; // Deteksi mobile
          return Stack(
            children: [
              Align(
                alignment: Alignment.bottomRight, // Posisi di bawah kanan
                child: Container(
                  width: isMobile
                      ? MediaQuery.of(context).size.width *
                          0.9 // Hampir penuh pada mobile
                      : 400, // Lebar tetap untuk desktop/tablet
                  height: isMobile
                      ? MediaQuery.of(context).size.height *
                          0.8 // Hampir penuh pada mobile
                      : 550, // Tinggi tetap untuk desktop/tablet
                  margin: const EdgeInsets.only(
                    bottom: 80, // Jarak dari bawah (di atas FAB)
                    right: 16, // Jarak dari tepi kanan
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white, // Warna latar popup
                    borderRadius:
                        BorderRadius.circular(12), // Membulatkan sudut
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26, // Warna bayangan
                        blurRadius: 10, // Intensitas blur bayangan
                        offset: Offset(0, 4), // Posisi bayangan
                      ),
                    ],
                  ),
                  child: Chatbot(),
                ),
              ),
            ],
          );
        },
      );
    }

    return ChangeNotifierProvider(
      create: (_) => HomeNotifier(context: context),
      child: Consumer<HomeNotifier>(builder: (context, value, child) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showPopup(context), // Memanggil popup
            child: Icon(
              Icons.chat_rounded,
              color: Colors.white,
            ),
            backgroundColor: MyColors.primaryColorDark,
          ),
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
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, '/detection');
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(
                                              Colors.white),
                                      overlayColor:
                                          WidgetStateProperty.resolveWith<Color>(
                                              (Set<WidgetState> states) {
                                        if (states
                                            .contains(WidgetState.hovered)) {
                                          return Colors.white30;
                                        }
                                        if (states.contains(
                                                WidgetState.focused) ||
                                            states.contains(
                                                WidgetState.pressed)) {
                                          return Colors.white30;
                                        }
                                        return Colors.white;
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
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 8),
                                        child: Icon(
                                          Icons.camera_alt_rounded,
                                          size: 16,
                                          color: MyColors.primaryColorDark,
                                        ),
                                      ),
                                      Text(
                                        "Deteksi",
                                        style: buttonTextStyle.copyWith(
                                            fontSize: 16,
                                            color: MyColors.primaryColorDark),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
