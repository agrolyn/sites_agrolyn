import 'package:agrolyn_web/provider/detection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseTypesScan extends StatelessWidget {
  const ChooseTypesScan({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetectionNotifier(context: context),
      child: Consumer<DetectionNotifier>(builder: (context, value, child) {
        return Scaffold(
            body: Center(
          child: ElevatedButton(
              onPressed: value.pickAndUploadFile,
              child: value.predictionIsLoading
                  ? const CircularProgressIndicator()
                  : const Text("Upload Image")),
        ));
      }),
    );
  }
}
