import 'package:agrolyn_web/service/detection_service.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetectionExtService {
  final Dio _dio = Dio();

  DetectionExtService() {
    _dio.options.baseUrl = "http://linggashop.my.id/disease-predict/";
    _dio.options.headers = {
      'Accept': 'application/json',
    };
    _dio.options.contentType = Headers.formUrlEncodedContentType;
  }

  Future<bool> fetchPredictCornDisease(FormData formData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final type = prefs.getString('scan_type') ?? '';
    try {
      final Response response;
      if (type == 'Jagung') {
        response = await _dio.post("corn", data: formData);
      } else {
        response = await _dio.post("rice", data: formData);
      }

      // print(response);
      if (response.statusCode == 200) {
        print("Prediksi Berhasil");
        final disease = response.data['prediction'];
        print(disease);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('disease', disease);
        print('=====');
        print(formData.toString());
        print('=====');
        final res =
            DetectionService().fetchPredictCornDisease(disease, formData);
        print(response.data);
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      print("Error Fetch Predict : $e");
      return false;
    } catch (e) {
      print("Error Fetch Predict : $e");
      return false;
    }
  }
}
