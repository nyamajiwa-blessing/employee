import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    availableCameras().then((cameras) {
      if (cameras.isEmpty) {
        print('No cameras available');
        return;
      }
      final camera = cameras.first;
      _controller = CameraController(
        camera,
        ResolutionPreset.high,
      );
      _controller?.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _controller != null && _controller!.value.isInitialized
                ? CameraPreview(_controller!)
                : Container(),
          ),
          ElevatedButton.icon(
            onPressed: () async {
              final pickedFile =
                  await picker.pickImage(source: ImageSource.camera);
              if (pickedFile != null) {
                // Do something with the picked file
              }
            },
            icon: const Icon(Icons.camera),
            label: const Text('Capture'),
          ),
        ],
      ),
    );
  }
}