import 'package:agrolyn_web/provider/olahan_notifier.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/utils/assets_path.dart';
import 'package:agrolyn_web/utils/responsive.dart';
import 'package:agrolyn_web/view/olahan/detail_olahan_page.dart';
import 'package:agrolyn_web/widget/footer.dart';
import 'package:agrolyn_web/widget/navbar/nav_drawer.dart';
import 'package:agrolyn_web/widget/navbar/navbar_desktop.dart';
import 'package:agrolyn_web/widget/no_found_custom.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CategoryOlahanPage extends StatelessWidget {
  final int idCat;
  const CategoryOlahanPage({super.key, required this.idCat});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return ChangeNotifierProvider(
      create: (_) => OlahanNotifier(idCat, context: context),
      child: Consumer<OlahanNotifier>(
        builder: (context, value, child) {
          return Scaffold(
            key: scaffoldKey,
            drawer: const NavDrawer(),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  NavbarDesktop(activePage: ""),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InkWell(
                      onTap: () => Navigator.pop(
                          context), // Kembali ke halaman sebelumnya
                      child: Row(children: [
                        const Icon(Icons.arrow_back),
                        const SizedBox(
                          width: 22,
                        ),
                        const Text("Kembali", style: TextStyle(fontSize: 20)),
                      ]),
                    ),
                  ),
                  ResponsiveRowColumn(
                    layout:
                        ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
                            ? ResponsiveRowColumnType.COLUMN
                            : ResponsiveRowColumnType.ROW,
                    rowCrossAxisAlignment: CrossAxisAlignment.start,
                    columnCrossAxisAlignment: CrossAxisAlignment.center,
                    columnMainAxisSize: MainAxisSize.min,
                    rowPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    columnPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 40),
                    columnSpacing: 50,
                    rowSpacing: 50,
                    children: [
                      ResponsiveRowColumnItem(
                        rowFlex: 1,
                        rowFit: FlexFit.tight,
                        child: Column(
                          children: [
                            // Chef Animation
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 192,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: MyColors.primaryColorDark),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Responsive.isDesktop(context)
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Mulai Olah Bahan Masak Kamu Jadi Aneka Masakan Nusantara Terpopuler",
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        color: Colors.white,
                                                        decorationThickness: 2,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    "Dengan berbagai resep masakan yang mudah diikuti, kamu bisa mengubah bahan masak sederhana menjadi hidangan lezat khas Nusantara Terpopuler",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white,
                                                        decorationThickness: 2,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ],
                                              )
                                            : Responsive.isTablet(context)
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Mulai Olah Bahan Masak Kamu Jadi Aneka Masakan Nusantara Terpopuler",
                                                        style: TextStyle(
                                                            fontSize: 24,
                                                            color: Colors.white,
                                                            decorationThickness:
                                                                2,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Text(
                                                        "Dengan berbagai resep masakan yang mudah diikuti, kamu bisa mengubah bahan masak sederhana menjadi hidangan lezat khas Nusantara Terpopuler",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.white,
                                                            decorationThickness:
                                                                2,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                      ),
                                                    ],
                                                  )
                                                : Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Mulai Olah Bahan Masak Kamu Jadi Aneka Masakan Nusantara Terpopuler",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.white,
                                                            decorationThickness:
                                                                2,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ), // Jumlah kolom
                                      ),
                                    ),
                                    SizedBox(
                                      width: 32,
                                    ),
                                    SizedBox(
                                        height: 256,
                                        width: 256,
                                        child: Lottie.asset(ImageAssets.chef)),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),
                            value.detailOlahans.isNotEmpty
                                ? GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          Responsive.isDesktop(context)
                                              ? 3
                                              : Responsive.isTablet(context)
                                                  ? 2
                                                  : 1, // Jumlah kolom
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8,
                                      mainAxisExtent:
                                          200, // Set the height for each grid item (adjust this value)
                                      childAspectRatio:
                                          Responsive.isDesktopLarge(context)
                                              ? 4 / 2.3
                                              : Responsive.isDesktop(context)
                                                  ? 4 / 2
                                                  : Responsive.isTablet(context)
                                                      ? 3 / 2
                                                      : 4 / 2.3,
                                      // Rasio ukuran grid (lebar vs tinggi)
                                    ),
                                    itemCount: value.detailOlahans.length,
                                    itemBuilder: (context, index) {
                                      var detailOlahan =
                                          value.detailOlahans[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: MyColors.primaryColorDark,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 16,
                                                ),
                                                Row(
                                                  children: [
                                                    detailOlahan['thumbnail'] !=
                                                                null &&
                                                            detailOlahan[
                                                                    'thumbnail']
                                                                .isNotEmpty
                                                        ? ClipOval(
                                                            child:
                                                                Image.network(
                                                              detailOlahan[
                                                                      'thumbnail'] ??
                                                                  '',
                                                              fit: BoxFit.cover,
                                                              width: 128,
                                                              height: 128,
                                                            ),
                                                          )
                                                        : const Icon(
                                                            Icons.image,
                                                            size: 64),
                                                    const SizedBox(width: 16),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "${detailOlahan['title']}",
                                                            style: const TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                            maxLines: 1,
                                                          ),
                                                          SizedBox(
                                                            height: 8,
                                                          ),
                                                          Text(
                                                            "${detailOlahan['description']}",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .white),
                                                            maxLines: 2,
                                                          ),
                                                          const SizedBox(
                                                              height: 8),
                                                          InkWell(
                                                            onTap: () {
                                                              int id = int.tryParse(
                                                                      detailOlahan[
                                                                              'id']
                                                                          .toString()) ??
                                                                  0;
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      DetailOlahanPage(
                                                                          id: id),
                                                                ),
                                                              );
                                                            },
                                                            child: Container(
                                                              height: 32,
                                                              width: 160,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
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
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                : const Center(
                                    child: NoFoundCustom(
                                      message: "Olahan Kosong",
                                      subMessage:
                                          "Olahan yang kamu cari lagi kosong nih!",
                                    ),
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
        },
      ),
    );
  }
}
