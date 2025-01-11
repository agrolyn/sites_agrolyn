import 'package:agrolyn_web/provider/home_notifier.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/utils/assets_path.dart';
import 'package:agrolyn_web/utils/responsive.dart';
import 'package:agrolyn_web/view/education/detail_article.dart';
import 'package:agrolyn_web/widget/footer.dart';
import 'package:agrolyn_web/widget/navbar/nav_drawer.dart';
import 'package:agrolyn_web/widget/navbar/navbar_desktop.dart';
import 'package:agrolyn_web/widget/no_found_custom.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return ChangeNotifierProvider(
      create: (_) => HomeNotifier(context: context),
      child: Consumer<HomeNotifier>(
        builder: (context, value, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            key: scaffoldKey,
            drawer: const NavDrawer(),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  NavbarDesktop(activePage: ""),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: InkWell(
                      onTap: () =>
                          Navigator.pushReplacementNamed(context, '/education'),
                      child: Row(children: [
                        const Icon(Icons.arrow_back),
                        const SizedBox(width: 22),
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
                    rowPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    columnPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    columnSpacing: 50,
                    rowSpacing: 50,
                    children: [
                      ResponsiveRowColumnItem(
                        rowFlex: 1,
                        rowFit: FlexFit.tight,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              ImageAssets.logo,
                                              height: 24,
                                              width: 24,
                                            ),
                                            const SizedBox(width: 4),
                                            const Text(
                                              'Agrolyn',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: MyColors
                                                      .primaryColorDark),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        const Text(
                                          "Berita, Artikel, dan Bacaan Menarik",
                                          maxLines: 3,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          "Baca berbagai bacaan menarik tentang pertanian di Agrolyn Artikel",
                                          maxLines: 3,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 200,
                                    width: 200,
                                    child: Lottie.asset(ImageAssets.article),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  value.articles.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: value.articles.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: Responsive.isDesktop(context)
                                  ? 3
                                  : Responsive.isTablet(context)
                                      ? 2
                                      : 1, // Jumlah kolom
                              crossAxisSpacing: 8,
                              mainAxisExtent:
                                  Responsive.isMobile(context) ? 230 : 240,
                              childAspectRatio: Responsive.isDesktopLarge(
                                      context)
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
                                      builder: (context) => DetailArticle(
                                        article: article,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(12.0),
                                  margin: const EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 6,
                                        spreadRadius: 2,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
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
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.location_on_outlined,
                                                  size: 11,
                                                  color: Colors.grey,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  article['location'],
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              article['title'],
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              article['description'],
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : const Center(
                          child: NoFoundCustom(
                            message: "No Articles Available",
                            subMessage: "We can't find any articles for you",
                          ),
                        ),
                  Footer()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
