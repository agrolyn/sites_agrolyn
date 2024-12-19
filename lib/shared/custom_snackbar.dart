import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

void showCustomSnackbar(
    context, String title, String message, ContentType type) {
  SnackBar myBanner = SnackBar(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    width: MediaQuery.of(context).size.width,
    duration: const Duration(seconds: 3),
    padding: const EdgeInsets.all(20),
    content: AwesomeSnackbarContent(
      title: title,
      message: message,

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      contentType: type,
      // to configure for material banner
      inMaterialBanner: true,
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentMaterialBanner()
    ..showSnackBar(myBanner);
}
