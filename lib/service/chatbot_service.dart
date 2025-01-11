import 'dart:convert';
import 'package:agrolyn_web/service/auth_service.dart';
import 'package:dio/dio.dart';

class ChatbotService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> fetchChatbotData(
      Map<String, dynamic> data) async {
    final token = await AuthService().getToken();
    try {
      print('Sending data: $data'); // Log data yang dikirim
      final response = await _dio.post(
        'https://apiv1.agrolyn.online/chatbot/llama-pretrained/',
        data: jsonEncode(data),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      print('Response status: ${response.statusCode}'); // Log status respons
      print('Response data: ${response.data}'); // Log data respons

      if (response.statusCode == 200) {
        var responseData =
            response.data is String ? jsonDecode(response.data) : response.data;

        return responseData;
      } else {
        throw Exception('Failed to load response');
      }
    } catch (e) {
      print('Error in API call: $e');
      throw Exception('Chatbot failed: $e');
    }
  }

  Future<Map<String, dynamic>> fetchChatbotDataGroq(
      Map<String, dynamic> data) async {
    final token = await AuthService().getToken();
    try {
      print('Sending data: $data'); // Log data yang dikirim
      final response = await _dio.post(
        'https://apiv1.agrolyn.online/chatbot/agrobot/',
        data: jsonEncode(data),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      print('Response status: ${response.statusCode}'); // Log status respons
      print('Response data: ${response.data}'); // Log data respons

      if (response.statusCode == 200) {
        var responseData =
            response.data is String ? jsonDecode(response.data) : response.data;

        return responseData;
      } else {
        throw Exception('Failed to load response');
      }
    } catch (e) {
      print('Error in API call: $e');
      throw Exception('Chatbot failed: $e');
    }
  }
}
