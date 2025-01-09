import 'package:agrolyn_web/provider/menu_notifier.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => MenuNotifier(context: context),
        child: Consumer<MenuNotifier>(
          builder: (context, value, child) => BottomNavigationBar(
            unselectedItemColor: Colors.grey,
            selectedItemColor: MyColors.primaryColorDark,
            currentIndex: value.page,
            onTap: (index) {
              value.gantiPage(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.forum), label: 'Komunitas'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.camera_alt_rounded), label: 'Deteksi'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.restaurant), label: 'Olahan'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.article), label: 'Edukasi'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.emoji_food_beverage), label: 'Resep'),
            ],
          ),
        ));
  }
}
