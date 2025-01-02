import 'package:agrolyn_web/provider/detail_olahan_notifier.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/widget/footer.dart';
import 'package:agrolyn_web/widget/no_found_custom.dart';
import 'package:flutter/material.dart';
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
                                                  "${value.detailOlahans['title'] ?? 'Unknown'}",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                                const SizedBox(height: 8),
                                                // Description
                                                Text(
                                                  "${value.detailOlahans['description'] ?? 'Unknown'}",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                ),
                                                const SizedBox(height: 8),
                                                // Ingredients
                                                Text(
                                                  "${value.detailOlahans['ingredients'] ?? 'Unknown'}",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                ),
                                                const SizedBox(height: 8),
                                                // Steps
                                                Text(
                                                  "${value.detailOlahans['steps'] ?? 'Unknown'}",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                ),
                                                const SizedBox(height: 16),
                                                // View more button
                                                InkWell(
                                                  onTap: () {
                                                    // Optional: Handle the tap event
                                                  },
                                                  child: Container(
                                                    height: 36,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
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
