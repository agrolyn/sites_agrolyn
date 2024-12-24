import 'package:agrolyn_web/service/auth_service.dart';
import 'package:dio/dio.dart';

class VideoService {
  final Dio _dio = Dio();

  Future<List> getVideos() async {
    final token = await AuthService().getToken();
    try {
      final response =
          await _dio.get('https://apiv1.agrolyn.online/video-education/',
              options: Options(headers: {
                'Authorization': 'Bearer $token',
              }));
      if (response.data['data'] != null) {
        return response.data['data']; // Mengembalikan semua video
      } else {
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }
}
