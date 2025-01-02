import 'package:agrolyn_web/service/olahan_service.dart';
import 'package:flutter/material.dart';

class DetailOlahanNotifier extends ChangeNotifier {
  final BuildContext context;
  final int id;

  DetailOlahanNotifier(this.id, {required this.context}) {
    fetchDetailOlahan();
  }

  final OlahanService _olahanService = OlahanService();
  bool isLoading = false;
  Map<String, dynamic> detailOlahans = {}; // Ubah menjadi Map

  void fetchDetailOlahan() async {
    isLoading = true;
    notifyListeners();
    try {
      detailOlahans = await _olahanService.getDetailOlahan(context, id);
      print("Detail Olahan Fetched: $detailOlahans"); // Log data yang diterima
    } catch (e) {
      print("Error fetching olahans: $e");
      detailOlahans = {}; // Gunakan Map kosong jika terjadi error
    } finally {
      isLoading = false;
      notifyListeners(); // Pastikan UI diupdate setelah data dimuat
    }
  }
}
