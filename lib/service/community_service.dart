import 'package:agrolyn_web/service/auth_service.dart';
import 'package:agrolyn_web/shared/custom_snackbar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommunityService {
  final Dio _dio = Dio();
  String baseUrl = "https://apiv1.agrolyn.online/community";

  Future<List> getQuestions() async {
    final token = await AuthService().getToken();
    try {
      final response = await _dio.get('$baseUrl/questions/',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      // print(response);
      if (response.data['data'] != null) {
        return response.data['data']; // Mengembalikan semua pertanyaan
      } else {
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  Future<Map<String, dynamic>> getDetailQuestion(int questionId) async {
    final token = await AuthService().getToken();
    try {
      // print('Fetching detail for question ID: $questionId');
      final response = await _dio.get('$baseUrl/questions/$questionId/',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      // print('Response: ${response.data}');
      if (response.data['data'] != null) {
        return response.data['data'];
      } else {
        throw Exception('No data found for the question.');
      }
    } catch (e) {
      if (e is DioException) {
        print('DioError: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');

        if (e.response?.statusCode == 442) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isLogedin', false);
        }
      }
      throw Exception('Error fetching question details: $e');
    }
  }

  Future<String> fetchLikeQuestion(int questionId) async {
    final token = await AuthService().getToken();
    try {
      final response = await _dio.post('$baseUrl/questions/$questionId/like/',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      print(response);
      if (response.statusCode == 200) {
        print("Like Berhasil");
        return "Like Berhasil";
      } else {
        print("Like Gagal");
        return "Like Gagal";
      }
    } catch (e) {
      print("Error: $e");
      return "Like Gagal";
    }
  }

  Future<String> fetchDislikeQuestion(int questionId) async {
    final token = await AuthService().getToken();
    try {
      final response =
          await _dio.post('$baseUrl/questions/$questionId/dislike/',
              options: Options(headers: {
                'Authorization': 'Bearer $token',
              }));
      print(response);
      if (response.statusCode == 200) {
        print("Dislike Berhasil");
        return "Dislike Berhasil";
      } else {
        print("Dislike Gagal");
        return "Dislike Gagal";
      }
    } catch (e) {
      print("Error: $e");
      return "Dislike Gagal";
    }
  }

  Future<String?> fetchNewAnswer(
      {required int questionId,
      required String answer,
      required int type}) async {
    final token = await AuthService().getToken();
    try {
      final response = await _dio.post('$baseUrl/answer/new/$questionId/',
          data: {
            "answer": answer,
            "plant_types_id": type,
          },
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      print(response);
      if (response.statusCode == 201) {
        return response.data['message'];
      } else {
        print("Jawaban Gagal dibuat");
        return response.data['message'];
      }
    } catch (e) {
      print("Error: $e");
      return "Jawaban Gagal dibuat";
    }
  }

  Future<String> fetchDeleteAnwser(int answerId) async {
    final token = await AuthService().getToken();
    try {
      final response = await _dio.delete('$baseUrl/answer/delete/$answerId/',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      print(response);
      if (response.statusCode == 200) {
        print("Jawaban Berhasil dihapus");
        return "Jawaban Berhasil dihapus";
      } else {
        print("Jawaban Gagal dihapus");
        return "Jawaban Gagal dihapus";
      }
    } catch (e) {
      print("Error: $e");
      return "Jawaban Gagal dihapus";
    }
  }

  Future<String> fetchEditAnswer(int answerId, String answer) async {
    final token = await AuthService().getToken();
    try {
      final response = await _dio.put('$baseUrl/answer/update/$answerId/',
          data: {"answer": answer},
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      print(response);
      if (response.statusCode == 200) {
        print("Jawaban Berhasil diubah");
        return "Jawaban Berhasil diubah";
      } else {
        print("Jawaban Gagal diubah");
        return "Jawaban Gagal diubah";
      }
    } catch (e) {
      print("Error: $e");
      return "Jawaban Gagal diubah";
    }
  }

  Future<String> fetchLikeAnswer(int answerId) async {
    final token = await AuthService().getToken();
    try {
      final response = await _dio.post('$baseUrl/answer/$answerId/like/',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      print(response);
      if (response.statusCode == 200) {
        print("Like Answer Berhasil");
        return "Like Answer Berhasil";
      } else {
        print("Like Answer Gagal");
        return "Like  Answer Gagal";
      }
    } catch (e) {
      print("Error: $e");
      return "Like  Answer Gagal";
    }
  }

  Future<String> fetchDislikeAnswer(int answerId) async {
    final token = await AuthService().getToken();
    try {
      final response = await _dio.post('$baseUrl/answer/$answerId/dislike/',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      print(response);
      if (response.statusCode == 200) {
        print("Dislike Answer Berbayar");
        return "Dislike Answer Berbayar";
      } else {
        print("Dislike Answer Gagal");
        return "Dislike Answer Gagal";
      }
    } catch (e) {
      print("Error: $e");
      return "Dislike Answer Gagal";
    }
  }

  Future<String> fetchAddQuestion(FormData formData) async {
    final token = await AuthService().getToken();
    try {
      final response = await _dio.post(
        '$baseUrl/question/new/',
        data: formData,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      print('Response: ${response.statusCode}');
      print('Data: ${response.data}');
      if (response.statusCode == 201) {
        return "Pertanyaan Berhasil dibuat";
      } else {
        return "Pertanyaan Gagal dibuat";
      }
    } catch (e) {
      print('Dio Error: $e');
      return "Pertanyaan Gagal dibuat";
    }
  }

  Future<String> fetchDeleteQuestion(context, int questionId) async {
    final token = await AuthService().getToken();
    try {
      final response =
          await _dio.delete('$baseUrl/question/delete/$questionId/',
              options: Options(headers: {
                'Authorization': 'Bearer $token',
              }));
      print(response);
      if (response.statusCode == 200) {
        Navigator.pushReplacementNamed(context,
            '/community'); // Redirect ke halaman community setelah berhasil menghapus pertanyaan
        showCustomSnackbar(context, "Berhasil Dihapus",
            "Jawaban Anda Berhasil Dihapus!", ContentType.success);
        print("Pertanyaan Berhasil dihapus");

        return "Pertanyaan Berhasil dihapus";
      } else {
        print("Pertanyaan Gagal dihapus");
        showCustomSnackbar(context, "Gagal Dihapus",
            "Jawaban Anda Gagal Dihapus!", ContentType.failure);
        return "Pertanyaan Gagal dihapus";
      }
    } catch (e) {
      print("Error: $e");
      showCustomSnackbar(context, "Gagal Dihapus",
          "Jawaban Anda Gagal Dihapus, karena ada error!", ContentType.failure);
      return "Pertanyaan Gagal dihapus";
    }
  }

  Future<String> fetchEditQuestion(int questionId, FormData formData) async {
    final token = await AuthService().getToken();
    try {
      final response = await _dio.put('$baseUrl/question/update/$questionId/',
          data: formData,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      print(response);
      if (response.statusCode == 200) {
        print("Pertanyaan Berhasil diubah");
        return "Pertanyaan Berhasil diubah";
      } else {
        print("Pertanyaan Gagal diubah");
        return "Pertanyaan Gagal diubah";
      }
    } catch (e) {
      print("Error: $e");
      return "Pertanyaan Gagal diubah";
    }
  }

  Future<List> fetchSearchQuestion(String keyword) async {
    final token = await AuthService().getToken();
    try {
      final response =
          await _dio.get('$baseUrl/questions/search/?query=$keyword',
              options: Options(headers: {
                'Authorization': 'Bearer $token',
              }));
      // print(response);
      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        print("Pertanyaan gagal dicari");
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  Future<List> fetchFilterQuestion(String keyword) async {
    final token = await AuthService().getToken();
    try {
      final response = await _dio.get('$baseUrl/questions/filters/$keyword',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      // print(response);
      if (response.statusCode == 200) {
        // print(response.data['message']);
        return response.data['data'];
      } else {
        print("Pertanyaan gagal difilter");
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }
}
