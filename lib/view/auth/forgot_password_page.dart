import 'package:agrolyn_web/service/auth_service.dart';
import 'package:agrolyn_web/provider/login_notifier.dart';
import 'package:agrolyn_web/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});
  final keyfrom = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginNotifier(context: context),
      child: Consumer<LoginNotifier>(
          builder: (context, value, child) => Scaffold(
                appBar: AppBar(
                  title: const Text("Lupa Kata Sandi"),
                ),
                body: Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.all(16),
                    width: MediaQuery.of(context).size.width > 700
                        ? MediaQuery.of(context).size.width * 0.5
                        : MediaQuery.of(context).size.width * 0.9,
                    child: Form(
                      key: value.keyfrom,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(ImageAssets.forgot),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          const Text(
                            "masukkan alamat email yang terkait dengan akun Anda dan kami akan mengirimkan email untuk mengatur ulang kata sandi Anda",
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          TextFormField(
                            controller: value.emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            validator: (e) {
                              if (e!.isEmpty) {
                                return "Email Tidak Boleh Kosong";
                              }
                              return null; // Mengembalikan null jika valid
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () {
                                print(value.emailController.text);
                                if (value.keyfrom.currentState!.validate()) {
                                  value.setLoading(true);
                                  AuthService()
                                      .forgotPassword(
                                        context,
                                        value.emailController.text,
                                      )
                                      .whenComplete(
                                          () => value.setLoading(false));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              child: value.isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      'Reset Kata Sandi',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
    );
  }
}
