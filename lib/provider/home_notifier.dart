import 'package:agrolyn_web/service/article_service.dart';
import 'package:agrolyn_web/service/video_service.dart';
import 'package:flutter/material.dart';

class HomeNotifier extends ChangeNotifier {
  final BuildContext context;

  HomeNotifier({required this.context}) {
    fetchArticles();
    fetchVideo();
  }

  bool _isSecondPageVisible = false;

  bool get isSecondPageVisible => _isSecondPageVisible;

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
}
