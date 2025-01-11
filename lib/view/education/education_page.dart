import 'package:agrolyn_web/provider/home_notifier.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/utils/assets_path.dart';
import 'package:agrolyn_web/utils/responsive.dart';
import 'package:agrolyn_web/view/education/detail_article.dart';
import 'package:agrolyn_web/view/recipe/recipe_page.dart';
import 'package:agrolyn_web/widget/footer.dart';
import 'package:agrolyn_web/widget/navbar/nav_drawer.dart';
import 'package:agrolyn_web/widget/navbar/navbar_desktop.dart';
import 'package:agrolyn_web/widget/no_found_custom.dart';
import 'package:agrolyn_web/widget/typography.dart';
import 'package:agrolyn_web/widget/video_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

class EducationPage extends StatelessWidget {
  const EducationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return ChangeNotifierProvider(
      create: (_) => HomeNotifier(context: context),
      child: Consumer<HomeNotifier>(builder: (context, value, child) {
        return Scaffold(
            backgroundColor: Colors.white,
            key: scaffoldKey,
            drawer: const NavDrawer(),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  NavbarDesktop(activePage: "Edukasi"),
                  ResponsiveRowColumn(
                    layout:
                        ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 32, bottom: 16),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                        text: "Temukan",
                                        style: headlineSecondaryTextStyle),
                                    TextSpan(
                                        text: " Artikel dan Video ",
                                        style:
                                            headlineSecondaryTextStyle.copyWith(
                                                color:
                                                    MyColors.primaryColorDark)),
                                    const TextSpan(
                                        text:
                                            "yang cocok untuk kamu yang ingin belajar lebih banyak tentang pertanian.",
                                        style: headlineSecondaryTextStyle),
                                    TextSpan(
                                        text: " Agrolyn Edukasi ",
                                        style:
                                            headlineSecondaryTextStyle.copyWith(
                                                color:
                                                    MyColors.primaryColorDark)),
                                    const TextSpan(
                                        text:
                                            " siap memberikan informasi yang kamu butuhkan.",
                                        style: headlineSecondaryTextStyle),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            ResponsiveRowColumnItem(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/article');
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                            MyColors.primaryColorDark),
                                    overlayColor:
                                        WidgetStateProperty.resolveWith<Color>(
                                            (Set<WidgetState> states) {
                                      if (states
                                          .contains(WidgetState.hovered)) {
                                        return MyColors.primaryColor;
                                      }
                                      if (states
                                              .contains(WidgetState.focused) ||
                                          states
                                              .contains(WidgetState.pressed)) {
                                        return MyColors.primaryColor;
                                      }
                                      return MyColors.primaryColorDark;
                                    }),
                                    shape: WidgetStateProperty.resolveWith<OutlinedBorder>(
                                        (Set<WidgetState> states) {
                                      if (states
                                              .contains(WidgetState.focused) ||
                                          states
                                              .contains(WidgetState.pressed)) {
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
                                    side: WidgetStateProperty.resolveWith<
                                        BorderSide>((Set<WidgetState> states) {
                                      if (states
                                              .contains(WidgetState.focused) ||
                                          states
                                              .contains(WidgetState.pressed)) {
                                        return const BorderSide(
                                            width: 3,
                                            color: buttonPrimaryPressedOutline);
                                      }
                                      return const BorderSide(
                                          width: 3, color: Colors.white);
                                    })),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 8),
                                      child: Icon(
                                        Icons.article_rounded,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "Artikel Selengkapnya",
                                      style: buttonTextStyle.copyWith(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            value.articles.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: Responsive.isDesktop(context)
                                          ? 3
                                          : Responsive.isTablet(context)
                                              ? 4
                                              : 2, // Jumlah kolom,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:
                                            Responsive.isDesktop(context)
                                                ? 3
                                                : Responsive.isTablet(context)
                                                    ? 2
                                                    : 1, // Jumlah kolom
                                        crossAxisSpacing: 8,
                                        mainAxisExtent:
                                            Responsive.isMobile(context)
                                                ? 230
                                                : 232,
                                        childAspectRatio: Responsive
                                                .isDesktopLarge(context)
                                            ? 4 / 2.5
                                            : Responsive.isDesktop(context)
                                                ? 4 / 2.3
                                                : Responsive.isTablet(context)
                                                    ? 3 / 4
                                                    : 2 /
                                                        3, // Rasio ukuran grid (lebar vs tinggi)
                                      ),
                                      itemBuilder: (context, index) {
                                        var article = value.articles[index];

                                        return InkWell(
                                          key: ValueKey(article['title']),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailArticle(
                                                  article: article,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(12.0),
                                            margin: const EdgeInsets.only(
                                                bottom: 8),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  blurRadius: 6,
                                                  spreadRadius: 2,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Image.network(
                                                    article['thumbnail'],
                                                    height: 100,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                const SizedBox(height: 12),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                            Icons
                                                                .location_on_outlined,
                                                            size: 11,
                                                            color: Colors.grey,
                                                          ),
                                                          const SizedBox(
                                                              width: 4),
                                                          Text(
                                                            article['location'],
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 2),
                                                      Text(
                                                        article['title'],
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      Text(
                                                        article['description'],
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ))
                                : const Center(
                                    child: NoFoundCustom(
                                    message: "No Articles Available",
                                    subMessage:
                                        "We can't find any articles for you",
                                  )),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 32, bottom: 16),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                        text: "Temukan",
                                        style: headlineSecondaryTextStyle),
                                    TextSpan(
                                        text: " Artikel dan Video ",
                                        style:
                                            headlineSecondaryTextStyle.copyWith(
                                                color:
                                                    MyColors.primaryColorDark)),
                                    const TextSpan(
                                        text:
                                            "yang cocok untuk kamu yang ingin belajar lebih banyak tentang pertanian.",
                                        style: headlineSecondaryTextStyle),
                                    TextSpan(
                                        text: " Agrolyn Edukasi ",
                                        style:
                                            headlineSecondaryTextStyle.copyWith(
                                                color:
                                                    MyColors.primaryColorDark)),
                                    const TextSpan(
                                        text:
                                            " siap memberikan informasi yang kamu butuhkan.",
                                        style: headlineSecondaryTextStyle),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            ResponsiveRowColumnItem(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/video');
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                            MyColors.primaryColorDark),
                                    overlayColor:
                                        WidgetStateProperty.resolveWith<Color>(
                                            (Set<WidgetState> states) {
                                      if (states
                                          .contains(WidgetState.hovered)) {
                                        return MyColors.primaryColor;
                                      }
                                      if (states
                                              .contains(WidgetState.focused) ||
                                          states
                                              .contains(WidgetState.pressed)) {
                                        return MyColors.primaryColor;
                                      }
                                      return MyColors.primaryColorDark;
                                    }),
                                    shape: WidgetStateProperty.resolveWith<OutlinedBorder>(
                                        (Set<WidgetState> states) {
                                      if (states
                                              .contains(WidgetState.focused) ||
                                          states
                                              .contains(WidgetState.pressed)) {
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
                                    side: WidgetStateProperty.resolveWith<
                                        BorderSide>((Set<WidgetState> states) {
                                      if (states
                                              .contains(WidgetState.focused) ||
                                          states
                                              .contains(WidgetState.pressed)) {
                                        return const BorderSide(
                                            width: 3,
                                            color: buttonPrimaryPressedOutline);
                                      }
                                      return const BorderSide(
                                          width: 3, color: Colors.white);
                                    })),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 8),
                                      child: Icon(
                                        Icons.camera_alt_rounded,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "Video Selengkapnya",
                                      style: buttonTextStyle.copyWith(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            value.articles.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: Responsive.isDesktop(context)
                                          ? 3
                                          : Responsive.isTablet(context)
                                              ? 4
                                              : 2, // Jumlah kolom,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:
                                            Responsive.isDesktop(context)
                                                ? 3
                                                : Responsive.isTablet(context)
                                                    ? 2
                                                    : 1, // Jumlah kolom
                                        crossAxisSpacing: 8,
                                        mainAxisExtent:
                                            Responsive.isMobile(context)
                                                ? 305
                                                : 305,
                                        childAspectRatio: Responsive
                                                .isDesktopLarge(context)
                                            ? 4 / 2.5
                                            : Responsive.isDesktop(context)
                                                ? 4 / 2.3
                                                : Responsive.isTablet(context)
                                                    ? 3 / 4
                                                    : 2 /
                                                        3, // Rasio ukuran grid (lebar vs tinggi)
                                      ),
                                      itemBuilder: (context, index) {
                                        final video = value.videos[index];
                                        return Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 8),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                blurRadius: 5,
                                                spreadRadius: 2,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(16),
                                                  topRight: Radius.circular(16),
                                                ),
                                                child: Image.network(
                                                  video['thumbnail'],
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                  height: 150,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      video['title'],
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      video['description'],
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    InkWell(
                                                      onTap: () {
                                                        showVideoDialog(
                                                          context,
                                                          video['link_yt'],
                                                        );
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        width: double.infinity,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: MyColors
                                                              .primaryColorDark,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.2),
                                                              offset:
                                                                  const Offset(
                                                                      0, 4),
                                                              blurRadius: 8,
                                                            ),
                                                          ],
                                                        ),
                                                        child: const Text(
                                                          "Lihat",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : const Center(
                                    child: NoFoundCustom(
                                    message: "No Video Available",
                                    subMessage:
                                        "We can't find any videos for you",
                                  )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Footer()
                ],
              ),
            ));
      }),
    );
  }
}
