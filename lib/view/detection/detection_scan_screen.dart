import 'package:agrolyn_web/service/detection_ext_service.dart';
import 'package:agrolyn_web/service/detection_service.dart';
import 'package:agrolyn_web/shared/constans.dart';
import 'package:agrolyn_web/view/detection/detection_result_screen.dart';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetectionScanScreen extends StatefulWidget {
  const DetectionScanScreen({super.key});

  @override
  _DetectionScanScreenState createState() => _DetectionScanScreenState();
}

class _DetectionScanScreenState extends State<DetectionScanScreen>
    with SingleTickerProviderStateMixin {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;
  late AnimationController _animationController;
  late Animation<double> _scanAnimation;
  late bool loading = false;
  late String imgPath;

  @override
  void initState() {
    super.initState();
    _initializeCamera();

    // Setup Animation Controller

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Speed of the scan line
    )..repeat(reverse: true);

    // Define the scan animation
    _scanAnimation =
        Tween<double>(begin: 0.0, end: .9).animate(_animationController);
  }

  Future<void> _initializeCamera() async {
    try {
      // Meminta izin akses kamera
      if (await Permission.camera.request().isGranted) {
        _cameras = await availableCameras();
        if (_cameras != null && _cameras!.isNotEmpty) {
          _cameraController = CameraController(
            _cameras![0],
            ResolutionPreset.high,
          );

          await _cameraController!.initialize();
          setState(() {
            _isCameraInitialized = true;
          });
        }
      } else {
        // Tangani jika izin tidak diberikan
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Izin kamera ditolak')),
        );
        print('Izin kamera ditolak');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _takePicture() async {
    if (!_cameraController!.value.isInitialized) return;

    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/${DateTime.now()}.png';

    try {
      await _cameraController!.takePicture().then((XFile file) async {
        setState(() {
          loading = true;
        });
        imgPath = file.path;
        var formData = FormData.fromMap({
          'img_pred':
              await MultipartFile.fromFile(file.path, filename: 'scan.jpg'),
        });
        var formData2 = FormData.fromMap({
          'img_pred':
              await MultipartFile.fromFile(file.path, filename: 'scan.jpg'),
        });
        await DetectionExtService()
            .fetchPredictCornDisease(formData)
            .whenComplete(() async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String disease = prefs.getString('disease') ?? '';
          await DetectionService()
              .fetchPredictCornDisease(disease, formData2)
              .whenComplete(() {
            setState(() {
              loading = false;
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DetectionResultScreen(),
              ),
            );
          });
        });
      });
    } catch (e) {
      print('Error taking picture: $e');
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isCameraInitialized
          ? Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height - 70,
                  child: AspectRatio(
                      aspectRatio: _cameraController!.value.aspectRatio,
                      child: Stack(
                        children: [
                          CameraPreview(_cameraController!),
                          // Scan Effect Overlay
                          AnimatedBuilder(
                            animation: _scanAnimation,
                            builder: (context, child) {
                              return CustomPaint(
                                painter: ScanPainter(
                                    scanPosition: _scanAnimation.value),
                                child: Container(),
                              );
                            },
                          ),
                        ],
                      )),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: loading ? null : _takePicture,
                  child: loading
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            color: Colors.green,
                            semanticsLabel: "Sedang Mengidentifikasi Tanaman",
                            semanticsValue: "Sedang Mengidentifikasi Tanaman",
                          ),
                        )
                      : const Text(
                          'Ambil Foto',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

class ScanPainter extends CustomPainter {
  final double scanPosition;

  ScanPainter({required this.scanPosition});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 1, 81, 180).withOpacity(0.5)
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;
    final lineY = size.height * scanPosition;
    canvas.drawLine(
      Offset(0, lineY),
      Offset(size.width, lineY),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
