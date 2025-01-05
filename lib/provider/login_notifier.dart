import 'package:flutter/material.dart';

class LoginNotifier extends ChangeNotifier {
  final BuildContext context;

  LoginNotifier({required this.context});

  final keyfrom = GlobalKey<FormState>();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool isObscure = true;

  void toggleObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void setErrorMessage(String? value) {
    _errorMessage = value;
    notifyListeners();
  }

  void fetchLogin() async {}
}
