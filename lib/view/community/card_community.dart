import 'package:agrolyn_web/provider/community_notifer.dart';
import 'package:agrolyn_web/utils/inter_prefs.dart';
import 'package:agrolyn_web/utils/responsive.dart';
import 'package:agrolyn_web/view/community/detail_community_screen.dart';
import 'package:agrolyn_web/view/education/detail_article.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrolyn_web/utils/date.dart';

class CardCommunity extends StatelessWidget {
  final int id, likeNum, numberOfAnswer;
  final String thumbnail, type, date, title, imgProfile, username;

  bool? isLiked = false, isDisliked = false;

  CardCommunity({
    super.key,
    required this.id,
    required this.thumbnail,
    required this.type,
    required this.date,
    required this.title,
    required this.imgProfile,
    required this.username,
    required this.likeNum,
    required this.numberOfAnswer,
  }) {
    init();
  }

  void init() async {
    await InterPrefs.init();
    if (InterPrefs.getPrefs('like_question_$id').isNotEmpty) {
      isLiked = bool.parse(InterPrefs.getPrefs('like_question_$id'));
    }

    if (InterPrefs.getPrefs('dislike_question_$id').isNotEmpty) {
      isDisliked = bool.parse(InterPrefs.getPrefs('dislike_question_$id'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => CommunityNotifer(context: context),
        child: Consumer<CommunityNotifer>(
            builder: (context, value, child) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailCommunityScreen(id: id)));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(16),
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
                        // Bagian gambar
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          child: thumbnail.isNotEmpty
                              ? Image.network(
                                  thumbnail,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: Responsive.isMobile(context)
                                      ? 200
                                      : Responsive.isTablet(context)
                                          ? 200
                                          : 280,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Text('Error loading image: $error');
                                  },
                                )
                              : const Text("No image available"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Informasi pengguna
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(imgProfile),
                                    radius: 10,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    username,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                  const Spacer(),
                                  const Icon(Icons.calendar_month_outlined,
                                      size: 11, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  FutureBuilder(
                                    future: formatRelativeTime(date),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data.toString(),
                                          style: const TextStyle(
                                              color: Colors.grey),
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
                                title,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black87),
                              ),
                              const SizedBox(height: 8),
                              Divider(color: Colors.grey.shade300),
                              // Bagian tombol interaksi
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          if (isLiked == false) {
                                            value.likeQuestion(id);
                                          }
                                          await InterPrefs.init();
                                          InterPrefs.setPrefs(
                                              'like_question_$id', 'true');
                                          InterPrefs.setPrefs(
                                              'dislike_question_$id', 'false');
                                          isLiked = true;
                                          isDisliked = false;
                                        },
                                        child: Row(
                                          children: [
                                            (value.isLike == true) |
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
                                            const SizedBox(width: 4),
                                            Text(
                                                value.isLike
                                                    ? (likeNum + 1).toString()
                                                    : likeNum.toString(),
                                                style: const TextStyle(
                                                    color: Colors.grey)),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      InkWell(
                                        onTap: () async {
                                          if (isDisliked == false) {
                                            value.dislikeQuestion(id);
                                          }
                                          await InterPrefs.init();
                                          InterPrefs.setPrefs(
                                              'dislike_question_$id', 'true');
                                          InterPrefs.setPrefs(
                                            'like_question_$id',
                                            'false',
                                          );
                                          isDisliked = true;
                                          isLiked = false;
                                        },
                                        child: (value.isDislike) |
                                                (isDisliked == true)
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
                                        type,
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.comment_outlined,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        "$numberOfAnswer Jawaban",
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )));
  }
}
