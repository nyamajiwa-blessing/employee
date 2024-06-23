// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   List<CameraDescription> cameras = await availableCameras();
//   runApp(TakePicture(cameras: cameras));
// }

// class TakePicture extends StatelessWidget {
//   final List<CameraDescription> cameras;

//   const TakePicture({super.key, required this.cameras});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: TakePictureScreen(camera: cameras.first),
//     );
//   }
// }

// class TakePictureScreen extends StatefulWidget {
//   final CameraDescription camera;

//   const TakePictureScreen({super.key, required this.camera});

//   @override
//   _TakePictureScreenState createState() => _TakePictureScreenState();
// }

// class _TakePictureScreenState extends State<TakePictureScreen> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;

//   @override
//   void initState() {
//     super.initState();
//     _controller = CameraController(widget.camera, ResolutionPreset.medium);
//     _initializeControllerFuture = _controller.initialize();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Take a Picture')),
//       body: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return CameraPreview(_controller);
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           try {
//             XFile picture = await _controller.takePicture();
//             // Store the image in the local database
//             saveImageToDatabase(picture.path);
//           } catch (e) {
//             print('Error taking picture: $e');
//           }
//         },
//         child: const Icon(Icons.camera),
//       ),
//     );
//   }
// }

// Future<void> saveImageToDatabase(String imagePath) async {
//   Database database = await openDatabase(
//     join(await getDatabasesPath(), 'images_database.db'),
//     onCreate: (db, version) {
//       return db.execute(
//         'CREATE TABLE images(id INTEGER PRIMARY KEY, path TEXT)',
//       );
//     },
//     version: 1,
//   );

//   await database.insert(
//     'images',
//     {'path': imagePath},
//     conflictAlgorithm: ConflictAlgorithm.replace,
//   );
// }