import 'package:agrolyn_web/service/article_service.dart';
import 'package:agrolyn_web/service/recipe_service.dart';
import 'package:agrolyn_web/service/video_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeNotifier extends ChangeNotifier {
  final BuildContext context;

  HomeNotifier({required this.context}) {
    checkIsLogedIn();
    fetchArticles();
    fetchVideo();
    fetchRecipe();
  }

  bool _isSecondPageVisible = false;

  bool get isSecondPageVisible => _isSecondPageVisible;

  checkIsLogedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogedIn = prefs.getBool('isLogedin') ?? false;
    if (!isLogedIn) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  void toggleSecondPageVisibility() {
    _isSecondPageVisible = !_isSecondPageVisible;
    notifyListeners(); // Memperbarui listener
  }

  final ArticleService _articleService = ArticleService();
  List articles = [];

  void fetchArticles() async {
    articles = await _articleService.getArticles();
    notifyListeners();
  }

  final VideoService _videoService = VideoService();
  List videos = [];

  void fetchVideo() async {
    videos = await _videoService.getVideos();
    notifyListeners();
  }

  final RecipeService _recipeService = RecipeService();
  List recipes = [];

  void fetchRecipe() async {
    recipes = await _recipeService.getRecipes();
    notifyListeners();
  }

  int page = 0;
  gantiPage(int value) {
    page = value;
    notifyListeners();
  }
}
