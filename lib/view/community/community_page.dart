import 'package:agrolyn_web/provider/community_notifer.dart';
import 'package:agrolyn_web/provider/home_notifier.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/utils/assets_path.dart';
import 'package:agrolyn_web/view/community/add_question.dart';
import 'package:agrolyn_web/view/community/card_community.dart';
import 'package:agrolyn_web/widget/footer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});
  @override
  Widget build(BuildContext context) {
    void addQuestion(value) async {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ChangeNotifierProvider(
            create: (_) => CommunityNotifer(context: context),
            builder: (context, child) => const AddQuestion(),
          );
        },
      );
    }

    final widthScreen = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (_) => CommunityNotifer(context: context),
      child: Consumer<CommunityNotifer>(
        builder: (context, value, child) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: widthScreen,
                    height: 250,
                    decoration: const BoxDecoration(
                      color: MyColors.primaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(ImageAssets.community),
                    ),
                  ),
                  // mulai coding disini
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                      bottom: 8,
                      left: 16,
                      right: 16,
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 48,
                          width: widthScreen * 0.5,
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
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: "Cari topik diskusi disini",
                              hintStyle: TextStyle(color: Colors.grey),
                              prefixIcon:
                                  Icon(Icons.search, color: Colors.grey),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 20.0,
                              ),
                            ),
                            onChanged: (keyword) {
                              if (keyword.length > 2) {
                                value.searchingQuestion(keyword);
                              } else {
                                value.fetchAllQuestion();
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () => value.showFilterQuestion(),
                          child: Container(
                            height: 48,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: MyColors.primaryColorDark,
                              ),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.filter_alt_rounded,
                                  color: MyColors.primaryColorDark,
                                  size: 28,
                                ),
                                const SizedBox(width: 8),
                                widthScreen > 850
                                    ? const Text(
                                        "Filter Diskusi",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: MyColors.primaryColorDark),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        // Add Question
                        InkWell(
                          onTap: () => addQuestion(value),
                          child: Container(
                            height: 48,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: MyColors.primaryColorDark,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.add_circle,
                                  color: Colors.white,
                                  size: 28,
                                ),
                                const SizedBox(width: 8),
                                widthScreen > 850
                                    ? const Text(
                                        "Buat Diskusi",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  value.questions.isNotEmpty
                      ? GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                widthScreen > 850 ? 3 : 1, // Jumlah kolom
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio:
                                3 / 3, // Rasio ukuran grid (lebar vs tinggi)
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: value.questions.length,
                          itemBuilder: (context, index) {
                            var question = value.questions[index];
                            return CardCommunity(
                              id: question['id'],
                              thumbnail: question['question_thumbnail'],
                              title: question['title_question'],
                              type: question['question_type'],
                              date: question['released_date'],
                              imgProfile: question['user_profile'],
                              likeNum: question['like_num'],
                              username: question['username'],
                              numberOfAnswer: question['number_of_answer'],
                              key: UniqueKey(),
                            );
                          })
                      : Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: const Text('Belum ada topik diskusi'),
                        ),
                  const Footer()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
// home, community, deteksi, recipe, edukasi
