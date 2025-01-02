import 'package:agrolyn_web/main.dart';
import 'package:agrolyn_web/view/olahan/category_olahan_page.dart';
import 'package:agrolyn_web/view/olahan/olahan_page.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:provider/provider.dart';
import 'package:agrolyn_web/view/community/community_page.dart';
import 'package:agrolyn_web/view/detection/detection_page.dart';
import 'package:agrolyn_web/view/education/education_page.dart';
import 'package:agrolyn_web/view/recipe/recipe_page.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/provider/menu_notifier.dart';

class Navbar extends StatelessWidget {
  Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MenuNotifier(context: context),
      child: Consumer<MenuNotifier>(
        builder: (context, value, child) {
          return LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                // Mobile layout
                return Scaffold(
                  body: _pages[value.page],
                  bottomNavigationBar: BottomNavigationBar(
                    unselectedItemColor: Colors.grey,
                    selectedItemColor: MyColors.primaryColorDark,
                    currentIndex: value.page,
                    onTap: (index) {
                      value.gantiPage(index);
                    },
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home), label: 'Beranda'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.forum), label: 'Komunitas'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.camera_alt_rounded),
                          label: 'Deteksi'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.restaurant), label: 'Olahan'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.article), label: 'Edukasi'),
                    ],
                  ),
                );
              } else {
                // Desktop layout
                final SidebarXController controller = SidebarXController(
                    selectedIndex: value.page, extended: true);

                return Scaffold(
                  body: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SidebarX sebagai pengganti NavigationRail
                      SidebarX(
                        controller: controller,
                        theme: SidebarXTheme(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: MyColors.primaryColorDark,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hoverColor: Colors.lightBlue,
                          selectedTextStyle:
                              const TextStyle(color: Colors.white),
                          iconTheme: const IconThemeData(color: Colors.white),
                          selectedIconTheme:
                              const IconThemeData(color: Colors.white),
                        ),
                        extendedTheme: const SidebarXTheme(
                          width: 250, // Sidebar lebar untuk desktop
                          decoration: BoxDecoration(
                            color: MyColors.primaryColorDark,
                          ),
                          hoverColor: Colors.black,
                          hoverTextStyle: TextStyle(color: Colors.white),
                          textStyle: TextStyle(color: Colors.white),
                          selectedTextStyle: TextStyle(color: Colors.white),
                        ),
                        items: [
                          SidebarXItem(
                            icon: Icons.home,
                            label: 'Beranda',
                            onTap: () {
                              value.gantiPage(0);
                            },
                          ),
                          SidebarXItem(
                            icon: Icons.forum,
                            label: 'Komunitas',
                            onTap: () {
                              value.gantiPage(1);
                            },
                          ),
                          SidebarXItem(
                            icon: Icons.camera_alt_rounded,
                            label: 'Deteksi',
                            onTap: () {
                              value.gantiPage(2);
                            },
                          ),
                          SidebarXItem(
                            icon: Icons.restaurant,
                            label: 'Olahan',
                            onTap: () {
                              value.gantiPage(3);
                            },
                          ),
                          SidebarXItem(
                            icon: Icons.article,
                            label: 'Edukasi',
                            onTap: () {
                              value.gantiPage(4);
                            },
                          ),
                        ],
                      ),
                      // Tampilan konten yang diperluas
                      Expanded(
                        child: _pages[value.page],
                      ),
                    ],
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }

  final List<Widget> _pages = [
    ListView.builder(
        itemCount: blocks.length,
        itemBuilder: (context, index) {
          return blocks[index];
        }),
    const CommunityPage(
        // back: () => ListView.builder(
        //     itemCount: blocks.length,
        //     itemBuilder: (context, index) {
        //       return blocks[index];
        //     }),
        ),
    const DetectionPage(),
    const OlahanPage(
      idCat: 0, // Replace 'someId' with the appropriate value
    ),
    // const CategoryOlahanPage(idCat: 1),
    const EducationPage(),
  ];
}
