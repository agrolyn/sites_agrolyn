import 'package:agrolyn_web/service/chatbot_service.dart';
import 'package:flutter/material.dart';

class ChatbotNotifier extends ChangeNotifier {
  final BuildContext context;
  TextEditingController chat = TextEditingController();
  TextEditingController chatGroq = TextEditingController();
  List<Map<String, dynamic>> list = [];
  List<Map<String, dynamic>> listGroq = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  ChatbotNotifier({required this.context});

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void submit(String value) async {
    try {
      setLoading(true);
      print('Submitting prompt: $value'); // Log prompt yang dikirim
      // Kirim prompt ke API menggunakan ChatbotService
      var response = await ChatbotService().fetchChatbotData({
        "prompt": value,
      });

      print('Received response: $response'); // Log respons yang diterima

      // Menambahkan prompt pengguna ke dalam list
      var userMessage = {
        "message": value,
        "res_answer": "kanan", // Posisi pengguna (kanan)
      };

      list.insert(0, userMessage);

      // Menambahkan respons chatbot ke dalam list
      var chatbotResponse = {
        "message": response['res_answer'], // Tampilkan jawaban dari chatbot
        "res_answer": "kiri", // Posisi chatbot (kiri)
      };

      list.insert(0, chatbotResponse);
      chat.clear();
      setLoading(false);
      notifyListeners();
    } catch (e) {
      print('Error in submit: $e');
      setLoading(false);
      // Tangani kesalahan dengan lebih baik, misalnya dengan menampilkan pesan kesalahan kepada pengguna
    }
  }

  void submitGroq(String value) async {
    try {
      setLoading(true);
      print('Submitting prompt: $value'); // Log prompt yang dikirim
      // Kirim prompt ke API menggunakan ChatbotService
      var response = await ChatbotService().fetchChatbotDataGroq({
        "prompt": value,
      });

      print('Received response: $response'); // Log respons yang diterima

      // Menambahkan prompt pengguna ke dalam list
      var userMessage = {
        "message": value,
        "res_answer": "kanan", // Posisi pengguna (kanan)
      };

      listGroq.insert(0, userMessage);

      // Menambahkan respons chatbot ke dalam list
      var chatbotResponse = {
        "message": response['res_answer'], // Tampilkan jawaban dari chatbot
        "res_answer": "kiri", // Posisi chatbot (kiri)
      };

      listGroq.insert(0, chatbotResponse);
      chatGroq.clear();
      setLoading(false);
      notifyListeners();
    } catch (e) {
      print('Error in submit: $e');
      setLoading(false);
      // Tangani kesalahan dengan lebih baik, misalnya dengan menampilkan pesan kesalahan kepada pengguna
    }
  }
}
