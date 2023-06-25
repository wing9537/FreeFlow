import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:free_flow/common/camera.dart';
import 'package:free_flow/state/new_diary.dart';
import 'package:provider/provider.dart';

class TakePhoto extends StatefulWidget {
  const TakePhoto({super.key});

  @override
  State<StatefulWidget> createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  final CameraDescription _camera = Camera.provider.camera;

  void _takePhoto() async {
    try {
      // ensure that the camera is initialized
      await _initializeControllerFuture;

      // attempt to take a picture and get the file `image` where it was saved
      final XFile photo = await _controller.takePicture();
      final Uint8List byte = await photo.readAsBytes();
      if (!mounted) return;

      context.read<NewDiaryState>().addPhoto(byte);
      Navigator.pop(context);
    } catch (e) {
      print("Error on take photo: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    // to display the current output from the Camera
    _controller = CameraController(_camera, ResolutionPreset.medium);
    // initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      floatingActionButton: FloatingActionButton(
        onPressed: _takePhoto,
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
