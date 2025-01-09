import 'package:flutter/material.dart';

class MenuNotifier extends ChangeNotifier {
  final BuildContext context;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  MenuNotifier({required this.context});

  int page = 0;
  gantiPage(int value) {
    page = value;
    notifyListeners();
  }
}
