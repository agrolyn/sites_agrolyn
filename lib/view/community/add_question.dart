import 'package:agrolyn_web/provider/community_notifer.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/utils/assets_path.dart';
import 'package:agrolyn_web/widget/dropdown_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddQuestion extends StatelessWidget {
  const AddQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => CommunityNotifer(context: context),
        child: Consumer<CommunityNotifer>(
            builder: (context, value, child) => Scaffold(
                body: Center(
                    child: Material(
                        borderRadius: BorderRadius.circular(16),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Container(
                              constraints: const BoxConstraints(maxWidth: 400),
                              child: Form(
                                key: value.formKey,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child:
                                            Image.asset(ImageAssets.question),
                                      ),
                                      const SizedBox(height: 20),
                                      const Center(
                                        child: Text(
                                          "Buat Diskusi Baru",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      // Input title
                                      TextFormField(
                                        initialValue: value.titleQuestion,
                                        decoration: InputDecoration(
                                          labelText: "Judul",
                                          focusColor: MyColors.primaryColorDark,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                        ),
                                        onChanged: (newValue) =>
                                            value.setTitleQuestion(newValue),
                                        validator: (value) =>
                                            value == null || value.isEmpty
                                                ? 'Title is required'
                                                : null,
                                      ),
                                      const SizedBox(height: 16),
                                      // Input description
                                      TextFormField(
                                        initialValue: value.descriptionQuestion,
                                        maxLines: 5,
                                        decoration: InputDecoration(
                                          labelText: "Deskripsi",
                                          focusColor: MyColors.primaryColorDark,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                        ),
                                        onChanged: (newValue) => value
                                            .setDescriptionQuestion(newValue),
                                        validator: (value) =>
                                            value == null || value.isEmpty
                                                ? 'Description is required'
                                                : null,
                                      ),
                                      const SizedBox(height: 16),
                                      // Image picker
                                      GestureDetector(
                                        onTap: () => value.setImageQuestion(),
                                        child: value.imageQuestion == null
                                            ? Container(
                                                height: 150,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  color: Colors.grey[300],
                                                ),
                                                child: Icon(Icons.add_a_photo,
                                                    color: Colors.grey[500]),
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                child: Image.memory(
                                                  value.imageQuestion,
                                                  height: 150,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                      ),
                                      const SizedBox(height: 16),
                                      const Row(
                                        children: [
                                          Text("Pilih Kategori : "),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          DropdownCategory(),
                                        ],
                                      ),
                                      const SizedBox(height: 16),

                                      Row(
                                        children: [
                                          ElevatedButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      WidgetStateProperty.all(
                                                          Colors.red),
                                                  foregroundColor:
                                                      const WidgetStatePropertyAll(
                                                          Colors.white),
                                                  minimumSize:
                                                      const WidgetStatePropertyAll(
                                                          Size(180, 40))),
                                              child: const Text('Batal')),
                                          const Spacer(),
                                          ElevatedButton(
                                            onPressed: () =>
                                                value.submitAddQuestion(),
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    WidgetStateProperty.all(
                                                        MyColors
                                                            .primaryColorDark),
                                                foregroundColor:
                                                    const WidgetStatePropertyAll(
                                                        Colors.white),
                                                minimumSize:
                                                    const WidgetStatePropertyAll(
                                                        Size(180, 40))),
                                            child: const Text('submit'),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ))))));
  }
}
