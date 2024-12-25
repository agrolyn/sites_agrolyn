import 'package:agrolyn_web/provider/home_notifier.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/view/community/community_page.dart';
import 'package:agrolyn_web/widget/typography.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

class RecipeSection extends StatelessWidget {
  const RecipeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeNotifier(context: context),
      child: Consumer<HomeNotifier>(builder: (context, value, child) {
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
                              text: "masakan yang cocok dari hasil tani kamu",
                              style: headlineSecondaryTextStyle),
                          TextSpan(
                              text: " Agrolyn Resep ",
                              style: headlineSecondaryTextStyle.copyWith(
                                  color: MyColors.primaryColorDark)),
                          const TextSpan(
                              text:
                                  " siap membantu kamu untuk mengexplore hasil tani kamu.",
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CommunityPage()),
                              );
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
                                            vertical: 16, horizontal: 64)),
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.restaurant,
                                  size: 24,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Lihat Selengkapnya",
                                  style: buttonTextStyle.copyWith(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  value.recipes.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            var recipe = value.recipes[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 160,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: MyColors.primaryColorDark,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      recipe['img_recipe'] != null &&
                                              recipe['img_recipe'].isNotEmpty
                                          ? ClipOval(
                                              child: Image.network(
                                                recipe['img_recipe'],
                                                fit: BoxFit.cover,
                                                width: 128,
                                                height: 128,
                                              ),
                                            )
                                          : const Text(
                                              "img recipe not available"),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${recipe['title']}",
                                              style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.white,
                                                height: 1.2,
                                                fontFamily: fontFamily,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              "${recipe['description']}",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                height: 1.5,
                                                fontFamily: "Roboto",
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            InkWell(
                                              onTap: () {
                                                // pushWithoutNavBar(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (context) =>
                                                //             DetailCommonRecipe(
                                                //                 recipe: recipe)));
                                              },
                                              child: Container(
                                                height: 32,
                                                width: 160,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: const Center(
                                                  child: Text(
                                                    "Lihat Selengkapnya",
                                                    style: TextStyle(
                                                      color: MyColors
                                                          .primaryColorDark,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
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
                          child: Text("No Recipes available"),
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
