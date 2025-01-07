import 'package:agrolyn_web/provider/community_notifer.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/utils/inter_prefs.dart';
import 'package:agrolyn_web/utils/responsive.dart';
import 'package:agrolyn_web/view/community/content_question_detail.dart';
import 'package:agrolyn_web/view/community/input_answer.dart';
import 'package:agrolyn_web/view/community/section_answers.dart';
import 'package:agrolyn_web/widget/navbar/navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
                backgroundColor: MyColors.primaryColorDark,
                body: Center(
                  child: Container(
                    color: const Color.fromARGB(255, 244, 243, 243),
                    width: Responsive.isDesktop(context)
                        ? MediaQuery.of(context).size.width * 0.7
                        : double.infinity,
                    child: Stack(fit: StackFit.expand, children: [
                      SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
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
                                      // Bagian gambar
                                      Stack(children: [
                                        Image.network(
                                          dataQuestion["question_thumbnail"],
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: Responsive.isDesktop(context)
                                              ? 400
                                              : 256,
                                        ),
                                      ]),
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
                                                likeQuestion:
                                                    value.likeQuestion,
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
                                // Tombol "Kembali Ke Halaman Utama Komunitas"
                                Positioned(
                                  top: 20,
                                  left: 0,
                                  right: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: SizedBox(
                                        width: 44,
                                        height: 44,
                                        child: InkWell(
                                          onTap: () async {
                                            await InterPrefs.init();
                                            InterPrefs.setPrefs(
                                                "filterBy", "semua");
                                            value.reNotifyListeners();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Navbar()));
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.black38,
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                                border: Border.all(
                                                    color: Colors.grey),
                                              ),
                                              child: const Row(
                                                children: [
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Icon(
                                                    Icons.arrow_back_ios,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                    "Kembali Ke Halaman Utama Komunitas",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              )),
                                        )),
                                  ),
                                )
                              ],
                            ),
                            // bagian jawaban
                            SectionAnswers(
                              dataQuestion: dataQuestion,
                              dataAnswer: dataAnswer,
                              name: name,
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      InputAnswer(
                        questionId: id,
                        type: dataQuestion["question_type"] == "jagung"
                            ? 1
                            : dataQuestion["question_type"] == "padi"
                                ? 2
                                : 3,
                      )
                    ]),
                  ),
                ));
          }
        },
      ),
    );
  }
}
