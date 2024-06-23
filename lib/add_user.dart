import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  bool _isCameraReady = false;
  
  get cameras => null;

  Future<void> _toggleCamera() async {
    CameraLensDirection newDirection =
        _controller.description.lensDirection == CameraLensDirection.back
            ? CameraLensDirection.front
            : CameraLensDirection.back;

    CameraDescription newCamera =
        cameras.firstWhere((camera) => camera.lensDirection == newDirection);
    await _controller.dispose();
      _controller = CameraController(newCamera, ResolutionPreset.medium);
    await _controller.initialize();
    setState(() {});
    }

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    List<CameraDescription> cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    await _controller.initialize();
    if (!mounted) {
      return;
    }
    setState(() {
      _isCameraReady = true;
    });
  }

  Future<void> _takePicture() async {
    try {
      XFile picture = await _controller.takePicture();

    // Get the path to the application documents directory
    final directory = await getApplicationDocumentsDirectory();

    // Create a new file in the directory
    final file = File('${directory.path}/${DateTime.now()}.jpg');

    // Save the picture to the file
    await file.writeAsBytes(await picture.readAsBytes());

    // Print the path to the saved image
    print('Image saved to: ${file.path}');
    } catch (e) {
      // ignore: avoid_print
      print("Error taking picture: $e");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraReady) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      body: CameraPreview(_controller),
      drawerScrimColor: Colors.white,
      floatingActionButton: Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: <Widget>[
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton(
        onPressed: _toggleCamera,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.switch_camera),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton(
        onPressed: _takePicture,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.camera),
      ),
    ),
  ],
  ),
      );
  }
}




