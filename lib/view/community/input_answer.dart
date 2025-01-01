import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrolyn_web/provider/community_notifer.dart';

class InputAnswer extends StatelessWidget {
  final int questionId, type;
  InputAnswer({
    super.key,
    required this.questionId,
    required this.type,
  });

  TextEditingController answerController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CommunityNotifer(context: context),
      child: Consumer<CommunityNotifer>(
          builder: (context, value, child) => Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        spreadRadius: 3,
                        offset: const Offset(0, -2),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Form(
                            key: formKey,
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black54),
                              cursorColor: Colors.green,
                              controller: answerController,
                              keyboardType: TextInputType.multiline,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white70,
                                focusColor: Colors.green,
                                hintText: "Tulis jawabanmu disini...",
                                hintStyle: TextStyle(color: Colors.black54),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                    borderSide:
                                        BorderSide(color: Colors.green)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.green,
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            value.createAnswer(
                                context: context,
                                questionId: questionId,
                                type: type,
                                answer: answerController.text);

                            answerController.clear();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          child: const Icon(
                            Icons.send,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
              )),
    );
  }
}
