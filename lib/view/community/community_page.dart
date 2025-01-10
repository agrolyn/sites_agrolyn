import 'dart:ui';

import 'package:agrolyn_web/provider/community_notifer.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/utils/assets_path.dart';
import 'package:agrolyn_web/utils/responsive.dart';
import 'package:agrolyn_web/view/community/add_question.dart';
import 'package:agrolyn_web/view/community/card_community.dart';
import 'package:agrolyn_web/widget/footer.dart';
import 'package:agrolyn_web/widget/navbar/nav_drawer.dart';
import 'package:agrolyn_web/widget/navbar/navbar_desktop.dart';
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
            key: value.scaffoldKey,
            backgroundColor: Colors.white,
            drawer: const NavDrawer(),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  NavbarDesktop(activePage: "Komunitas"),
                  Container(
                    width: widthScreen,
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
                          ImageAssets.bgComm,
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
                                      ? widthScreen * 0.7
                                      : widthScreen * 0.5,
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
                                            "Komunitas Agrolyn",
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
                                            "Temukan jawaban, inspirasi, dan jejaring dengan petani lainnya untuk bersama-sama memajukan pertanian di indonesia",
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
