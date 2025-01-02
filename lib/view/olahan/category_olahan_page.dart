import 'package:agrolyn_web/provider/olahan_notifier.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/view/olahan/detail_olahan_page.dart';
import 'package:agrolyn_web/widget/footer.dart';
import 'package:agrolyn_web/widget/no_found_custom.dart';
import 'package:flutter/material.dart';
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
                                        height: 256,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: MyColors.primaryColorDark,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              detailOlahan['thumbnail'] !=
                                                          null &&
                                                      detailOlahan['thumbnail']
                                                          .isNotEmpty
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
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
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      maxLines: 1,
                                                      "${detailOlahan['title']}",
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                    const SizedBox(height: 2),
                                                    Text(
                                                      maxLines: 1,
                                                      "${detailOlahan['description']}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                    ),
                                                    const SizedBox(height: 2),
                                                    Text(
                                                      maxLines: 1,
                                                      "${detailOlahan['ingredients']}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                    ),
                                                    const SizedBox(height: 2),
                                                    Text(
                                                      maxLines: 1,
                                                      "${detailOlahan['steps']}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    InkWell(
                                                      onTap: () {
                                                        // Mengambil id dari detailOlahan dan memastikan itu adalah integer
                                                        int id = int.tryParse(
                                                                detailOlahan[
                                                                        'id']
                                                                    .toString()) ??
                                                            0;
                                                        print(
                                                            "Navigating to DetailOlahanPage with id: $id"); // Log untuk memastikan ID
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                DetailOlahanPage(
                                                                    id: id), // Mengirim id saja
                                                          ),
                                                        ).then((_) {
                                                          print(
                                                              "Navigated to DetailOlahanPage with id: $id");
                                                        });
                                                      },
                                                      child: Container(
                                                        height: 32,
                                                        width: 160,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
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
                                                                fontSize: 14,
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
                const Footer(), // Add Footer here
              ],
            ),
          );
        },
      ),
    );
  }
}
