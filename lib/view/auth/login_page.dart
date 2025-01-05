import 'dart:ui';

import 'package:agrolyn_web/provider/login_notifier.dart';
import 'package:agrolyn_web/service/auth_service.dart';
import 'package:agrolyn_web/utils/assets_path.dart';
import 'package:agrolyn_web/utils/responsive.dart';
import 'package:agrolyn_web/view/auth/register_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  final BuildContext context;
  LoginPage({super.key, required this.context}) {
    init();
  }

  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isLogedin') != null) {
      Navigator.pushReplacementNamed(context, '/navbar');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginNotifier(context: context),
      child: Consumer<LoginNotifier>(
        builder: (context, value, child) {
          return Scaffold(
            body: Stack(
              children: [
                Image.asset(
                  ImageAssets.bgMalam, // Path animasi Anda
                  width: double.infinity, // Lebar penuh
                  height: double.infinity, // Tinggi penuh
                  fit: BoxFit.cover, // Menyesuaikan animasi agar memenuhi area
                ),
                Form(
                  key: value.keyfrom,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          child: Container(
                            height: MediaQuery.of(context).size.height - 190,
                            width: Responsive.isMobile(context)
                                ? double.infinity
                                : Responsive.isTablet(context)
                                    ? 500
                                    : 600,
                            decoration: BoxDecoration(
                              color: Colors.white
                                  .withOpacity(0.2), // Semi-transparent color
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                color: Colors.white
                                    .withOpacity(0.4), // Border color
                                width: 1.5,
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Center(
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            ImageAssets.logo,
                                            height: 192,
                                            width: 192,
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Masuk Agrolyn',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          const Text(
                                            'Silahkan Masuk untuk melanjutkan',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 32),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 8),
                                        TextFormField(
                                          controller: value.emailController,
                                          decoration: InputDecoration(
                                            labelText: 'Email',
                                            labelStyle: const TextStyle(
                                                color: Colors
                                                    .white), // Warna teks label
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: const BorderSide(
                                                  color: Colors
                                                      .white), // Border saat tidak fokus
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: const BorderSide(
                                                  color: Colors
                                                      .white), // Border saat fokus
                                            ),
                                          ),
                                          style: const TextStyle(
                                              color: Colors.white),
                                          validator: (e) {
                                            if (e!.isEmpty) {
                                              return "Email Tidak Boleh Kosong";
                                            }
                                            return null; // Mengembalikan null jika valid
                                          },
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 16),

                                    // Section: Password Field
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 8),
                                        TextFormField(
                                          controller: value.passwordController,
                                          obscureText: value
                                              .isObscure, // Menyembunyikan input password
                                          decoration: InputDecoration(
                                            labelText: 'Kata Sandi',
                                            labelStyle: const TextStyle(
                                                color: Colors
                                                    .white), // Warna teks label
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: const BorderSide(
                                                  color: Colors
                                                      .white), // Border saat tidak fokus
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: const BorderSide(
                                                  color: Colors
                                                      .white), // Border saat fokus
                                            ),
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                value.toggleObscure();
                                              },
                                              icon: Icon(
                                                value.isObscure
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          style: const TextStyle(
                                              color: Colors.white),
                                          validator: (e) {
                                            if (e!.isEmpty) {
                                              return "Password Tidak Boleh Kosong";
                                            }
                                            return null; // Mengembalikan null jika valid
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),

                                    // Section: Forgot Password
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, '/forgot-password');
                                            },
                                            child: const Text(
                                              'Lupa Kata Sandi',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))
                                      ],
                                    ),
                                    const SizedBox(height: 16),

                                    // Section: Sign Up Button
                                    SizedBox(
                                      width: double.infinity,
                                      height: 56,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (value.keyfrom.currentState!
                                              .validate()) {
                                            value.setLoading(true);
                                            AuthService()
                                                .login(
                                                    context,
                                                    value.emailController.text,
                                                    value.passwordController
                                                        .text)
                                                .whenComplete(() =>
                                                    value.setLoading(false));
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
                                                'Masuk',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),

                                    // Section: Register Option
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Belum Punya Akun ?',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, '/register');
                                            },
                                            child: const Text(
                                              'Daftar Akun',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
