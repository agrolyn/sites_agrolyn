import 'package:agrolyn_web/provider/article_notifier.dart';
import 'package:agrolyn_web/utils/date.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailArticle extends StatelessWidget {
  final Map<String, dynamic> article;
  const DetailArticle({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ArticleNotifier(context: context),
        child: Consumer<ArticleNotifier>(
          builder: (context, value, child) => Scaffold(
              // appBar: AppBar(
              //   title: Text(article['title']),
              // ),
              // body: SingleChildScrollView(
              //   child: Padding(
              //     padding: const EdgeInsets.all(16.0),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         article['thumbnail'] != null &&
              //                 article['thumbnail'].isNotEmpty
              //             ? Image.network(
              //                 article['thumbnail'],
              //                 height: 234,
              //                 width: double.infinity,
              //                 fit: BoxFit.cover,
              //               )
              //             : const Text("No image available"),
              //         const SizedBox(height: 16),
              //         Row(children: [
              //           Row(
              //             children: [
              //               const Icon(Icons.location_on_outlined,
              //                   size: 11, color: Colors.grey),
              //               const SizedBox(width: 4),
              //               Text(
              //                 "${article['location']}",
              //                 style: const TextStyle(
              //                     fontSize: 14, color: Colors.grey),
              //               ),
              //             ],
              //           ),
              //           const Spacer(),
              //           Row(
              //             children: [
              //               const Icon(Icons.calendar_month_outlined,
              //                   size: 11, color: Colors.grey),
              //               const SizedBox(width: 4),
              //               FutureBuilder(
              //                 future:
              //                     formatRelativeTime(article["released_date"]),
              //                 builder: (context, snapshot) {
              //                   if (snapshot.hasData) {
              //                     return Text(
              //                       snapshot.data.toString(),
              //                       style: const TextStyle(color: Colors.grey),
              //                     );
              //                   } else {
              //                     return const CircularProgressIndicator(); // or some other loading indicator
              //                   }
              //                 },
              //               )
              //             ],
              //           ),
              //         ]),
              //         const SizedBox(height: 8),
              //         Text(
              //           article['title'],
              //           style: const TextStyle(
              //               fontSize: 24, fontWeight: FontWeight.bold),
              //         ),
              //         const SizedBox(height: 8),
              //         Text(
              //           article['description'],
              //           style: const TextStyle(fontSize: 16),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              ),
        ));
  }
}
