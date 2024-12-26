import 'package:agrolyn_web/provider/recipe_notifier.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/widget/no_found_custom.dart';
import 'package:agrolyn_web/widget/typography.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrolyn_web/widget/footer.dart';
import 'package:responsive_framework/responsive_framework.dart';

class DetailRecipe extends StatelessWidget {
  final Map<String, dynamic> recipe;
  const DetailRecipe({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RecipeNotifier(context: context),
      child: Consumer<RecipeNotifier>(
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
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8, left: 16, right: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      recipe['title'],
                                      style: headlineSecondaryTextStyle,
                                    ),
                                    const SizedBox(height: 4),
                                    RichText(
                                      text: TextSpan(
                                        style: bodyTextStyle,
                                        children: [
                                          const TextSpan(
                                              text: "Menu Kali Ini Adalah "),
                                          TextSpan(
                                            text: recipe['title'],
                                            style: bodyTextStyle,
                                          ),
                                          const TextSpan(
                                              text: " Resep Dari Agrolyn",
                                              style: bodyTextStyle),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Text(
                                      "Nutrisi",
                                      style: headlineSecondaryTextStyle,
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      height: 72,
                                      width: 144,
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 8),
                                          // Memastikan kolom menyesuaikan ruang yang ada
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Protein",
                                                  style: bodyTextStyle,
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.grey,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                          text:
                                                              "${recipe['protein']}",
                                                          style: TextStyle(
                                                              color: MyColors
                                                                  .primaryColorDark)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      height: 72,
                                      width: 144,
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 8),
                                          // Memastikan kolom menyesuaikan ruang yang ada
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Calories",
                                                  style: bodyTextStyle,
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.grey,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                          text:
                                                              "${recipe['calories']}",
                                                          style: TextStyle(
                                                              color: MyColors
                                                                  .primaryColorDark)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      height: 72,
                                      width: 144,
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 8),
                                          // Memastikan kolom menyesuaikan ruang yang ada
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Karbo",
                                                  style: bodyTextStyle,
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.grey,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                          text:
                                                              "${recipe['karbo']}",
                                                          style: TextStyle(
                                                              color: MyColors
                                                                  .primaryColorDark)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 24,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: "Apa sih ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text: recipe['title'],
                                            style: const TextStyle(
                                                color: Colors.green,
                                                decorationColor: Colors.green,
                                                decorationThickness: 2,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const TextSpan(
                                            text: " itu?",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "${recipe['description']}",
                                      style: bodyTextStyle,
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: "Bahan-bahan ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text: recipe['title'],
                                            style: const TextStyle(
                                                color: Colors.green,
                                                decorationColor: Colors.green,
                                                decorationThickness: 2,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const TextSpan(
                                              text: " Resep Dari Agrolyn",
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  decorationColor: Colors.green,
                                                  decorationThickness: 2,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "${recipe['ingredients']}",
                                      maxLines: 100,
                                      overflow: TextOverflow.ellipsis,
                                      style: bodyTextStyle,
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: "Langkah-langkah pembuatan ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text: recipe['title'],
                                            style: const TextStyle(
                                                color: Colors.green,
                                                decorationColor: Colors.green,
                                                decorationThickness: 2,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const TextSpan(
                                              text: " Resep Dari Agrolyn",
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  decorationColor: Colors.green,
                                                  decorationThickness: 2,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "${recipe['steps']}",
                                      maxLines: 100,
                                      overflow: TextOverflow.ellipsis,
                                      style: bodyTextStyle,
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 128,
                            right: 16,
                            child: recipe['img_recipe'] != null &&
                                    recipe['img_recipe'].isNotEmpty
                                ? ClipOval(
                                    child: Image.network(
                                      recipe['img_recipe'],
                                      fit: BoxFit.cover,
                                      width: 222,
                                      height: 222,
                                    ),
                                  )
                                : const NoFoundCustom(
                                    message: "Foto Kosong",
                                    subMessage: "Fotonya belum ada nih!",
                                  ),
                          )
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
