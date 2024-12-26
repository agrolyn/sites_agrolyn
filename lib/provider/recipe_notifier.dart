import 'package:agrolyn_web/service/recipe_service.dart';
import 'package:flutter/material.dart';

class RecipeNotifier extends ChangeNotifier {
  final BuildContext context;

  RecipeNotifier({required this.context}) {
    fetchRecipe();
  }

  final RecipeService _recipeService = RecipeService();
  List recipes = [];

  void fetchRecipe() async {
    recipes = await _recipeService.getRecipes();
    notifyListeners();
  }
}
