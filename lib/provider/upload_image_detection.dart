import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  String? filePath;

  Future<void> pickAndUploadFile() async {
    // Pilih file
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      filePath = result.files.single.path;

      // Data objek yang akan dikirim
      Map<String, dynamic> data = {
        "name": "Sample Name",
        "description": "This is a sample description",
      };

      // Kirim data dan file
      await uploadData("https://yourapi.com/upload", data, filePath!);
    } else {
      print("No file selected");
    }
  }

  Future<void> uploadData(
      String url, Map<String, dynamic> data, String filePath) async {
    final dio = Dio();

    try {
      MultipartFile file = await MultipartFile.fromFile(
        filePath,
        filename: filePath.split('/').last,
      );

      FormData formData = FormData.fromMap({
        ...data,
        "image": file,
      });

      final response = await dio.post(
        url,
        data: formData,
        options: Options(headers: {
          "Content-Type": "multipart/form-data",
        }),
      );

      print("Upload successful: ${response.data}");
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload File"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: pickAndUploadFile,
          child: const Text("Upload File"),
        ),
      ),
    );
  }
}
