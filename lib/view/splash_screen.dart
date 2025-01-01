import 'package:agrolyn_web/provider/splash_notiier.dart';
import 'package:agrolyn_web/utils/assets_path.dart';
import 'package:agrolyn_web/widget/navbar/navbar.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  final BuildContext context;
  SplashScreen({required this.context, super.key}) {
    initialize();
  }

  void initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getBool('isLogedIn'));
    if (prefs.getBool('isLogedIn') == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Navbar(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SplashNotifier(context: context),
      child: Consumer<SplashNotifier>(
          builder: (context, value, child) => Scaffold(
                body: FlutterSplashScreen.scale(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blue,
                      Colors.green,
                    ],
                  ),
                  childWidget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageAssets.logo,
                        height: 180,
                        width: 180,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        "AGROLYN",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        "Solusi Cerdas Pertanian Masa Depan",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  duration: const Duration(milliseconds: 1500),
                  animationDuration: const Duration(milliseconds: 1000),
                  onAnimationEnd: () {
                    value.effectSplashScreen();
                  },
                ),
              )),
    );
  }
}
