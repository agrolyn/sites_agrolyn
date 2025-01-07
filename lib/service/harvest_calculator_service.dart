import 'package:agrolyn_web/service/auth_service.dart';
import 'package:dio/dio.dart';

class HarvestCalculatorService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>?> fetchNewHarvestCalculator(
      String plantType, Map<String, dynamic> data) async {
    final token = await AuthService().getToken();

    if (token == null) {
      throw Exception("Token tidak ditemukan");
    }

    String url = 'https://apiv1.agrolyn.online/harvest-calculator/$plantType/';

    try {
      print("Data: $data");
      print("Token: $token");
      final response = await _dio.post(
        url,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'content-type': 'application/json',
          },
        ),
      );

      print("Response Status: ${response.statusCode}");
      print("Response Data: ${response.data}");

      if (response.statusCode == 200) {
        return response.data; // Mengembalikan respons data sebagai Map
      } else {
        return null;
      }
    } catch (e) {
      if (e is DioException) {
        print("Dio Error: ${e.response?.data}");
        print("Dio Error Status Code: ${e.response?.statusCode}");
        print("Dio Error Headers: ${e.response?.headers}");
        print("Dio Error Request: ${e.requestOptions}");
      } else {
        print("Error: $e");
      }
      return null;
    }
  }
}
