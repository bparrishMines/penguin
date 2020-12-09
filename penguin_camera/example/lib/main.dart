import 'package:flutter/material.dart';
import 'package:penguin_camera/penguin_camera.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget _previewWidget = Container();

  @override
  void initState() {
    super.initState();
    PenguinCamera.initialize();
    _getCameraPermission();
  }

  void _getCameraPermission() async {
    while (!await Permission.camera.request().isGranted) {}
    _setupCamera();
  }

  void _setupCamera() async {
    final List<CameraDevice> devices =
        await PenguinCamera.getAllCameraDevices();
    final CameraController controller = CameraController(devices.first);
    await controller.initialize();

    controller.getPreview().then((Widget previewWidget) {
      setState(() {
        _previewWidget = previewWidget;
        controller.start();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Container(width: 200, height: 200, child: _previewWidget),
        ),
      ),
    );
  }
}
