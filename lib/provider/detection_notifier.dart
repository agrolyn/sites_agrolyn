import 'dart:convert';
import 'dart:typed_data';
import 'package:agrolyn_web/service/detection_ext_service.dart';
import 'package:agrolyn_web/service/detection_service.dart';
import 'package:agrolyn_web/view/detection/detection_result_screen.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
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

  Uint8List? bytes;

  Future<void> pickAndUploadFile() async {
    predictionIsLoading = true;
    try {
      // Pilih file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (result != null && result.files.isNotEmpty) {
        bytes = result.files.first.bytes;

        // Data objek yang akan dikirim
        var formData = FormData.fromMap({
          "img_pred": MultipartFile.fromBytes(bytes as List<int>,
              filename: 'objek-deteksi.jpg')
        });
        bool res =
            await DetectionExtService().fetchPredictCornDisease(formData);
        if (res) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String disease = prefs.getString('disease') ?? '';
          await DetectionService()
              .fetchPredictCornDisease(disease, formData)
              .whenComplete(() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DetectionResultScreen(),
              ),
            );
          });
        } else {
          print("Gagal memprediksi");
        }
      } else {
        print("No file selected");
      }
    } catch (e) {
      print("upload file error cuy: $e");
    } finally {
      predictionIsLoading = false;
      notifyListeners();
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
