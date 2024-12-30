import 'package:agrolyn_web/service/auth_service.dart';
import 'package:dio/dio.dart';

class RecipeService {
  final Dio _dio = Dio();

  Future<List> getRecipes() async {
    final token = await AuthService().getToken();
    try {
      final response = await _dio.get('https://apiv1.agrolyn.online/recipes/',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      if (response.data['data'] != null) {
        return response.data['data'];
      } else {
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }
}
