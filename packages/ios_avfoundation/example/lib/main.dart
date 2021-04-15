import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ios_avfoundation/ios_avfoundation.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late CaptureSession _captureSession;
  Widget _previewWidget = Container();
  int _cameraFacing = CaptureDevicePosition.back;
  final double _deviceRotation = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);

    _getCameraPermission();
  }

  Future<void> _getCameraPermission() async {
    while (!await Permission.camera.request().isGranted) {}
    while (!await Permission.microphone.request().isGranted) {}
    _setupCamera();
  }

  Future<void> _setupCamera() async {
    final List<CaptureDevice> devices =
        await CaptureDevice.devicesWithMediaType(MediaType.video);

    final CaptureDevice device = devices.firstWhere(
      (CaptureDevice device) => device.position == _cameraFacing,
    );

    _captureSession = CaptureSession();
    _captureSession.addInput(CaptureDeviceInput(device));
    _captureSession.startRunning();

    setState(() {
      _previewWidget = Preview(controller: PreviewController(_captureSession));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _captureSession.stopRunning();
  }

  Future<void> _toggleLensDirection() {
    _captureSession.stopRunning();
    setState(() => _previewWidget = Container());

    if (_cameraFacing == CaptureDevicePosition.back) {
      _cameraFacing = CaptureDevicePosition.front;
    } else if (_cameraFacing == CaptureDevicePosition.front) {
      _cameraFacing = CaptureDevicePosition.back;
    }

    return _setupCamera();
  }

  Widget _buildPictureButton() {
    return InkResponse(
      onTap: () {
        //_recordAVideo();
      },
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
              child: _previewWidget,
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
