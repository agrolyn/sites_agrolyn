import 'package:agrolyn_web/service/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class OlahanService {
  final Dio _dio = Dio();

  // Fungsi untuk mengambil kategori olahan
  Future<List<Map<String, dynamic>>> getOlahans() async {
    final token = await AuthService().getToken();
    try {
      final response = await _dio.get(
        'https://apiv1.agrolyn.online/recommendation-categories/',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.data['data'] != null) {
        print("Data kategori olahan: ${response.data['data']}");
        return List<Map<String, dynamic>>.from(response.data['data']);
      } else {
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  // Fungsi untuk mengambil detail olahan berdasarkan kategori ID
  Future<List<Map<String, dynamic>>> getRecommendationId(
      BuildContext context, int idCat) async {
    final token = await AuthService().getToken();
    try {
      final response = await _dio.get(
        'https://apiv1.agrolyn.online/recommendations/$idCat/',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'content-type': 'application/json',
        }),
      );

      if (response.statusCode == 200) {
        print(
            "Response Data: ${response.data['data']}"); // Log untuk memastikan format data
        return List<Map<String, dynamic>>.from(response.data['data']);
      }
      return [];
    } catch (e) {
      print("Error fetching recommendation for idCat $idCat: $e");
      return [];
    }
  }

  Future<Map<String, dynamic>> getDetailOlahan(
      BuildContext context, int id) async {
    final token = await AuthService().getToken();
    try {
      final response = await _dio.get(
        'https://apiv1.agrolyn.online/recommendations/details/$id/',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'content-type': 'application/json',
        }),
      );

      if (response.statusCode == 200) {
        print("Response Data: ${response.data}"); // Log data yang diterima
        return Map<String, dynamic>.from(
            response.data['data']); // Ubah menjadi Map
      }
      return {}; // Kembalikan Map kosong jika tidak berhasil
    } catch (e) {
      print("Error fetching recommendation for id $id: $e");
      return {}; // Kembalikan Map kosong jika terjadi error
    }
  }
}
