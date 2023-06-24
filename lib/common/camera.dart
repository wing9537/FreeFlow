import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';

class Camera {
  static final Camera provider = Camera();

  late CameraDescription _camera;

  CameraDescription get camera => _camera;

  void connectCamera() async {
    // Ensure that plugin services are initialized so that `availableCameras()`
    WidgetsFlutterBinding.ensureInitialized();

    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    _camera = cameras.first;
  }
}
