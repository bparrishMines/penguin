// @dart=2.9

import 'dart:math';
import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
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
  MediaRecorder _mediaRecorder;

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
    while (!await Permission.storage.request().isGranted) {}
    while (!await Permission.microphone.request().isGranted) {}
    _setupCamera();
  }

  Future<void> _setupCamera() async {
    final List<CameraInfo> allCameraInfo = await Camera.getAllCameraInfo();

    final CameraInfo cameraInfo = allCameraInfo.firstWhere(
      (CameraInfo info) => info.facing == _cameraFacing,
    );

    _camera = await Camera.open(cameraInfo.cameraId);
    _camera.startPreview();
    final int textureId = await _camera.attachPreviewTexture();

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
    _camera?.releasePreviewTexture();
    _camera?.release();
  }

  Future<void> _toggleLensDirection() {
    if (_camera == null) return Future<void>.value();

    _camera?.releasePreviewTexture();
    _camera?.release();
    _camera = null;

    setState(() {
      _previewWidget = null;
    });

    _cameraFacing = (_cameraFacing + 1) % 2;

    return _setupCamera();
  }

  Future<Directory> _storageDir() async {
    final List<Directory> dirs =
        await getExternalStorageDirectories(type: StorageDirectory.dcim);
    print(dirs[0]);
    print(dirs[0].path);
    return dirs[0];
  }

  void _takePicture() {
    _camera?.takePicture(
      null,
      null,
      null,
      JpegPictureCallback(_camera, (data) async {
        final Directory dir = await _storageDir();
        final File imageFile = File('${dir.path}/my_image${data.hashCode}.jpg');
        imageFile.writeAsBytes(data);
      }),
    );
  }

  Future<void> _recordAVideo() async {
    final Directory dir = await _storageDir();
    _mediaRecorder = MediaRecorder(
      camera: _camera,
      outputFormat: OutputFormat.mpeg4,
      outputFilePath: '${dir.path}/my_video${Random().nextInt(10000)}.mp4',
      videoEncoder: VideoEncoder.mpeg4Sp,
      audioSource: AudioSource.defaultSource,
      audioEncoder: AudioEncoder.amrNb,
    );
    _camera.unlock();
    _mediaRecorder.prepare();
    _mediaRecorder.start();
    await Future<void>.delayed(Duration(seconds: 8));
    _mediaRecorder.stop();
    _mediaRecorder.release();
  }

  void _stopRecording() {}

  Widget _buildPictureButton() {
    return InkResponse(
      onTap: () {
        _recordAVideo();
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

class JpegPictureCallback extends PictureCallback {
  JpegPictureCallback(this.camera, this.onData);

  final Camera camera;

  void Function(Uint8List data) onData;

  @override
  void onPictureTaken(Uint8List data) {
    print('Image taken with jpeg data length: ${data.length}');
    onData(data);
    camera.startPreview();
  }
}
