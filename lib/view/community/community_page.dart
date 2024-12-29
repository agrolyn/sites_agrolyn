import 'package:agrolyn_web/provider/home_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (_) => HomeNotifier(context: context),
      child: Consumer<HomeNotifier>(
        builder: (context, value, child) {
          return const Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  // mulai coding disini
                  Text('CommunityPages'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
// home, community, deteksi, recipe, edukasi
