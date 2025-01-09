import 'package:agrolyn_web/view/auth/forgot_password_page.dart';
import 'package:agrolyn_web/view/auth/login_page.dart';
import 'package:agrolyn_web/view/auth/register_page.dart';
import 'package:agrolyn_web/view/community/community_page.dart';
import 'package:agrolyn_web/view/detection/choose_types_scan.dart';
import 'package:agrolyn_web/view/detection/detection_result_screen.dart';
import 'package:agrolyn_web/view/detection/detection_screen.dart';
import 'package:agrolyn_web/view/detection/history_scan_screen.dart';
import 'package:agrolyn_web/view/education/education_page.dart';
import 'package:agrolyn_web/view/home/detection_section.dart';
import 'package:agrolyn_web/view/home/harvest_calculator_section.dart';
import 'package:agrolyn_web/view/home/home_page.dart';
import 'package:agrolyn_web/view/home/recipe_section.dart';
import 'package:agrolyn_web/view/olahan/olahan_page.dart';
import 'package:agrolyn_web/view/recipe/recipe_page.dart';
import 'package:agrolyn_web/view/splash_screen.dart';
import 'package:agrolyn_web/widget/block_wraper.dart';
import 'package:agrolyn_web/widget/carousel.dart';
import 'package:agrolyn_web/widget/footer.dart';
import 'package:agrolyn_web/widget/navbar/navbar.dart';
import 'package:agrolyn_web/widget/navbar/navbar_desktop.dart';
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
                    const Condition.equals(name: 'MOBILE_SMALL', value: 480),
                  ]).value,
              child: ClampingScrollWrapper.builder(context, widget!));
        }),
        breakpoints: [
          const Breakpoint(start: 0, end: 480, name: 'MOBILE_SMALL'),
          const Breakpoint(start: 481, end: 850, name: MOBILE),
          const Breakpoint(start: 850, end: 1080, name: TABLET),
          const Breakpoint(start: 1081, end: double.infinity, name: DESKTOP),
        ],
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/splashScreen',
      themeAnimationDuration: Duration.zero,
      routes: {
        '/navbar': (context) => Navbar(),
        '/login': (context) => LoginPage(context: context),
        '/register': (context) => const RegisterPage(),
        '/forgot-password': (context) => ForgotPasswordPage(),
        '/splashScreen': (context) => SplashScreen(
              context: context,
            ),
        '/home': (context) => ListView.builder(
            itemCount: blocks.length,
            itemBuilder: (context, index) {
              return blocks[index];
            }),
        '/detection': (context) => const DetectionScreen(),
        '/upload-detection': (context) => const ChooseTypesScan(),
        '/result-detection': (context) => const DetectionResultScreen(),
        '/history-detection': (context) => const HistoryScanScreen(),
        '/community': (context) => const CommunityPage(),
        '/olahan': (context) => const OlahanPage(
              idCat: 0, // Replace 'someId' with the appropriate value
            ),
        '/recipe': (context) => const RecipePage(),
        '/education': (context) => const EducationPage(),
        'forgotPassword': (context) => ForgotPasswordPage(),
      },
    );
  }
}

List<Widget> blocks = [
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
  const BlockWrapper(HarvestCalculatorSection()),
  const BlockWrapper(HomePage()),
  const BlockWrapper(DetectionSection()),
  const BlockWrapper(RecipeSection(
    idCat: 0,
  )),
  const Footer()
];
