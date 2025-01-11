import 'package:agrolyn_web/service/community_service.dart';
import 'package:agrolyn_web/provider/community_notifer.dart';
import 'package:agrolyn_web/utils/inter_prefs.dart';
import 'package:agrolyn_web/view/community/edit_question.dart';
import 'package:flutter/material.dart';
import 'package:agrolyn_web/utils/date.dart';
import 'package:provider/provider.dart';

class ContentQuestionDetail extends StatelessWidget {
  Map<String, dynamic> dataQuestion = {};
  String? nameUser;
  int likeNum;
  void Function(int) likeQuestion, dislikeQuestion;
  bool? isLiked = false, isDisliked = false;

  ContentQuestionDetail(
      {super.key,
      this.nameUser,
      required this.dataQuestion,
      required this.likeQuestion,
      required this.dislikeQuestion,
      required this.likeNum}) {
    init();
  }

  void init() async {
    await InterPrefs.init();
    if (InterPrefs.getPrefs('like_question_${dataQuestion["id"]}').isNotEmpty) {
      isLiked = bool.parse(
          InterPrefs.getPrefs('like_question_${dataQuestion["id"]}'));
    }

    if (InterPrefs.getPrefs('dislike_question_${dataQuestion["id"]}')
        .isNotEmpty) {
      isDisliked = bool.parse(
          InterPrefs.getPrefs('dislike_question_${dataQuestion["id"]}'));
    }
  }

  @override
  Widget build(BuildContext context) {
    void editQuestion() async {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ChangeNotifierProvider(
              create: (_) => CommunityNotifer(context: context),
              builder: (context, child) {
                print(dataQuestion);
                return EditQuestion(
                  id: dataQuestion["id"],
                  titleQuestion: dataQuestion["title_question"],
                  imageQuestionDefault: dataQuestion["question_thumbnail"],
                  descriptionQuestion: dataQuestion["description"],
                );
              });
        },
      );
    }

    void deleteQuestion() async {
      await CommunityService().fetchDeleteQuestion(context, dataQuestion["id"]);
    }

    void showConfirmDelete() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Hapus Pertanyaan?'),
              content: const Text(
                  'Apakah Anda yakin ingin menghapus pertanyaan ini?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Tutup dialog
                  },
                  child: const Text('Batal'),
                ),
                TextButton(
                  onPressed: () async {
                    deleteQuestion();
                  },
                  child: const Text('Ya, Hapus!'),
                ),
              ],
            );
          });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(dataQuestion["user_profile"]),
              radius: 10,
            ),
            const SizedBox(width: 8),
            Text(
              dataQuestion["username"],
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            const Spacer(),
            const Icon(Icons.calendar_month_outlined,
                size: 11, color: Colors.grey),
            const SizedBox(width: 4),
            FutureBuilder(
              future: formatRelativeTime(dataQuestion["released_date"]),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data.toString(),
                    style: const TextStyle(color: Colors.grey),
                  );
                } else {
                  return const CircularProgressIndicator(); // or some other loading indicator
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Pertanyaan
        Text(
          dataQuestion["title_question"],
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          dataQuestion["description"],
          style: const TextStyle(fontSize: 15, color: Colors.black87),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 16),
        Divider(color: Colors.grey.shade300),
        const SizedBox(
          height: 8,
        ),
        // Bagian tombol interaksi
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () async {
                    await InterPrefs.init();
                    if (isLiked == false) {
                      likeQuestion(dataQuestion["id"]);
                    }
                    InterPrefs.setPrefs(
                        'like_question_${dataQuestion["id"]}', 'true');
                    InterPrefs.setPrefs(
                        'dislike_question_${dataQuestion["id"]}', 'false');
                    isLiked = true;
                    isDisliked = false;
                  },
                  child: Row(
                    children: [
                      (isLiked == true)
                          ? const Icon(
                              Icons.thumb_up,
                              size: 16,
                              color: Colors.green,
                            )
                          : const Icon(
                              Icons.thumb_up_alt_outlined,
                              size: 16,
                              color: Colors.grey,
                            ),
                      const SizedBox(width: 8),
                      Text(
                          isLiked == true
                              ? (likeNum + 1).toString()
                              : likeNum.toString(),
                          style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () async {
                    await InterPrefs.init();
                    if (isDisliked == false) {
                      dislikeQuestion(dataQuestion["id"]);
                    }
                    InterPrefs.setPrefs(
                        'like_question_${dataQuestion["id"]}', 'false');
                    InterPrefs.setPrefs(
                        'dislike_question_${dataQuestion["id"]}', 'true');
                    isLiked = false;
                    isDisliked = true;
                  },
                  child: (isDisliked == true)
                      ? const Icon(
                          Icons.thumb_down,
                          size: 16,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.thumb_down_alt_outlined,
                          size: 16,
                          color: Colors.grey,
                        ),
                )
              ],
            ),
            // type question
            const Spacer(),
            Row(
              children: [
                const Icon(
                  Icons.beenhere_outlined,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(width: 4),
                Text(
                  dataQuestion["question_type"],
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const Spacer(),
            // actions edit/delete
            nameUser == dataQuestion["username"]
                ? Row(
                    children: [
                      Row(children: [
                        const Icon(
                          Icons.edit_note_outlined,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        InkWell(
                          onTap: () => editQuestion(),
                          child: const Text(
                            "Ubah",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ]),
                      const SizedBox(width: 8),
                      Row(children: [
                        Icon(
                          Icons.delete_outline,
                          size: 16,
                          color: Colors.red[400],
                        ),
                        const SizedBox(width: 4),
                        InkWell(
                          onTap: () => showConfirmDelete(),
                          child: Text(
                            "Hapus",
                            style: TextStyle(color: Colors.red[400]),
                          ),
                        ),
                      ])
                    ],
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ],
    );
  }
}
