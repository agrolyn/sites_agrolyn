import 'package:agrolyn_web/provider/community_notifer.dart';
import 'package:agrolyn_web/provider/home_notifier.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/utils/assets_path.dart';
import 'package:agrolyn_web/view/community/add_question.dart';
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
      create: (_) => HomeNotifier(context: context),
      child: Consumer<HomeNotifier>(
        builder: (context, value, child) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(ImageAssets.community),
                  ),
                  // mulai coding disini
                  Padding(
                      padding: const EdgeInsets.only(
                        top: 16,
                        bottom: 8,
                        left: 16,
                        right: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 48,
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
                                hintText: "Cari topik diskusi favoritmu disini",
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
                                // if (keyword.length > 2) {
                                //   value.searchingQuestion(keyword);
                                // } else {
                                //   value.fetchAllQuestion();
                                // }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              InkWell(
                                // onTap: () => value.showFilterQuestion(),
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
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.filter_alt_rounded,
                                        color: MyColors.primaryColorDark,
                                        size: 28,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "Filter Diskusi",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: MyColors.primaryColorDark),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const Spacer(),
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
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.add_circle,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "Buat Diskusi Baru",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
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
