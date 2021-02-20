// @dart=2.9

import 'dart:math';
import 'dart:typed_data';
//import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:ios_avfoundation/ios_avfoundation.dart';
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
  //Camera _camera;
  CaptureSession _captureSession;
  Widget _previewWidget = Container();
  int _cameraFacing = CaptureDevicePosition.back;
  final double _deviceRotation = 0;
  //MediaRecorder _mediaRecorder;

  @override
  void initState() {
    super.initState();
    Avfoundation.initialize();
    _getCameraPermission();

    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);
  }

  Future<void> _getCameraPermission() async {
    while (!await Permission.camera.request().isGranted) {}
    //while (!await Permission.storage.request().isGranted) {}
    while (!await Permission.microphone.request().isGranted) {}
    _setupCamera();
  }

  Future<void> _setupCamera() async {
    final List<CaptureDevice> devices =
        await CaptureDevice.devicesWithMediaType(MediaType.video);

    final CaptureDevice device = devices.firstWhere(
      (CaptureDevice device) => device.position == _cameraFacing,
    );

    _captureSession = CaptureSession(
      <CaptureDeviceInput>[CaptureDeviceInput(device)],
    );

    setState(() {
      _previewWidget = Preview(
        captureSession: _captureSession,
        onPreviewReady: (_) => _captureSession.startRunning(),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _captureSession?.stopRunning();
  }

  Future<void> _toggleLensDirection() {
    if (_captureSession == null) return Future<void>.value();

    _captureSession.stopRunning();
    _captureSession = null;
    setState(() => _previewWidget = null);

    if (_cameraFacing == CaptureDevicePosition.back) {
      _cameraFacing = CaptureDevicePosition.front;
    } else if (_cameraFacing == CaptureDevicePosition.front) {
      _cameraFacing = CaptureDevicePosition.back;
    }

    return _setupCamera();
  }

  // Future<Directory> _storageDir() async {
  //   final List<Directory> dirs =
  //   await getExternalStorageDirectories(type: StorageDirectory.dcim);
  //   print(dirs[0]);
  //   print(dirs[0].path);
  //   return dirs[0];
  // }

  // void _takePicture() {
  //   _camera?.takePicture(
  //     null,
  //     null,
  //     null,
  //     JpegPictureCallback(_camera, (data) async {
  //       final Directory dir = await _storageDir();
  //       final File imageFile = File('${dir.path}/my_image${data.hashCode}.jpg');
  //       imageFile.writeAsBytes(data);
  //     }),
  //   );
  // }

  // Future<void> _recordAVideo() async {
  //   final Directory dir = await _storageDir();
  //   _mediaRecorder = MediaRecorder(
  //     camera: _camera,
  //     outputFormat: OutputFormat.mpeg4,
  //     outputFilePath: '${dir.path}/my_video${Random().nextInt(10000)}.mp4',
  //     videoEncoder: VideoEncoder.mpeg4Sp,
  //     audioSource: AudioSource.defaultSource,
  //     audioEncoder: AudioEncoder.amrNb,
  //   );
  //   _camera.unlock();
  //   _mediaRecorder.prepare();
  //   _mediaRecorder.start();
  //   await Future<void>.delayed(Duration(seconds: 8));
  //   _mediaRecorder.stop();
  //   _mediaRecorder.release();
  // }

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
