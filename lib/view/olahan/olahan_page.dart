import 'dart:ui';

import 'package:agrolyn_web/provider/olahan_notifier.dart';
import 'package:agrolyn_web/utils/assets_path.dart';
import 'package:agrolyn_web/utils/responsive.dart';
import 'package:agrolyn_web/widget/footer.dart';
import 'package:agrolyn_web/widget/navbar/nav_drawer.dart';
import 'package:agrolyn_web/widget/navbar/navbar_desktop.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/widget/no_found_custom.dart';
import 'package:agrolyn_web/view/olahan/category_olahan_page.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

class OlahanPage extends StatelessWidget {
  final int idCat;
  const OlahanPage({super.key, required this.idCat});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return ChangeNotifierProvider(
      create: (_) => OlahanNotifier(idCat, context: context),
      child: Consumer<OlahanNotifier>(builder: (context, value, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          key: scaffoldKey,
          drawer: const NavDrawer(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                NavbarDesktop(activePage: "Olahan Makanan"),
                Container(
                  width: Responsive.widthScreen(context),
                  height: Responsive.isMobile(context)
                      ? 350
                      : Responsive.heightScreen(context) * 0.92,
                  decoration: const BoxDecoration(
                    color: MyColors.primaryColorDark,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Image.asset(
                        ImageAssets.bgCock,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                              child: Container(
                                width: Responsive.isMobile(context)
                                    ? Responsive.widthScreen(context) * 0.7
                                    : Responsive.widthScreen(context) * 0.5,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(
                                      0.5), // Semi-transparent color
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(
                                    color: Colors.white
                                        .withOpacity(0.4), // Border color
                                    width: 1.5,
                                  ),
                                ),
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: Responsive.isMobile(context)
                                            ? 20
                                            : 28,
                                        horizontal: Responsive.isMobile(context)
                                            ? 20
                                            : 28),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          ImageAssets.logo,
                                          width: 100,
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          "Olahan Masakan",
                                          style: TextStyle(
                                            fontSize:
                                                Responsive.isMobile(context)
                                                    ? 18
                                                    : 24,
                                            fontWeight: FontWeight.bold,
                                            color: MyColors.primaryColorDark,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "Temukan Referensi Olahan Masakan Yang Cocok Untukmu",
                                          textAlign: TextAlign.center,
                                          maxLines: 4,
                                          style: TextStyle(
                                            fontSize:
                                                Responsive.isMobile(context)
                                                    ? 16
                                                    : 20,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ResponsiveRowColumn(
                  layout: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
                      ? ResponsiveRowColumnType.COLUMN
                      : ResponsiveRowColumnType.ROW,
                  rowCrossAxisAlignment: CrossAxisAlignment.start,
                  columnCrossAxisAlignment: CrossAxisAlignment.center,
                  columnMainAxisSize: MainAxisSize.min,
                  rowPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  columnPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  columnSpacing: 50,
                  rowSpacing: 50,
                  children: [
                    ResponsiveRowColumnItem(
                      rowFlex: 1,
                      rowFit: FlexFit.tight,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0, left: 16, right: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Teks Header
                                            RichText(
                                              text: const TextSpan(
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                                children: [
                                                  TextSpan(
                                                      text:
                                                          "Mau Masak Apa Hari Ini "),
                                                  TextSpan(
                                                    text: "Chef?",
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        decorationColor:
                                                            Colors.green,
                                                        decorationThickness: 2),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            // Sub Header
                                            RichText(
                                              text: const TextSpan(
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black),
                                                children: [
                                                  TextSpan(
                                                      text: "Agrolyn ",
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          decorationThickness:
                                                              2,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  TextSpan(
                                                      text:
                                                          "Resep Siap Membantu Kamu!"),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 8),
                                  // Chef Animation
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 192,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: MyColors.primaryColorDark),
                                      child: Row(
                                        children: [
                                          Row(
                                            children: [
                                              Responsive.isDesktop(context)
                                                  ? Row(
                                                      children: [
                                                        SizedBox(
                                                            height: 256,
                                                            width: 256,
                                                            child: Lottie.asset(
                                                                ImageAssets
                                                                    .chef)),
                                                        Center(
                                                          child: Text(
                                                            "Mulai Olah Bahan Masak Kamu Jadi Aneka Masakan Nusantara Terpopuler",
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .white,
                                                                decorationThickness:
                                                                    2,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Responsive.isTablet(context)
                                                      ? Row(
                                                          children: [
                                                            SizedBox(
                                                                height: 256,
                                                                width: 256,
                                                                child: Lottie.asset(
                                                                    ImageAssets
                                                                        .chef)),
                                                          ],
                                                        )
                                                      : Row(
                                                          children: [
                                                            SizedBox(
                                                                height: 256,
                                                                width: 256,
                                                                child: Lottie.asset(
                                                                    ImageAssets
                                                                        .chef)),
                                                          ],
                                                        )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: RichText(
                                      text: const TextSpan(
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black),
                                        children: [
                                          TextSpan(text: "Aneka Masakan"),
                                          TextSpan(
                                            text: " Nusantara ",
                                            style: TextStyle(
                                                color: Colors.green,
                                                decorationThickness: 2,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(text: " Terpopuler"),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  // Olahan list horizontal using GridView.builder
                                  value.olahans.isNotEmpty
                                      ? GridView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: Responsive
                                                    .isDesktop(context)
                                                ? 3
                                                : Responsive.isTablet(context)
                                                    ? 2
                                                    : 1, // Jumlah kolom
                                            crossAxisSpacing: 8,
                                            mainAxisSpacing: 8,
                                            mainAxisExtent:
                                                200, // Set the height for each grid item (adjust this value)
                                            childAspectRatio: Responsive
                                                    .isDesktopLarge(context)
                                                ? 4 / 2.3
                                                : Responsive.isDesktop(context)
                                                    ? 4 / 2
                                                    : Responsive.isTablet(
                                                            context)
                                                        ? 3 / 2
                                                        : 4 / 2.3,
                                            // Rasio ukuran grid (lebar vs tinggi)
                                          ),
                                          itemCount: value.olahans.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            var olahan = value.olahans[index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      MyColors.primaryColorDark,
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      olahan['thumbnail'] !=
                                                                  null &&
                                                              olahan['thumbnail']
                                                                  .isNotEmpty
                                                          ? ClipOval(
                                                              child:
                                                                  Image.network(
                                                                olahan['thumbnail'] ??
                                                                    '',
                                                                fit: BoxFit
                                                                    .cover,
                                                                width: 128,
                                                                height: 128,
                                                              ),
                                                            )
                                                          : const Icon(
                                                              Icons.image,
                                                              size: 64),
                                                      const SizedBox(width: 8),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "${olahan['label'] ?? 'Unknown'}",
                                                              style: const TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            const SizedBox(
                                                                height: 8),
                                                            Text(
                                                              "Tersedia berbagai olahan dari ${olahan['label'] ?? 'Olahan Tidak Diketahui'} yang bisa menjadi inspirasi untuk ide usaha kuliner kamu. Coba dan temukan resep terbaik untuk bisnismu!",
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            const SizedBox(
                                                                height: 8),
                                                            InkWell(
                                                              // onTap: () {
                                                              //   int idCat =
                                                              //       int.tryParse(
                                                              //               olahan['id'].toString()) ??
                                                              //           0;
                                                              //   // Navigator.push(
                                                              //   //   context,
                                                              //   //   MaterialPageRoute(
                                                              //   //     builder: (context) =>
                                                              //   //         CategoryOlahanPage(
                                                              //   //             idCat:
                                                              //   //                 idCat),
                                                              //   //   ),
                                                              //   // );
                                                              //   Navigator.pushNamed(
                                                              //       context,
                                                              //       '/olahan-category',
                                                              //       arguments:
                                                              //           idCat);
                                                              // },
                                                              onTap: () {
                                                                int idCat =
                                                                    int.tryParse(
                                                                            olahan['id'].toString()) ??
                                                                        0;
                                                                Navigator
                                                                    .pushNamed(
                                                                  context,
                                                                  '/category-olahan', // Corrected route name
                                                                  arguments:
                                                                      idCat,
                                                                );
                                                              },
                                                              child: Container(
                                                                height: 32,
                                                                width: 160,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8)),
                                                                child:
                                                                    const Center(
                                                                  child: Text(
                                                                    "Lihat Selengkapnya",
                                                                    style: TextStyle(
                                                                        color: MyColors
                                                                            .primaryColorDark,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.bold),
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
                                            );
                                          },
                                        )
                                      : const Center(
                                          child: NoFoundCustom(
                                            message: "Olahan Kosong",
                                            subMessage:
                                                "Olahan yang kamu cari lagi kosong nih!",
                                          ),
                                        ),
                                ],
                              ),
                              Positioned(
                                top: 36,
                                right: -10,
                                child: Image.asset(
                                  ImageAssets.piring1,
                                  width: 250,
                                  height: 250,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Footer(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
