// import 'package:agrolyn_web/provider/article_notifier.dart';
// import 'package:agrolyn_web/shared/constans.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ArticleSection extends StatelessWidget {
//   const ArticleSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => ArticleNotifier(context: context),
//       child: Consumer<ArticleNotifier>(
//         builder: (context, value, child) {
//           return return Stack(
//           children: [
//             // Lottie animation as background
//             Positioned.fill(
//               child: Lottie.asset(
//                 ImageAssets.backgorundAnimation1,
//                 fit: BoxFit.cover, // Mengisi seluruh layar
//               ),
//             ),
//             // Konten utama di atas Lottie
//             ResponsiveRowColumn(
//               layout: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
//                   ? ResponsiveRowColumnType.COLUMN
//                   : ResponsiveRowColumnType.ROW,
//               rowCrossAxisAlignment: CrossAxisAlignment.start,
//               columnCrossAxisAlignment: CrossAxisAlignment.center,
//               columnMainAxisSize: MainAxisSize.min,
//               rowPadding:
//                   const EdgeInsets.symmetric(horizontal: 80, vertical: 80),
//               columnPadding:
//                   const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
//               columnSpacing: 50,
//               rowSpacing: 50,
//               children: [
//                 ResponsiveRowColumnItem(
//                   rowFlex: 1,
//                   rowFit: FlexFit.tight,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       value.recipes.isNotEmpty
//                           ? ListView.builder(
//                               shrinkWrap: true,
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemCount: 3,
//                               itemBuilder: (context, index) {
//                                 var recipe = value.recipes[index];
//                                 return Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Container(
//                                     height: 160,
//                                     width: double.infinity,
//                                     decoration: BoxDecoration(
//                                       color: MyColors.primaryColorDark
//                                           .withOpacity(
//                                               0.7), // Transparansi untuk konten
//                                       borderRadius: BorderRadius.circular(16),
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Row(
//                                         children: [
//                                           recipe['img_recipe'] != null &&
//                                                   recipe['img_recipe']
//                                                       .isNotEmpty
//                                               ? ClipOval(
//                                                   child: Image.network(
//                                                     recipe['img_recipe'],
//                                                     fit: BoxFit.cover,
//                                                     width: 128,
//                                                     height: 128,
//                                                   ),
//                                                 )
//                                               : const Text(
//                                                   "img recipe not available"),
//                                           const SizedBox(width: 8),
//                                           Expanded(
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: [
//                                                 Text(
//                                                   "${recipe['title']}",
//                                                   style: const TextStyle(
//                                                     fontSize: 18,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.white,
//                                                   ),
//                                                 ),
//                                                 const SizedBox(
//                                                   height: 2,
//                                                 ),
//                                                 Text(
//                                                   "${recipe['description']}",
//                                                   maxLines: 2,
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                   style: const TextStyle(
//                                                     fontSize: 14,
//                                                     color: Colors.white,
//                                                   ),
//                                                 ),
//                                                 const SizedBox(height: 8),
//                                                 InkWell(
//                                                   onTap: () {
//                                                     // pushWithoutNavBar(
//                                                     //     context,
//                                                     //     MaterialPageRoute(
//                                                     //         builder: (context) =>
//                                                     //             DetailCommonRecipe(
//                                                     //                 recipe:
//                                                     //                     recipe)));
//                                                   },
//                                                   child: Container(
//                                                     height: 32,
//                                                     width: 160,
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.white,
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               8),
//                                                     ),
//                                                     child: const Center(
//                                                       child: Text(
//                                                         "Lihat Selengkapnya",
//                                                         style: TextStyle(
//                                                           color: MyColors
//                                                               .primaryColorDark,
//                                                           fontSize: 14,
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               })
//                           : const Center(
//                               child: Text("No Recipes available"),
//                             ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         );
//         },
//       ),
//     );
//   }
// }
