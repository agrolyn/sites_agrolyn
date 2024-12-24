import 'package:agrolyn_web/service/article_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Import untuk JSON encoding dan decoding

class ArticleNotifier extends ChangeNotifier {
  final BuildContext context;

  ArticleNotifier({required this.context}) {
    fetchArticles();
  }

  final ArticleService _articleService = ArticleService();
  List articles = [];
  var detailArticle;

  // Fungsi untuk mendapatkan daftar artikel
  void fetchArticles() async {
    try {
      articles = await _articleService.getArticles();
      notifyListeners();
    } catch (e) {
      print("Error fetching articles: $e");
    }
  }

  // Fungsi untuk mendapatkan detail artikel berdasarkan ID
  void fetchDetailArticles(int id) async {
    try {
      // Ambil artikel detail dari API berdasarkan ID
      detailArticle = await _articleService.getDetailArticle(id);

      // Simpan artikel detail ke SharedPreferences dalam format JSON
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('detailArticle',
          jsonEncode(detailArticle)); // Menyimpan dalam format JSON

      notifyListeners(); // Memberi tahu listeners setelah data diperbarui
    } catch (e) {
      print("Error fetching detail article: $e");
    }
  }

  // Fungsi untuk mengambil artikel yang disimpan di SharedPreferences
  Future<Map<String, dynamic>?> getDetailArticleFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? articleData = prefs.getString('detailArticle');
    if (articleData != null) {
      return jsonDecode(articleData); // Mengembalikan data dalam bentuk Map
    }
    return null; // Jika tidak ada data
  }
}
