import 'package:camera/camera.dart';

class AppCameraController {
  AppCameraController._();
  static final AppCameraController _singleton = AppCameraController._();
  factory AppCameraController() => _singleton;

  List<CameraDescription>? _cameras;
  CameraDescription? _camera;

  Future<List<CameraDescription>?> getCameras() async {
    _cameras ??= await availableCameras();
    return _cameras;
  }

  Future<CameraDescription?> getFirstCamera() async {
    _camera ??= (await getCameras())?.first;
    return _camera;
  }
}
