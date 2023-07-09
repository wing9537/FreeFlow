import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:free_flow/common/camera.dart';
import 'package:free_flow/state/diary_form.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class TakePhoto extends StatefulWidget {
  const TakePhoto({super.key});

  @override
  State<StatefulWidget> createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  final _picker = ImagePicker();
  int _counter = 0;

  void _takePhoto() async {
    try {
      // ensure that the camera is initialized
      await _initializeControllerFuture;

      // attempt to take a picture and get the file `image` where it was saved
      final XFile photo = await _controller.takePicture();
      final Uint8List byte = await photo.readAsBytes();
      if (mounted) {
        context.read<DiaryFormState>().addPhoto(byte);
        Navigator.pop(context);
      }
    } catch (e) {
      print("Error on take photo: $e");
    }
  }

  void _openGallery() async {
    final DiaryFormState state = context.read();
    final List<XFile> photos = await _picker.pickMultiImage(imageQuality: 30);
    if (photos.isNotEmpty) {
      for (XFile photo in photos) {
        state.addPhoto(await photo.readAsBytes());
      }
      if (mounted) Navigator.pop(context);
    }
  }

  void _toggleCamera() {
    // to display the current output from the Camera
    _controller = CameraController(
      Camera.provider.get(_counter),
      ResolutionPreset.medium,
    );
    // initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
    setState(() => _counter += 1);
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        _openGallery();
        break;
      case 1:
        _takePhoto();
        break;
      case 2:
        _toggleCamera();
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _toggleCamera();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Take Photo")),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 80,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.photo_library), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.camera), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.cameraswitch), label: ""),
        ],
        currentIndex: 1,
        onTap: _onItemTapped,
      ),
    );
  }
}
