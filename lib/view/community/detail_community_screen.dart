import 'package:agrolyn_web/provider/community_notifer.dart';
import 'package:agrolyn_web/utils/inter_prefs.dart';
import 'package:agrolyn_web/utils/responsive.dart';
import 'package:agrolyn_web/view/community/content_question_detail.dart';
import 'package:agrolyn_web/view/community/input_answer.dart';
import 'package:agrolyn_web/view/community/section_answers.dart';
import 'package:agrolyn_web/widget/navbar/nav_drawer.dart';
import 'package:agrolyn_web/widget/navbar/navbar.dart';
import 'package:agrolyn_web/widget/navbar/navbar_desktop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailCommunityScreen extends StatelessWidget {
  final int id;
  String? name;
  DetailCommunityScreen({super.key, required this.id, this.name}) {
    initialize();
  }

  void initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name');
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return ChangeNotifierProvider(
      create: (_) => CommunityNotifer(context: context),
      child: Consumer<CommunityNotifer>(
        builder: (context, value, child) {
          if (value.detailQuestion == null) {
            value.fetchDetailQuestion(id);
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            final dataQuestion = value.detailQuestion["question_detail"],
                dataAnswer = value.detailQuestion["list_answer"],
                likeNum = dataQuestion["like_num"];

            return Scaffold(
                key: scaffoldKey,
                backgroundColor: Colors.white,
                drawer: const NavDrawer(),
                body: SingleChildScrollView(
                  child: Column(children: [
                    NavbarDesktop(
                      activePage: "",
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
                          horizontal: 0, vertical: 0),
                      columnPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      children: [
                        ResponsiveRowColumnItem(
                          rowFlex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
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
                              children: [
                                Image.network(
                                  dataQuestion["question_thumbnail"],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: Responsive.isMobile(context)
                                      ? 256
                                      : Responsive.heightScreen(context) * 0.69,
                                ),
                                // main content
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Konten Detail Pertanyaan + interaksi
                                      ContentQuestionDetail(
                                          dataQuestion: dataQuestion,
                                          likeQuestion: value.likeQuestion,
                                          dislikeQuestion:
                                              value.dislikeQuestion,
                                          likeNum: likeNum,
                                          nameUser: name),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ResponsiveRowColumnItem(
                          rowFlex: 1,
                          child: Stack(children: [
                            SectionAnswers(
                              dataQuestion: dataQuestion,
                              dataAnswer: dataAnswer,
                              name: name,
                            ),
                            InputAnswer(
                              questionId: id,
                              type: dataQuestion["question_type"] == "jagung"
                                  ? 1
                                  : dataQuestion["question_type"] == "padi"
                                      ? 2
                                      : 3,
                            )
                          ]),
                        )
                      ],
                    )
                  ]),
                ));
          }
        },
      ),
    );
  }
}
