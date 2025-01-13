import 'package:agrolyn_web/provider/home_notifier.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/utils/assets_path.dart';
import 'package:agrolyn_web/utils/responsive.dart';
import 'package:agrolyn_web/widget/footer.dart';
import 'package:agrolyn_web/widget/navbar/navbar_desktop.dart';
import 'package:agrolyn_web/widget/no_found_custom.dart';
import 'package:agrolyn_web/widget/video_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeNotifier(context: context),
      child: Consumer<HomeNotifier>(
        builder: (context, value, child) {
          return Scaffold(
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
                      child: const Row(children: [
                        Icon(Icons.arrow_back),
                        SizedBox(width: 22),
                        Text("Kembali", style: TextStyle(fontSize: 20)),
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
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 200,
                                    width: 200,
                                    child: Lottie.asset(ImageAssets.videos),
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
                                            const SizedBox(width: 5),
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
                                          "Tonton Edukasi Pertanian Terbaik",
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
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: value.videos.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: Responsive.isDesktop(context)
                            ? 3
                            : Responsive.isTablet(context)
                                ? 2
                                : 1, // Jumlah kolom
                        crossAxisSpacing: 8,
                        mainAxisExtent:
                            Responsive.isMobile(context) ? 305 : 305,
                        childAspectRatio: Responsive.isDesktopLarge(context)
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
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
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
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      video['title'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      video['description'],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
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
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: MyColors.primaryColorDark,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              offset: const Offset(0, 4),
                                              blurRadius: 8,
                                            ),
                                          ],
                                        ),
                                        child: const Text(
                                          "Lihat",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
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
                  ),
                  const Footer(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
