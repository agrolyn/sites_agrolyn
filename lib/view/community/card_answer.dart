import 'package:agrolyn_web/service/community_service.dart';
import 'package:agrolyn_web/provider/community_notifer.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/utils/inter_prefs.dart';
import 'package:flutter/material.dart';
import 'package:agrolyn_web/utils/date.dart';
import 'package:provider/provider.dart';

class CardAnswer extends StatelessWidget {
  String answer, userProfile, username, releasedDate, name;
  int id, likeNum, questionId;
  bool? isLiked = false, isDisliked = false;
  CardAnswer(
      {super.key,
      required this.answer,
      required this.userProfile,
      required this.username,
      required this.releasedDate,
      required this.id,
      required this.likeNum,
      required this.questionId,
      required this.name}) {
    initialize();
  }

  TextEditingController answerController = TextEditingController();

  void initialize() async {
    answerController.text = answer;
    await InterPrefs.init();
    if (InterPrefs.getPrefs('like_answer_$id').isNotEmpty) {
      isLiked = bool.parse(InterPrefs.getPrefs('like_answer_$id'));
    }

    if (InterPrefs.getPrefs('dislike_answer_$id').isNotEmpty) {
      isDisliked = bool.parse(InterPrefs.getPrefs('dislike_answer_$id'));
    }
  }

  @override
  Widget build(BuildContext context) {
    void editAnswer(context, CommunityNotifer value) async {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
              child: Material(
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 32, bottom: 32, left: 16, right: 16),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                      child: Text(
                        "Edit Jawaban",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormField(
                      controller: answerController,
                      maxLines: 7,
                      decoration: const InputDecoration(
                        labelText: 'Jawaban',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 48,
                            width: 184,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.red),
                            child: const Center(
                              child: Text(
                                "Batal",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            value.editAnswer(
                                context, id, answerController.text, questionId);
                          },
                          child: Container(
                            height: 48,
                            width: 184,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: MyColors.primaryColorDark),
                            child: const Center(
                              child: Text(
                                "Simpan",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ));
        },
      );
    }

    void deleteAnswer(answerId, value) async {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Hapus Jawaban?'),
              content:
                  const Text('Apakah Anda yakin ingin menghapus jawaban ini?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Tutup dialog
                  },
                  child: const Text('Batal'),
                ),
                TextButton(
                  onPressed: () async {
                    print(answerId);
                    value.deleteAnswer(context, answerId, questionId);
                  },
                  child: const Text('Ya, Hapus!'),
                ),
              ],
            );
          });
    }

    return ChangeNotifierProvider(
        create: (_) => CommunityNotifer(context: context),
        child: Consumer<CommunityNotifer>(
            builder: (context, value, child) =>
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(
                              userProfile), // Ganti dengan path gambar Anda
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Text(
                                  username,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54),
                                ),
                                const Spacer(),
                                const Icon(Icons.calendar_month_outlined,
                                    size: 11, color: Colors.grey),
                                const SizedBox(width: 4),
                                FutureBuilder(
                                  future: formatRelativeTime(releasedDate),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        snapshot.data.toString(),
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      );
                                    } else {
                                      return const CircularProgressIndicator(); // or some other loading indicator
                                    }
                                  },
                                ),
                              ]),
                              const SizedBox(height: 4),
                              Text(
                                answer,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black87,
                                ),
                                softWrap: true,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          if (isLiked == false) {
                                            value.likeAnswer(id);
                                          }
                                          await InterPrefs.init();
                                          InterPrefs.setPrefs(
                                              'like_answer_$id', 'true');
                                          InterPrefs.setPrefs(
                                              'dislike_answer_$id', 'false');
                                          likeNum++;
                                          isLiked = true;
                                          isDisliked = false;
                                        },
                                        child: Row(
                                          children: [
                                            isLiked == true
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
                                          ],
                                        ),
                                      ),
                                      Text(likeNum.toString(),
                                          style: const TextStyle(
                                              color: Colors.grey)),
                                      const SizedBox(width: 8),

                                      InkWell(
                                        onTap: () async {
                                          if (isDisliked == false) {
                                            value.dislikeAnswer(id);
                                          }
                                          await InterPrefs.init();
                                          InterPrefs.setPrefs(
                                              'like_answer_$id', 'false');
                                          InterPrefs.setPrefs(
                                              'dislike_answer_$id', 'true');
                                          likeNum--;
                                          isDisliked = true;
                                          isLiked = false;
                                        },
                                        child: isDisliked == true
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
                                      ),
                                      // Text(id.toString())
                                    ],
                                  ),
                                  const Spacer(),
                                  name == username
                                      ? Row(
                                          children: [
                                            InkWell(
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.edit_outlined,
                                                    size: 16,
                                                    color: Colors.grey,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  InkWell(
                                                    onTap: () => editAnswer(
                                                        context, value),
                                                    child: const Text("Ubah",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.grey)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            InkWell(
                                              onTap: () =>
                                                  deleteAnswer(id, value),
                                              child: const Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.delete_outlined,
                                                        size: 16,
                                                        color: Colors.red,
                                                      ),
                                                      SizedBox(width: 4),
                                                      Text("Hapus",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red)),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      : const SizedBox.shrink()
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: Colors.grey.shade300),
                ])));
  }
}
