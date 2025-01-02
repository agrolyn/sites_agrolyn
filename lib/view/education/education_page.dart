import 'package:agrolyn_web/provider/home_notifier.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/utils/assets_path.dart';
import 'package:agrolyn_web/utils/date.dart';
import 'package:agrolyn_web/view/education/detail_article.dart';
import 'package:agrolyn_web/widget/footer.dart';
import 'package:agrolyn_web/widget/no_found_custom.dart';
import 'package:agrolyn_web/widget/video_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

class EducationPage extends StatelessWidget {
  const EducationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeNotifier(context: context),
      child: Consumer<HomeNotifier>(builder: (context, value, child) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.article_outlined),
                        SizedBox(width: 5),
                        Text('Artikel'),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.video_library_outlined),
                        SizedBox(width: 5),
                        Text('Video'),
                      ],
                    ),
                  ),
                ],
                indicatorColor: MyColors.primaryColorDark,
                labelColor: MyColors.primaryColorDark,
                unselectedLabelColor: Colors.grey,
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ResponsiveRowColumn(
                    layout:
                        ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
                            ? ResponsiveRowColumnType.COLUMN
                            : ResponsiveRowColumnType.ROW,
                    rowCrossAxisAlignment: CrossAxisAlignment.start,
                    columnCrossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ResponsiveRowColumnItem(
                        rowFlex: 1,
                        rowFit: FlexFit.tight,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 1,
                          child: TabBarView(
                            children: [
                              // Artikel Section
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
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
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 200,
                                            width: 200,
                                            child: Lottie.asset(
                                                ImageAssets.article),
                                          ),
                                        ],
                                      ),
                                    ),
                                    value.articles.isNotEmpty
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: value.articles.length,
                                              itemBuilder: (context, index) {
                                                var article =
                                                    value.articles[index];
                                                return InkWell(
                                                  key: ValueKey(
                                                      article['title']),
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
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 8),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black
                                                              .withOpacity(0.1),
                                                          blurRadius: 6,
                                                          spreadRadius: 2,
                                                          offset: const Offset(
                                                              0, 2),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          child: Image.network(
                                                            article[
                                                                'thumbnail'],
                                                            height: 100,
                                                            width: 70,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 12),
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
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 4),
                                                                  Text(
                                                                    article[
                                                                        'location'],
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .grey,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                  height: 2),
                                                              Text(
                                                                article[
                                                                    'title'],
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                              Text(
                                                                article[
                                                                    'description'],
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                              const SizedBox(
                                                                  height: 4),
                                                              Row(
                                                                children: [
                                                                  const Icon(
                                                                    Icons
                                                                        .calendar_month_outlined,
                                                                    size: 11,
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 4),
                                                                  FutureBuilder(
                                                                    future: formatRelativeTime(
                                                                        article[
                                                                            "released_date"]),
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      if (snapshot
                                                                              .connectionState ==
                                                                          ConnectionState
                                                                              .waiting) {
                                                                        return const CircularProgressIndicator();
                                                                      } else if (snapshot
                                                                          .hasError) {
                                                                        return Text(
                                                                            "Error: ${snapshot.error}");
                                                                      } else if (snapshot
                                                                          .hasData) {
                                                                        return Text(
                                                                          snapshot
                                                                              .data
                                                                              .toString(),
                                                                          style: const TextStyle(
                                                                              fontSize: 12,
                                                                              color: Colors.grey),
                                                                        );
                                                                      }
                                                                      return const Text(
                                                                          "No data available");
                                                                    },
                                                                  ),
                                                                ],
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
                                            subMessage:
                                                "We can't find any articles for you",
                                          )),
                                    const Footer()
                                  ],
                                ),
                              ),
                              // Video Section
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            height: 200,
                                            width: 200,
                                            child: Lottie.asset(
                                                ImageAssets.videos),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
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
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: MyColors
                                                              .primaryColorDark),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 16),
                                                const Text(
                                                  "Tontoan Edukasi Pertanian Terbaik",
                                                  maxLines: 3,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                const Text(
                                                  "Tonton berbagai tontonan edukasi menarik tentang pertanian di Agrolyn Video Edukasi",
                                                  maxLines: 3,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: value.videos.length,
                                        itemBuilder: (context, index) {
                                          final video = value.videos[index];
                                          return Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 8),
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
                                                    topLeft:
                                                        Radius.circular(16),
                                                    topRight:
                                                        Radius.circular(16),
                                                  ),
                                                  child: Image.network(
                                                    video['thumbnail'],
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                    height: 150,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        video['title'],
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                                          width:
                                                              double.infinity,
                                                          alignment:
                                                              Alignment.center,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: MyColors
                                                                .primaryColorDark,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
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
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
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
                                    ),
                                    const Footer()
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
