import 'package:agrolyn_web/provider/detail_olahan_notifier.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/utils/assets_path.dart';
import 'package:agrolyn_web/widget/footer.dart';
import 'package:agrolyn_web/widget/no_found_custom.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

class DetailOlahanPage extends StatelessWidget {
  final int id;
  const DetailOlahanPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailOlahanNotifier(id, context: context),
      child: Consumer<DetailOlahanNotifier>(
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
                          ResponsiveRowColumn(
                            layout: ResponsiveBreakpoints.of(context)
                                    .smallerThan(DESKTOP)
                                ? ResponsiveRowColumnType.COLUMN
                                : ResponsiveRowColumnType.ROW,
                            rowCrossAxisAlignment: CrossAxisAlignment.start,
                            columnCrossAxisAlignment: CrossAxisAlignment.center,
                            columnMainAxisSize: MainAxisSize.min,
                            rowPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 40),
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
                                    // Dish 1: Eggs Breakfast
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black12,
                                              spreadRadius: 2,
                                              blurRadius: 5)
                                        ],
                                      ),
                                      padding: const EdgeInsets.all(16),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            // Thumbnail image
                                            ClipOval(
                                              child: value.detailOlahans[
                                                              'thumbnail'] !=
                                                          null &&
                                                      value
                                                          .detailOlahans[
                                                              'thumbnail']
                                                          .isNotEmpty
                                                  ? Image.network(
                                                      value.detailOlahans[
                                                              'thumbnail'] ??
                                                          '',
                                                      fit: BoxFit.cover,
                                                      width: 128,
                                                      height: 128,
                                                    )
                                                  : const Icon(Icons.image,
                                                      size: 64),
                                            ),
                                            const SizedBox(height: 8),
                                            // Dish title
                                            Text(
                                              "${value.detailOlahans['title'] ?? 'Unknownn'}",
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 4),
                                            // Dish title
                                            Text(
                                              "${value.detailOlahans['description'] ?? 'Unknown'}",
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Repeat the same for other dishes (Macaroni in sauce, Spaghetti, Double Croissant)
                              // Example for Spaghetti:
                              ResponsiveRowColumnItem(
                                rowFlex: 1,
                                rowFit: FlexFit.tight,
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black12,
                                              spreadRadius: 2,
                                              blurRadius: 5)
                                        ],
                                      ),
                                      padding: const EdgeInsets.all(16),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Thumbnail image
                                            Center(
                                              child: ClipOval(
                                                child: value.detailOlahans[
                                                                'thumbnail'] !=
                                                            null &&
                                                        value
                                                            .detailOlahans[
                                                                'thumbnail']
                                                            .isNotEmpty
                                                    ? Image.network(
                                                        value.detailOlahans[
                                                                'thumbnail'] ??
                                                            '',
                                                        fit: BoxFit.cover,
                                                        width: 128,
                                                        height: 128,
                                                      )
                                                    : const Icon(Icons.image,
                                                        size: 64),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              "Bahan-bahan membuat ${value.detailOlahans['title'] ?? 'Unknownn'}",
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 4),
                                            // Dish title
                                            Text(
                                              "${value.detailOlahans['ingredients'] ?? 'Unknown'}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          value.detailOlahans.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                    height: 280,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: MyColors.primaryColorDark,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                        )
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        children: [
                                          // Thumbnail image
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: value.detailOlahans[
                                                            'thumbnail'] !=
                                                        null &&
                                                    value
                                                        .detailOlahans[
                                                            'thumbnail']
                                                        .isNotEmpty
                                                ? Image.network(
                                                    value.detailOlahans[
                                                            'thumbnail'] ??
                                                        '',
                                                    fit: BoxFit.cover,
                                                    width: 128,
                                                    height: 128,
                                                  )
                                                : const Icon(Icons.image,
                                                    size: 64),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                // Title
                                                Text(
                                                  "Langkah-langkah dalam pembuatan ${value.detailOlahans['title'] ?? 'Unknownn'}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  "${value.detailOlahans['steps'] ?? 'Unknown'}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : const Center(
                                  child: NoFoundCustom(
                                    message: "Olahan Tidak Ditemukan",
                                    subMessage:
                                        "Olahan yang kamu cari tidak ditemukan!",
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
