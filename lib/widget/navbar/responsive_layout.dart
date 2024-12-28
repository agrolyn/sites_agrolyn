// import 'package:agrolyn_web/main.dart';
// import 'package:agrolyn_web/shared/constans.dart';
// import 'package:agrolyn_web/view/community/community_page.dart';
// import 'package:agrolyn_web/view/detection/detection_page.dart';
// import 'package:agrolyn_web/view/education/education_page.dart';
// import 'package:agrolyn_web/view/home/home_page.dart';
// import 'package:flutter/material.dart';
// import 'package:sidebarx/sidebarx.dart';

// import '../../view/recipe/recipe_page.dart';

// class MobileScreen extends StatefulWidget {
//   const MobileScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _MobileScreenState createState() => _MobileScreenState();
// }

// class _MobileScreenState extends State<MobileScreen> {
//   int _selectedIndex = 0;

//   final List<Widget> _pages = [
//     ListView.builder(
//         itemCount: blocks.length,
//         itemBuilder: (context, index) {
//           return blocks[index];
//         }),
//     CommunityPage(),
//     DetectionPage(),
//     RecipePage(),
//     EducationPage(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         unselectedItemColor: Colors.grey,
//         selectedItemColor: MyColors.primaryColorDark,
//         currentIndex: _selectedIndex,
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
//           BottomNavigationBarItem(icon: Icon(Icons.forum), label: 'Komunitas'),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.camera_alt_rounded), label: 'Deteksi'),
//           BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: 'Resep'),
//           BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Edukasi'),
//         ],
//       ),
//     );
//   }
// }

// class DesktopScreen extends StatefulWidget {
//   const DesktopScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _DesktopScreenState createState() => _DesktopScreenState();
// }

// class _DesktopScreenState extends State<DesktopScreen> {
//   int _selectedIndex = 0;

//   final List<Widget> _pages = [
//     ListView.builder(
//         itemCount: blocks.length,
//         itemBuilder: (context, index) {
//           return blocks[index];
//         }),
//     CommunityPage(),
//     DetectionPage(),
//     RecipePage(),
//     EducationPage(),
//   ];

//   // Membuat controller untuk SidebarX
//   final SidebarXController _controller =
//       SidebarXController(selectedIndex: 0, extended: true);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: [
//           // SidebarX sebagai pengganti NavigationRail
//           SidebarX(
//             controller: _controller,
//             theme: SidebarXTheme(
//               margin: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: MyColors.primaryColorDark,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               hoverColor: Colors.lightBlue,
//               selectedTextStyle: const TextStyle(color: Colors.white70),
//               iconTheme: const IconThemeData(color: Colors.white70),
//               selectedIconTheme: const IconThemeData(color: Colors.white),
//             ),
//             extendedTheme: const SidebarXTheme(
//               width: 200,
//               decoration: BoxDecoration(
//                 color: MyColors.primaryColorDark,
//               ),
//               hoverColor: Colors.black,
//               hoverTextStyle: TextStyle(color: Colors.white),
//               textStyle: TextStyle(color: Colors.white),
//               selectedTextStyle: TextStyle(color: Colors.white),
//             ),
//             items: [
//               SidebarXItem(
//                 icon: Icons.home,
//                 label: 'Beranda',
//                 onTap: () {
//                   setState(() {
//                     _selectedIndex = 0;
//                   });
//                 },
//               ),
//               SidebarXItem(
//                 icon: Icons.forum,
//                 label: 'Komunitas',
//                 onTap: () {
//                   setState(() {
//                     _selectedIndex = 1;
//                   });
//                 },
//               ),
//               SidebarXItem(
//                 icon: Icons.camera_alt_rounded,
//                 label: 'Deteksi',
//                 onTap: () {
//                   setState(() {
//                     _selectedIndex = 2;
//                   });
//                 },
//               ),
//               SidebarXItem(
//                 icon: Icons.restaurant,
//                 label: 'Resep',
//                 onTap: () {
//                   setState(() {
//                     _selectedIndex = 3;
//                   });
//                 },
//               ),
//               SidebarXItem(
//                 icon: Icons.article,
//                 label: 'Edukasi',
//                 onTap: () {
//                   setState(() {
//                     _selectedIndex = 4;
//                   });
//                 },
//               ),
//             ],
//           ),
//           // Tampilan konten yang diperluas
//           Expanded(
//             child: _pages[_selectedIndex],
//           ),
//         ],
//       ),
//     );
//   }
// }
