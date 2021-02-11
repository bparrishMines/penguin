// @dart=2.9

import 'package:flutter/material.dart';
import 'package:penguin_android_camera/penguin_android_camera.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Camera camera;
  Widget _previewWidget = Container();

  @override
  void initState() {
    super.initState();
    _getCameraPermission();
  }

  void _getCameraPermission() async {
    while (!await Permission.camera.request().isGranted) {}
    _setupCamera();
  }

  void _setupCamera() async {
    final List<CameraInfo> allCameraInfo = await Camera.getAllCameraInfo();

    camera = await Camera.open(
      allCameraInfo
          .firstWhere((CameraInfo info) =>
              info.facing == CameraInfo.CAMERA_FACING_FRONT)
          .cameraId,
    );
    camera.startPreview();
    final int textureId = await camera.attachPreviewToTexture();

    setState(() {
      _previewWidget = Texture(textureId: textureId);
    });
  }

  @override
  void dispose() {
    super.dispose();
    camera?.releaseTexture();
    camera?.release();
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
