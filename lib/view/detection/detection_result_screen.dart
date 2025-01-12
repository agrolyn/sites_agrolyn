import 'package:agrolyn_web/provider/detection_notifier.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/utils/assets_path.dart';
import 'package:agrolyn_web/utils/responsive.dart';
import 'package:agrolyn_web/widget/navbar/nav_drawer.dart';
import 'package:agrolyn_web/widget/navbar/navbar_desktop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

class DetectionResultScreen extends StatelessWidget {
  const DetectionResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        backgroundColor: Colors.white,
        key: scaffoldKey,
        drawer: const NavDrawer(),
        body: ChangeNotifierProvider(
            create: (_) =>
                DetectionNotifier(context: context, page: "result-prediction"),
            child: Consumer<DetectionNotifier>(
                builder: (context, value, child) => SafeArea(
                      bottom: false,
                      child: SingleChildScrollView(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                NavbarDesktop(activePage: ""),
                                InkWell(
                                  onTap: () => Navigator.pushReplacementNamed(
                                      context, "/upload-detection"),
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      top:
                                          Responsive.isMobile(context) ? 8 : 16,
                                    ),
                                    width: Responsive.widthScreen(context),
                                    padding: const EdgeInsets.all(8),
                                    child: Row(children: [
                                      const Icon(Icons.arrow_back),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Text(
                                        "Hasil Deteksi",
                                        style: TextStyle(
                                          fontSize: Responsive.isMobile(context)
                                              ? 15
                                              : 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  margin: EdgeInsets.only(
                                      top:
                                          Responsive.isMobile(context) ? 8 : 16,
                                      left:
                                          Responsive.isMobile(context) ? 2 : 16,
                                      right: Responsive.isMobile(context)
                                          ? 2
                                          : 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32),
                                    border: Border.all(color: Colors.green),
                                  ),
                                  child: ResponsiveRowColumn(
                                      layout: ResponsiveBreakpoints.of(context)
                                              .smallerThan(DESKTOP)
                                          ? ResponsiveRowColumnType.COLUMN
                                          : ResponsiveRowColumnType.ROW,
                                      rowCrossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      columnCrossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      columnMainAxisSize: MainAxisSize.min,
                                      rowPadding: const EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 0),
                                      columnPadding: const EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 0),
                                      children: [
                                        ResponsiveRowColumnItem(
                                            rowFlex: 1,
                                            rowFit: FlexFit.tight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Column(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    child: value.resultPrediction[
                                                                "img_detection"] !=
                                                            null
                                                        ? Image.network(
                                                            value.resultPrediction[
                                                                "img_detection"]!,
                                                            width: Responsive
                                                                    .isMobile(
                                                                        context)
                                                                ? double
                                                                    .infinity
                                                                : Responsive
                                                                    .widthScreen(
                                                                        context),
                                                            height: Responsive
                                                                    .isMobile(
                                                                        context)
                                                                ? 180
                                                                : Responsive.heightScreen(
                                                                        context) *
                                                                    0.6,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Image.asset(
                                                            ImageAssets
                                                                .community,
                                                            width:
                                                                double.infinity,
                                                            height: 180,
                                                            fit: BoxFit.cover,
                                                          ),
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Icon(
                                                          Icons.spa_sharp),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      const SizedBox(
                                                        height: 16,
                                                      ),
                                                      Text(
                                                          value.resultPrediction[
                                                                      'prediction'][
                                                                  "dis_indo_name"]! +
                                                              " (" +
                                                              value.resultPrediction[
                                                                      'prediction']
                                                                  [
                                                                  "dis_name"]! +
                                                              ")",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .black))
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  Text(
                                                    value.resultPrediction[
                                                            'prediction']
                                                        ["description"]!,
                                                    style: TextStyle(
                                                        fontSize:
                                                            Responsive.isMobile(
                                                                    context)
                                                                ? 14
                                                                : 16),
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                ],
                                              ),
                                            )),
                                        ResponsiveRowColumnItem(
                                            rowFlex: 1,
                                            rowFit: FlexFit.tight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Column(
                                                children: [
                                                  const Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(Icons.list_alt),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      SizedBox(
                                                        height: 16,
                                                      ),
                                                      Text("Cara Penanganan",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.black))
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 8),
                                                      child: Text(
                                                          value.resultPrediction[
                                                                  'prediction']
                                                              ["handling"]!,
                                                          style: TextStyle(
                                                              fontSize: Responsive
                                                                      .isMobile(
                                                                          context)
                                                                  ? 14
                                                                  : 16))),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  ElevatedButton(
                                                      style: ButtonStyle(
                                                        minimumSize:
                                                            WidgetStateProperty
                                                                .all(const Size(
                                                                    double
                                                                        .maxFinite,
                                                                    50)),
                                                        backgroundColor:
                                                            WidgetStateProperty
                                                                .all(MyColors
                                                                    .primaryColorDark),
                                                        foregroundColor:
                                                            WidgetStateProperty
                                                                .all(Colors
                                                                    .white),
                                                      ),
                                                      onPressed: () {
                                                        Navigator
                                                            .pushReplacementNamed(
                                                                context,
                                                                "/community");
                                                      },
                                                      child: const Text(
                                                          "Diskusikan Lebih lanjut di Komunitas",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 16))),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  ElevatedButton(
                                                      style: ButtonStyle(
                                                        minimumSize:
                                                            WidgetStateProperty
                                                                .all(const Size(
                                                                    double
                                                                        .maxFinite,
                                                                    50)),
                                                        backgroundColor:
                                                            WidgetStateProperty
                                                                .all(Colors
                                                                    .white),
                                                        foregroundColor:
                                                            WidgetStateProperty
                                                                .all(MyColors
                                                                    .primaryColorDark),
                                                        side: WidgetStateProperty
                                                            .all(const BorderSide(
                                                                width: 1,
                                                                color: MyColors
                                                                    .primaryColorDark)),
                                                      ),
                                                      onPressed: () {
                                                        Navigator
                                                            .pushReplacementNamed(
                                                                context,
                                                                "/home");
                                                      },
                                                      child: const Text(
                                                          "Kembali Ke Beranda",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 16)))
                                                ],
                                              ),
                                            ))
                                      ]),
                                ),
                              ])),
                    ))));
  }
}
