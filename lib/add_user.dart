import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class ImageUpload extends StatefulWidget {
  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _uploadImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera); // You can use ImageSource.camera for camera
    if (pickedFile != null) {
      String fileName = basename(pickedFile.path);
      Reference storageRef = FirebaseStorage.instance.ref().child('images/$fileName');
      UploadTask uploadTask = storageRef.putFile(File(pickedFile.path));
      await uploadTask;
      String downloadURL = await storageRef.getDownloadURL();
      print('Image uploaded to Firebase: $downloadURL');
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Upload'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _uploadImage,
          child: const Text('Upload Image'),
        ),
      ),
    );
  }
}