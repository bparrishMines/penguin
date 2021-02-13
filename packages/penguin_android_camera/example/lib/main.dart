// @dart=2.9

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:penguin_android_camera/penguin_android_camera.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Camera _camera;
  Widget _previewWidget = Container();
  int _cameraFacing = CameraInfo.cameraFacingFront;
  final double _deviceRotation = 0;

  @override
  void initState() {
    super.initState();
    PenguinAndroidCamera.initialize();
    _getCameraPermission();

    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);
  }

  Future<void> _getCameraPermission() async {
    while (!await Permission.camera.request().isGranted) {}
    _setupCamera();
  }

  Future<void> _setupCamera() async {
    final List<CameraInfo> allCameraInfo = await Camera.getAllCameraInfo();

    final CameraInfo cameraInfo = allCameraInfo.firstWhere(
      (CameraInfo info) => info.facing == _cameraFacing,
    );

    _camera = await Camera.open(cameraInfo.cameraId);
    _camera.startPreview();
    final int textureId = await _camera.attachPreviewToTexture();

    setState(() {
      _previewWidget = _createCameraPreview(
        cameraInfo,
        Texture(textureId: textureId),
      );
    });
  }

  RotatedBox _createCameraPreview(CameraInfo cameraInfo, Texture texture) {
    Widget cameraWidget = texture;
    int rotation = 0;
    if (cameraInfo.facing == CameraInfo.cameraFacingFront) {
      rotation = (cameraInfo.orientation + 180) % 360;
      cameraWidget = Transform(
        transform: Matrix4.rotationY(pi),
        alignment: Alignment.center,
        child: cameraWidget,
      );
    } else if (cameraInfo.facing == CameraInfo.cameraFacingBack) {
      rotation = cameraInfo.orientation;
    }

    return RotatedBox(
      quarterTurns: (rotation / 90).floor(),
      child: cameraWidget,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _camera?.releaseTexture();
    _camera?.release();
  }

  Future<void> _toggleLensDirection() {
    if (_camera == null) return Future<void>.value();

    _camera?.releaseTexture();
    _camera?.release();
    _camera = null;

    setState(() {
      _previewWidget = null;
    });

    _cameraFacing = (_cameraFacing + 1) % 2;

    return _setupCamera();
  }

  Widget _buildPictureButton() {
    return InkResponse(
      onTap: () {},
      child: Container(
        width: 65,
        height: 65,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey, width: 2)),
        child: const Icon(
          Icons.camera,
          color: Colors.grey,
          size: 60,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: Colors.black),
              child: _previewWidget ?? Container(),
            ),
          ),
          Container(
            decoration: const BoxDecoration(color: Colors.black),
            padding: const EdgeInsets.only(
              bottom: 30,
              left: 10,
              right: 10,
              top: 15,
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  alignment: Alignment.centerLeft,
                  child: Transform.rotate(
                    angle: _deviceRotation,
                    child: IconButton(
                      icon: const Icon(
                        Icons.switch_camera,
                        color: Colors.white,
                        size: 32,
                      ),
                      onPressed: _toggleLensDirection,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: _buildPictureButton(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
