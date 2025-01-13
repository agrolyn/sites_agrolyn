import 'package:agrolyn_web/provider/home_notifier.dart';
import 'package:agrolyn_web/provider/olahan_notifier.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/view/olahan/category_olahan_page.dart';
import 'package:agrolyn_web/view/recipe/detail_recipe.dart';
import 'package:agrolyn_web/view/recipe/recipe_page.dart';
import 'package:agrolyn_web/widget/no_found_custom.dart';
import 'package:agrolyn_web/widget/typography.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

class RecipeSection extends StatelessWidget {
  final int idCat;
  const RecipeSection({super.key, required this.idCat});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OlahanNotifier(idCat, context: context),
      child: Consumer<OlahanNotifier>(builder: (context, value, child) {
        return ResponsiveRowColumn(
          layout: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
              ? ResponsiveRowColumnType.COLUMN
              : ResponsiveRowColumnType.ROW,
          rowCrossAxisAlignment: CrossAxisAlignment.start,
          columnCrossAxisAlignment: CrossAxisAlignment.center,
          columnMainAxisSize: MainAxisSize.min,
          rowPadding: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 40), // Reduced padding for mobile
          columnPadding: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 40), // Adjusted padding
          columnSpacing: 50,
          rowSpacing: 50,
          children: [
            ResponsiveRowColumnItem(
              rowFlex: 1,
              rowFit: FlexFit.tight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 32, bottom: 16),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                              text: "Temukan",
                              style: headlineSecondaryTextStyle),
                          TextSpan(
                              text: " resep ",
                              style: headlineSecondaryTextStyle.copyWith(
                                  color: MyColors.primaryColorDark)),
                          const TextSpan(
                              text: "makanan yang cocok dari hasil tani kamu",
                              style: headlineSecondaryTextStyle),
                          TextSpan(
                              text: " Agrolyn Resep ",
                              style: headlineSecondaryTextStyle.copyWith(
                                  color: MyColors.primaryColorDark)),
                          const TextSpan(
                              text:
                                  " siap membantu kamu untuk mengeksplorasi hasil tani kamu.",
                              style: headlineSecondaryTextStyle),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8, top: 0),
                    child: ResponsiveRowColumn(
                      layout:
                          ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
                              ? ResponsiveRowColumnType.COLUMN
                              : ResponsiveRowColumnType.ROW,
                      rowMainAxisAlignment: MainAxisAlignment.center,
                      rowCrossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ResponsiveRowColumnItem(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, '/olahan');
                            },
                            style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    MyColors.primaryColorDark),
                                overlayColor:
                                    WidgetStateProperty.resolveWith<Color>(
                                        (Set<WidgetState> states) {
                                  if (states.contains(WidgetState.hovered)) {
                                    return MyColors.primaryColor;
                                  }
                                  if (states.contains(WidgetState.focused) ||
                                      states.contains(WidgetState.pressed)) {
                                    return MyColors.primaryColor;
                                  }
                                  return MyColors.primaryColorDark;
                                }),
                                shape: WidgetStateProperty.resolveWith<
                                    OutlinedBorder>((Set<WidgetState> states) {
                                  if (states.contains(WidgetState.focused) ||
                                      states.contains(WidgetState.pressed)) {
                                    return const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)));
                                  }
                                  return const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(16)));
                                }),
                                padding:
                                    WidgetStateProperty.all<EdgeInsetsGeometry>(
                                        const EdgeInsets.symmetric(
                                            vertical: 32, horizontal: 84)),
                                side:
                                    WidgetStateProperty.resolveWith<BorderSide>(
                                        (Set<WidgetState> states) {
                                  if (states.contains(WidgetState.focused) ||
                                      states.contains(WidgetState.pressed)) {
                                    return const BorderSide(
                                        width: 3,
                                        color: buttonPrimaryPressedOutline);
                                  }
                                  return const BorderSide(
                                      width: 3, color: Colors.white);
                                })),
                            child: Text(
                              "Selengkapnya",
                              style: buttonTextStyle.copyWith(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  value.olahans.isNotEmpty
                      ? GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: ResponsiveBreakpoints.of(context)
                                    .largerThan(TABLET)
                                ? 2
                                : 1,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            mainAxisExtent:
                                200, // Set the height for each grid item (adjust this value)
                            childAspectRatio:
                                2 / 2, // Adjust width-to-height ratio if needed
                          ),
                          itemCount: value.olahans.length,
                          itemBuilder: (BuildContext context, int index) {
                            var olahan = value.olahans[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: MyColors.primaryColorDark,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      olahan['thumbnail'] != null &&
                                              olahan['thumbnail'].isNotEmpty
                                          ? ClipOval(
                                              child: Image.network(
                                                olahan['thumbnail'] ?? '',
                                                fit: BoxFit.cover,
                                                width: 128,
                                                height: 128,
                                              ),
                                            )
                                          : const Icon(Icons.image, size: 64),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${olahan['label'] ?? 'Unknown'}",
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              "Tersedia berbagai olahan dari ${olahan['label'] ?? 'Olahan Tidak Diketahui'} yang bisa menjadi inspirasi untuk ide usaha kuliner kamu. Coba dan temukan resep terbaik untuk bisnismu!",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            ),
                                            const SizedBox(height: 8),
                                            InkWell(
                                              onTap: () {
                                                int idCat = int.tryParse(
                                                        olahan['id']
                                                            .toString()) ??
                                                    0;
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CategoryOlahanPage(
                                                            idCat: idCat),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                height: 32,
                                                width: 160,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: const Center(
                                                  child: Text(
                                                    "Lihat Selengkapnya",
                                                    style: TextStyle(
                                                        color: MyColors
                                                            .primaryColorDark,
                                                        fontSize: 14,
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
            ),
          ],
        );
      }),
    );
  }
}
