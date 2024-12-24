import 'package:agrolyn_web/main.dart';
import 'package:agrolyn_web/shared/custom_snackbar.dart';
import 'package:agrolyn_web/view/auth/login_page.dart';
import 'package:agrolyn_web/view/home/home_page.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Dio _dio = Dio();
  late SharedPreferences sharedPreferences;

  // Menambahkan setter untuk sharedPreferences
  set setSharedPreferences(SharedPreferences prefs) {
    sharedPreferences = prefs;
  }

  // Menambahkan setter untuk dio
  set setDio(Dio dio) {
    _dio = dio;
  }

  AuthService() {
    _dio.options.baseUrl = "https://apiv1.agrolyn.online";
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    // _dio.options.followRedirects = true;
    // _dio.options.validateStatus = (status) => true;
  }

  // Fungsi untuk login
  Future<bool> login(
      BuildContext context, String email, String password) async {
    try {
      final response = await _dio.post(
        "/login/",
        data: {
          "email": email.toString(),
          "password": password.toString(),
        },
      );

      // print(response);
      if (response.statusCode == 200) {
        // Simpan token di SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('refresh_token', response.data['refresh_token']);
        await prefs.setString('access_token', response.data['access_token']);
        await prefs.setString('name', response.data['name']);
        await prefs.setString('address', response.data['address']);
        await prefs.setString('phone_number', response.data['phone_number']);
        await prefs.setString('email', response.data['email']);
        await prefs.setString('id', response.data['id'].toString());
        await prefs.setString('img_profile', response.data['img_profile']);
        await prefs.setString('roles_id', response.data['roles_id'].toString());

        if (response.data['roles_id'] == 2) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ResponsiveLayout(
                      mobileBody: MobileScreen(),
                      desktopBody: DesktopScreen(),
                    )),
          );
        }

        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      print("Login error: $e");
      showCustomSnackbar(context, "Login Gagal",
          "Periksa email dan kata sandi anda", ContentType.failure);
      return false;
    }
  }

  Future<bool> register(
    BuildContext context,
    int id,
    String name,
    String email,
    String phoneNumber,
    String address,
    String password,
  ) async {
    try {
      final response = await _dio.post(
        "https://apiv1.agrolyn.online/register/",
        data: {
          "roles_id": id,
          "name": name,
          "email": email,
          "phone_number": phoneNumber,
          "address": address,
          "password": password,
        },
      );

      if (response.statusCode == 201) {
        showCustomSnackbar(
          context,
          "Pendaftaran Berhasil",
          "Silakan cek email Anda untuk verifikasi akun",
          ContentType.success,
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
        return true;
      } else {
        // Menampilkan status code jika bukan 201
        print("Response status code: ${response.statusCode}");
        print("Response data: ${response.data}");
        showCustomSnackbar(
          context,
          "Pendaftaran Gagal",
          "Pendaftaran akun gagal, silakan dicoba lagi",
          ContentType.failure,
        );
        return false;
      }
    } on DioException catch (e) {
      // Menampilkan lebih detail tentang error
      print("Register error: ${e.response?.data ?? 'Unknown error'}");
      print("Error message: ${e.message}");
      print("Error type: ${e.type}");
      print("Error request: ${e.requestOptions}");
      showCustomSnackbar(
        context,
        "Gagal Daftar",
        "Pendaftaran akun gagal, silakan dicoba lagi",
        ContentType.failure,
      );
      return false;
    } catch (e) {
      print("Unexpected error: $e");
      showCustomSnackbar(
        context,
        "Gagal Daftar",
        "Terjadi kesalahan yang tidak terduga, silakan coba lagi",
        ContentType.failure,
      );
      return false;
    }
  }

  // edit profile
  // Future<bool> editProfile(context, FormData formData) async {
  //   print(formData.fields);
  //   try {
  //     final token = await getToken();
  //     final response = await _dio.put(
  //       "/edit-profile/",
  //       data: formData,
  //       options: Options(headers: {
  //         'Authorization': 'Bearer $token',
  //       }),
  //     );
  //     // print(response);
  //     if (response.statusCode == 200) {
  //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //       await prefs.setString('name', formData.fields[0].value);
  //       await prefs.setString('address', formData.fields[1].value);
  //       await prefs.setString('phone_number', formData.fields[2].value);
  //       PersistentTabController profile =
  //           PersistentTabController(initialIndex: 4);

  //       showCustomSnackbar(context, "Data Tersimpan",
  //           "Berhasil Menyimpan perubahan data", ContentType.success);
  //       Future.delayed(const Duration(seconds: 3), () {
  //         pushWithNavBar(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => Menu(
  //                       page: profile,
  //                     )));
  //       });
  //       print(response.data);
  //       return true;
  //     }
  //     return false;
  //   } on DioException catch (e) {
  //     print("Update Profile error: ${e.response?.data['message']}");
  //     showCustomSnackbar(
  //         context,
  //         "Gagal Menyimpan Data",
  //         "Gagal Menyimpan perubahan data, silahkan coba lagi",
  //         ContentType.failure);

  //     return false;
  //   }
  // }

  // Fungsi untuk mengambil token
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<String?> refreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('refresh_token');
    try {
      final response = await _dio.post(
        "/refresh-token/",
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      if (response.statusCode == 200) {
        // print(response.data);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', response.data['access_token']);
        return "berhasil memperbarui token";
      } else {
        return "gagal memperbarui token";
      }
    } on DioException catch (e) {
      print("Refresh Token error: ${e.response?.data['message']}");
      return "DIO Error: ${e.response?.data['message']}";
    }
  }

  // Fungsi untuk logout
  // Future<void> logout(context) async {
  //   // buatkan code untuk logout dengan endpoint /logout dan menambahkan token bernama 'access_token' di header
  //   final token = await getToken();
  //   print("Token: $token");
  //   if (token != null) {
  //     try {
  //       final res = await _dio.post(
  //         "/logout/",
  //         options: Options(headers: {
  //           'Authorization': 'Bearer $token',
  //         }),
  //       );

  //       if (res.statusCode == 200) {
  //         SharedPreferences prefs = await SharedPreferences.getInstance();
  //         await prefs.remove('access_token');
  //         pushReplacementWithoutNavBar(context,
  //             MaterialPageRoute(builder: (context) => const LoginPage()));
  //       }
  //     } on DioException catch (e) {
  //       print("Register error: ${e.response?.data['message']}");
  //       showCustomSnackbar(context, "Gagal Logout",
  //           "Logout gagal, silahkan dicoba lagi", ContentType.failure);
  //     }
  //   }
  // }

  // reset password
  Future<bool> forgotPassword(context, String email) async {
    print(email);
    try {
      final response = await _dio.post(
        "/forgot_password/",
        data: {
          "email": email.toString(),
        },
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );
      print(response);
      if (response.statusCode == 200) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
        showCustomSnackbar(
            context,
            "Permintaan Berhasil",
            "Permintaan Reset kata sandi telah dikirimkan ke alamat email anda",
            ContentType.success);
        print(response.data);
        return true;
      }
      return false;
    } on DioException catch (e) {
      print("error dio: $e");
      showCustomSnackbar(
          context,
          "Permintaan Gagal",
          "Gagal Mengirimkan Permintaan Reset kata sandi, silahkan coba lagi",
          ContentType.failure);

      return false;
    } catch (e) {
      print("error : $e");
      return false;
    }
  }
}
