import 'package:agrolyn_web/provider/community_notifer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropdownCategory extends StatefulWidget {
  const DropdownCategory({super.key});

  @override
  _DropdownCategoryState createState() => _DropdownCategoryState();
}

class _DropdownCategoryState extends State<DropdownCategory> {
  String _selectedCategory = 'Jagung';
  final List<String> _categories = ['Jagung', 'Padi', 'Umum'];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CommunityNotifer(context: context),
      child: Consumer<CommunityNotifer>(
          builder: (context, value, child) => DropdownButton<String>(
                value: _selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                    value.selectCategoryItemQuestion(newValue);
                  });
                },
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
              )),
    );
  }
}
