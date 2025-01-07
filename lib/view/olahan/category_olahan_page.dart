import 'package:agrolyn_web/provider/olahan_notifier.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/utils/assets_path.dart';
import 'package:agrolyn_web/view/olahan/detail_olahan_page.dart';
import 'package:agrolyn_web/widget/footer.dart';
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
    return ChangeNotifierProvider(
      create: (_) => OlahanNotifier(idCat, context: context),
      child: Consumer<OlahanNotifier>(
        builder: (context, value, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: const TextSpan(
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.black,
                                              decorationThickness: 2,
                                              fontWeight: FontWeight.bold),
                                          children: [
                                            TextSpan(
                                              text:
                                                  "Mulai Olah Bahan Masak Kamu Jadi Aneka Masakan",
                                            ),
                                            TextSpan(
                                              text: " Nusantara ",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  color:
                                                      MyColors.primaryColorDark,
                                                  decorationThickness: 2,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(text: " Terpopuler"),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      RichText(
                                        text: const TextSpan(
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              decorationThickness: 2,
                                              fontWeight: FontWeight.normal),
                                          children: [
                                            TextSpan(
                                              text:
                                                  "Dengan berbagai resep masakan yang mudah diikuti, kamu bisa mengubah bahan masak sederhana menjadi hidangan lezat khas",
                                            ),
                                            TextSpan(
                                              text: " Nusantara ",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color:
                                                      MyColors.primaryColorDark,
                                                  decorationThickness: 2,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(text: " Terpopuler"),
                                          ],
                                        ),
                                      ),
                                    ],
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
                          const SizedBox(height: 16),
                          value.detailOlahans.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
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
                                                          child: Image.network(
                                                            detailOlahan[
                                                                    'thumbnail'] ??
                                                                '',
                                                            fit: BoxFit.cover,
                                                            width: 128,
                                                            height: 128,
                                                          ),
                                                        )
                                                      : const Icon(Icons.image,
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
                                                          style:
                                                              const TextStyle(
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
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16,
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
                                                            child: const Center(
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
                                              SizedBox(
                                                height: 16,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        // Text(
                                                        //   "${detailOlahan['description']}",
                                                        //   overflow: TextOverflow
                                                        //       .ellipsis,
                                                        //   style:
                                                        //       const TextStyle(
                                                        //           fontSize: 16,
                                                        //           color: Colors
                                                        //               .white),
                                                        //   maxLines: 2,
                                                        // ),
                                                        // const SizedBox(
                                                        //     height: 2),
                                                        // Text(
                                                        //   "Bahan Bahan",
                                                        //   overflow: TextOverflow
                                                        //       .ellipsis,
                                                        //   style:
                                                        //       const TextStyle(
                                                        //           fontSize: 16,
                                                        //           fontWeight:
                                                        //               FontWeight
                                                        //                   .bold,
                                                        //           color: Colors
                                                        //               .white),
                                                        // ),
                                                        // const SizedBox(
                                                        //     height: 2),
                                                        // Text(
                                                        //   "${detailOlahan['ingredients']}",
                                                        //   overflow: TextOverflow
                                                        //       .ellipsis,
                                                        //   style:
                                                        //       const TextStyle(
                                                        //           fontSize: 14,
                                                        //           color: Colors
                                                        //               .white),
                                                        //   maxLines: 3,
                                                        // ),
                                                        // const SizedBox(
                                                        //     height: 2),
                                                        // Text(
                                                        //   "Langkah-Langkah",
                                                        //   overflow: TextOverflow
                                                        //       .ellipsis,
                                                        //   style:
                                                        //       const TextStyle(
                                                        //           fontWeight:
                                                        //               FontWeight
                                                        //                   .bold,
                                                        //           fontSize: 14,
                                                        //           color: Colors
                                                        //               .white),
                                                        // ),
                                                        // const SizedBox(
                                                        //     height: 2),
                                                        // Text(
                                                        //   "${detailOlahan['steps']}",
                                                        //   overflow: TextOverflow
                                                        //       .ellipsis,
                                                        //   style:
                                                        //       const TextStyle(
                                                        //           fontSize: 14,
                                                        //           color: Colors
                                                        //               .white),
                                                        //   maxLines: 3,
                                                        // ),
                                                        // SizedBox(
                                                        //   height: 16,
                                                        // )
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
          );
        },
      ),
    );
  }
}
