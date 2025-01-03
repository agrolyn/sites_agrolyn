import 'dart:convert';
import 'package:agrolyn_web/service/auth_service.dart';
import 'package:agrolyn_web/shared/custom_snackbar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetectionService {
  final Dio _dio = Dio();

  DetectionService() {
    _dio.options.baseUrl = "https://apiv1.agrolyn.online";
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  Map<String, dynamic> detailHistory = {};

  void addDetailHistory(String key, dynamic value) {
    detailHistory[key] = value;
  }

  // Fungsi untuk login
  Future<bool> fetchPredictCornDisease(
      String disease, FormData formData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final type = prefs.getString('scan_type') ?? '';
    final token = await AuthService().getToken();
    try {
      final Response response;
      if (type == 'Jagung') {
        response = await _dio.post("/corn-disease-predict/$disease/",
            data: formData,
            options: Options(headers: {
              'Authorization': 'Bearer $token',
            }));
      } else {
        response = await _dio.post("/rice-disease-predict/$disease/",
            data: formData,
            options: Options(headers: {
              'Authorization': 'Bearer $token',
            }));
      }

      if (response.statusCode == 200) {
        print("Fetch disease Berhasil");
        // print(response.data);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('detail_result_scan', jsonEncode(response.data));
        return true;
      } else {
        print("Fetch disease Gagal");
        return false;
      }
    } on DioException catch (e) {
      print("Fetch disease error: $e");
      return false;
    } catch (e) {
      print("Fetch disease error: $e");
      return false;
    }
  }

  Future<List> fetchGetHistory() async {
    final token = await AuthService().getToken();
    try {
      final response = await _dio.get("/history/detection-history/",
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      // print(response);
      if (response.statusCode == 200) {
        print(response.data['data']);
        print("Fetch History Berhasil");
        return response.data['data'];
      } else {
        print("Fetch History Gagal");
        return [];
      }
    } on DioException catch (e) {
      print("Feth History error: $e");
      return [];
    } catch (e) {
      print("Feth History error: $e");
      return [];
    }
  }

  Future<String> fetchDeleteHistory(context, int id) async {
    final token = await AuthService().getToken();
    try {
      final response =
          await _dio.delete("/history/detection-history/delete-history/$id/",
              options: Options(headers: {
                'Authorization': 'Bearer $token',
              }));
      if (response.statusCode == 200) {
        print("Delete History Berhasil");
        Navigator.pushReplacementNamed(context, '/history-detection');
        showCustomSnackbar(context, "Berhasil Dihapus",
            "Riwayat Berhasil Dihapus!", ContentType.success);
        return "Delete History Berhasil";
      } else {
        print("Delete History Gagal");
        showCustomSnackbar(context, "Gagal Dihapus", "Riwayat Gagal Dihapus!",
            ContentType.failure);
        return "Delete History Gagal";
      }
    } on DioException catch (e) {
      print("Delete History error: $e");
      showCustomSnackbar(context, "Gagal Dihapus", "Riwayat Gagal Dihapus!",
          ContentType.failure);
      return "Delete History Gagal";
    } catch (e) {
      print("Delete History error: $e");
      return "Delete History Gagal";
    }
  }

  Future<String> fetchDeleteAllHistory(context) async {
    final token = await AuthService().getToken();
    try {
      final response =
          await _dio.delete("/history/detection-history/delete-all-history/",
              options: Options(headers: {
                'Authorization': 'Bearer $token',
              }));
      if (response.statusCode == 200) {
        // print("Delete All History Berhasil");
        Navigator.pushReplacementNamed(
            context, '/history-detection'); // navigasi ke halaman history
        showCustomSnackbar(context, "Berhasil Dihapus",
            "Semua Riwayat Berhasil Dihapus!", ContentType.success);
        return "Delete All History Berhasil";
      } else {
        print("Delete All History Gagal");
        showCustomSnackbar(context, "Gagal Dihapus",
            "Semua Riwayat Gagal Dihapus!", ContentType.failure);
        return "Delete All History Gagal";
      }
    } on DioException catch (e) {
      print("Delete All History error: $e");
      showCustomSnackbar(context, "Gagal Dihapus",
          "Semua Riwayat Gagal Dihapus!", ContentType.failure);
      return "Delete All History Gagal";
    } catch (e) {
      print("Delete All History error: $e");
      return "Delete All History Gagal";
    }
  }

  Future<Map<String, dynamic>> fetchDetailHistory(int? id) async {
    final token = await AuthService().getToken();
    try {
      final response = await _dio.get("/history/detection-history/$id/",
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      // print(response);
      if (response.statusCode == 200) {
        // print(response.data['data']);
        print("Fetch Detail History Berhasil");
        return response.data['data'];
      } else {
        print("Fetch Detail History Gagal");
        return response.data['message'];
      }
    } on DioException catch (e) {
      print("Feth Detail History error: $e");
      return {};
    } catch (e) {
      print("Feth Detail History error: $e");
      return {};
    }
  }
}
