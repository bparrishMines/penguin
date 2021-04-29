library penguin_camera;

import 'package:penguin_camera/src/platform_interface.dart';

export 'src/platform_interface.dart' hide PenguinCameraPlatform;

void main() async {
  List<CameraDevice> devices = await PenguinCamera.getAllCameraDevices();
  CameraDevice device = devices.first;
  CameraController controller = CameraController(device);

  controller.initialize();
  controller.getPreview();
  controller.start();
  controller.dispose();
}