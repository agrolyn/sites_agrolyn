import 'dart:ui';

import 'package:agrolyn_web/service/auth_service.dart';
import 'package:agrolyn_web/provider/login_notifier.dart';
import 'package:agrolyn_web/utils/assets_path.dart';
import 'package:agrolyn_web/utils/responsive.dart';
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
                body: Stack(
                  children: [
                    Image.asset(
                      ImageAssets.bgSore, // Path animasi Anda
                      width: double.infinity, // Lebar penuh
                      height: double.infinity, // Tinggi penuh
                      fit: BoxFit
                          .cover, // Menyesuaikan animasi agar memenuhi area
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
                                width: Responsive.isMobile(context)
                                    ? double.infinity
                                    : Responsive.isTablet(context)
                                        ? 500
                                        : 600,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(
                                      0.2), // Semi-transparent color
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                    'Atur Ulang Kata Sandi',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              const Text(
                                                'masukkan alamat email yang terkait dengan akun Anda dan kami akan mengirimkan email untuk mengatur ulang kata sandi Anda',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 32,
                                        ),
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
                                              if (value.keyfrom.currentState!
                                                  .validate()) {
                                                value.setLoading(true);
                                                AuthService()
                                                    .forgotPassword(
                                                      context,
                                                      value
                                                          .emailController.text,
                                                    )
                                                    .whenComplete(() => value
                                                        .setLoading(false));
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
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 56,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, '/login');
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                            ),
                                            child: const Text(
                                              'Masih ingat kata sandi? Masuk disini',
                                              style: TextStyle(
                                                  color: Colors.green,
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
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Center(
                //   child: Container(
                //     padding: const EdgeInsets.all(16),
                //     margin: const EdgeInsets.all(16),
                //     width: MediaQuery.of(context).size.width > 700
                //         ? MediaQuery.of(context).size.width * 0.5
                //         : MediaQuery.of(context).size.width * 0.9,
                //     child: Form(
                //       key: value.keyfrom,
                //       child: Column(
                //         children: [
                //           ClipRRect(
                //             borderRadius: BorderRadius.circular(16),
                //             child: Image.asset(ImageAssets.forgot),
                //           ),
                //           const SizedBox(
                //             height: 32,
                //           ),
                //           const Text(
                //             "masukkan alamat email yang terkait dengan akun Anda dan kami akan mengirimkan email untuk mengatur ulang kata sandi Anda",
                //             style: TextStyle(fontSize: 16),
                //             textAlign: TextAlign.center,
                //           ),
                //           const SizedBox(
                //             height: 26,
                //           ),
                //           TextFormField(
                //             controller: value.emailController,
                //             decoration: InputDecoration(
                //               labelText: 'Email',
                //               border: OutlineInputBorder(
                //                 borderRadius: BorderRadius.circular(16),
                //               ),
                //             ),
                //             validator: (e) {
                //               if (e!.isEmpty) {
                //                 return "Email Tidak Boleh Kosong";
                //               }
                //               return null; // Mengembalikan null jika valid
                //             },
                //           ),
                //           const SizedBox(
                //             height: 16,
                //           ),
                //           SizedBox(
                //             width: double.infinity,
                //             height: 56,
                //             child: ElevatedButton(
                //               onPressed: () {
                //                 print(value.emailController.text);
                //                 if (value.keyfrom.currentState!.validate()) {
                //                   value.setLoading(true);
                //                   AuthService()
                //                       .forgotPassword(
                //                         context,
                //                         value.emailController.text,
                //                       )
                //                       .whenComplete(
                //                           () => value.setLoading(false));
                //                 }
                //               },
                //               style: ElevatedButton.styleFrom(
                //                 backgroundColor: Colors.green,
                //               ),
                //               child: value.isLoading
                //                   ? const CircularProgressIndicator(
                //                       color: Colors.white,
                //                     )
                //                   : const Text(
                //                       'Reset Kata Sandi',
                //                       style: TextStyle(
                //                           color: Colors.white,
                //                           fontSize: 16,
                //                           fontWeight: FontWeight.bold),
                //                     ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              )),
    );
  }
}
