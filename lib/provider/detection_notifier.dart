import 'dart:convert';
import 'package:agrolyn_web/service/detection_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetectionNotifier extends ChangeNotifier {
  final BuildContext context;
  DetectionNotifier({required this.context, String? page, int? idHistory}) {
    if (page == "history") {
      fetchHistory();
    }
    if (page == "detail-history") {
      fetchDetailHistory(idHistory);
    }
    if (page == "result-prediction") {
      getPredictionResult();
    }
  }

  // ==================================
  // Scan Result
  // ==================================
  bool predictionIsLoading = false;
  var resultPrediction = {};

  Future<Map<String, dynamic>> getPredictionResult() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final resPred = prefs.getString("detail_result_scan");
    // final resImg = prefs.getString("detail_result_scan");
    if (resPred != null) {
      final decodeData = jsonDecode(resPred);
      print(decodeData);
      resultPrediction = decodeData;
      notifyListeners();
      return decodeData;
    }
    return {};
  }

  // ==================================
  // History
  // ==================================

  bool historyIsLoading = false;
  var resultHistories = [];
  var detailHistoryResult = {};

  Future<List> fetchHistory() async {
    var result = await DetectionService().fetchGetHistory();
    print(result);
    resultHistories = result;
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> fetchDetailHistory(int? id) async {
    var result = await DetectionService().fetchDetailHistory(id);
    print(result);
    detailHistoryResult = result;
    notifyListeners();
    return result;
  }
}
