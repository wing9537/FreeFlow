import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';

class Camera {
  static final Camera provider = Camera();

  late List<CameraDescription> _cameras;

  CameraDescription get front => _cameras.last;

  CameraDescription get back => _cameras.first;

  CameraDescription get(int index) => index % 2 == 0 ? back : front;

  void connectCamera() async {
    // Ensure that plugin services are initialized so that `availableCameras()`
    WidgetsFlutterBinding.ensureInitialized();

    // Obtain a list of the available cameras on the device.
    _cameras = await availableCameras();
  }
}
