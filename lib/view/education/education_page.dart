import 'dart:ui';

import 'package:agrolyn_web/provider/home_notifier.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/utils/assets_path.dart';
import 'package:agrolyn_web/utils/responsive.dart';
import 'package:agrolyn_web/view/chatbot/chatbot.dart';
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
    void showPopup(BuildContext context) {
      showDialog(
        context: context,
        barrierColor: Colors.black54, // Latar belakang semi-transparan
        builder: (context) {
          final isMobile =
              MediaQuery.of(context).size.width < 600; // Deteksi mobile
          return Stack(
            children: [
              Align(
                alignment: Alignment.bottomRight, // Posisi di bawah kanan
                child: Container(
                  width: isMobile
                      ? MediaQuery.of(context).size.width *
                          0.9 // Hampir penuh pada mobile
                      : 400, // Lebar tetap untuk desktop/tablet
                  height: isMobile
                      ? MediaQuery.of(context).size.height *
                          0.8 // Hampir penuh pada mobile
                      : 550, // Tinggi tetap untuk desktop/tablet
                  margin: const EdgeInsets.only(
                    bottom: 80, // Jarak dari bawah (di atas FAB)
                    right: 16, // Jarak dari tepi kanan
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white, // Warna latar popup
                    borderRadius:
                        BorderRadius.circular(12), // Membulatkan sudut
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26, // Warna bayangan
                        blurRadius: 10, // Intensitas blur bayangan
                        offset: Offset(0, 4), // Posisi bayangan
                      ),
                    ],
                  ),
                  child: const Chatbot(),
                ),
              ),
            ],
          );
        },
      );
    }

    return ChangeNotifierProvider(
      create: (_) => HomeNotifier(context: context),
      child: Consumer<HomeNotifier>(builder: (context, value, child) {
        return Scaffold(
            backgroundColor: Colors.white,
            key: scaffoldKey,
            floatingActionButton: FloatingActionButton(
              onPressed: () => showPopup(context),
              backgroundColor: MyColors.secondaryColorDark, // Memanggil popup
              child: const Icon(
                Icons.smart_toy,
                color: Colors.white,
              ),
            ),
            drawer: const NavDrawer(),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  NavbarDesktop(activePage: "Edukasi"),
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
                          ImageAssets.bgEdu,
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
                                filter:
                                    ImageFilter.blur(sigmaX: 20, sigmaY: 20),
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
                                          horizontal:
                                              Responsive.isMobile(context)
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
                                            "Edukasi Pertanian",
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
                                            "Tingkatkan Pengetahuanmu Tentang Pertanian Berkelanjutan Melalui Artikel dan Video Edukasi",
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
                                        text: " Artikel ",
                                        style:
                                            headlineSecondaryTextStyle.copyWith(
                                                color:
                                                    MyColors.primaryColorDark)),
                                    const TextSpan(
                                        text:
                                            "yang cocok untuk kamu yang ingin belajar lebih banyak tentang pertanian.",
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
                                        text: " Video ",
                                        style:
                                            headlineSecondaryTextStyle.copyWith(
                                                color:
                                                    MyColors.primaryColorDark)),
                                    const TextSpan(
                                        text:
                                            "yang cocok untuk kamu yang ingin belajar lebih banyak tentang pertanian.",
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
                            const SizedBox(
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
                  const Footer()
                ],
              ),
            ));
      }),
    );
  }
}
