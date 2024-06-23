import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class SelfieCapturePage extends StatefulWidget {
  @override
  _SelfieCapturePageState createState() => _SelfieCapturePageState();
}

class _SelfieCapturePageState extends State<SelfieCapturePage> {
  late CameraController _cameraController;
  bool _cameraInitialized = false;
  bool _capturingSelfie = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    _cameraController = CameraController(
      camera,
      ResolutionPreset.medium,
    );

    _cameraInitialized = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selfie Capture'),
      ),
      body: _cameraInitialized
          ? Stack(
              children: [
                CameraPreview(_cameraController),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: _capturingSelfie ? null : captureSelfie,
                      child: _capturingSelfie
                          ? const CircularProgressIndicator()
                          : const Text('Capture Selfie'),
                    ),
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Future<void> captureSelfie() async {
    setState(() {
      _capturingSelfie = true;
    });

    try {
      final path = join(
        (await getTemporaryDirectory()).path,
        'selfie.png',
      );
      await _cameraController.takePicture();

      Navigator.pop(context as BuildContext, path);
    } catch (e) {
      // Error handling
    } finally {
      setState(() {
        _capturingSelfie = false;
      });
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }
}