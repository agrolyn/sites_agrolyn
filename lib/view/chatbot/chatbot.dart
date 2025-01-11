import 'package:agrolyn_web/provider/chatbot_notifier.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chatbot extends StatelessWidget {
  const Chatbot({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatbotNotifier(context: context),
      child: Consumer<ChatbotNotifier>(
        builder: (context, value, child) => Material(
          color:
              Colors.transparent, // Agar Material tidak memiliki latar belakang
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(8), // Border radius untuk seluruh widget
            child: SafeArea(
              child: Stack(
                children: [
                  // Background image
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          16), // Border radius untuk gambar
                      child: Image.asset(
                        ImageAssets.backgroundChatbot,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Chat messages list
                  Positioned(
                    top: 60,
                    left: 16,
                    right: 16,
                    bottom: 80,
                    child: ListView.builder(
                      reverse: true,
                      itemCount: value.listGroq.length,
                      itemBuilder: (context, index) {
                        var e = value.listGroq[index];
                        return Column(
                          crossAxisAlignment: e['res_answer'] == "kiri"
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: e['res_answer'] == "kiri"
                                    ? Colors.white
                                    : MyColors.primaryColorDark,
                                borderRadius: e['res_answer'] == "kiri"
                                    ? BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16),
                                        bottomRight: Radius.circular(16))
                                    : BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16),
                                        bottomLeft: Radius.circular(16)),
                              ),
                              child: Text(
                                e['message'], // Display message
                                style: TextStyle(
                                  color: e['res_answer'] == "kiri"
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  // Chat input field
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 86,
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: value.chatGroq,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: "Ketik di sini...", // Placeholder text
                          hintStyle: TextStyle(
                            color: Colors.grey, // Placeholder text color
                            fontSize: 14, // Placeholder text size
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              value.submitGroq(value.chatGroq.text);
                            },
                            child: value.isLoading
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 1.0,
                                      color: MyColors.primaryColorDark,
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: const Icon(
                                      size: 24,
                                      Icons.send,
                                      color: MyColors.primaryColorDark,
                                    ),
                                  ),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
