import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:penguin_android_camera/penguin_android_camera.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MaterialApp(home: _MyApp()));
}

class _MyApp extends StatefulWidget {
  const _MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<_MyApp> {
  Camera? _camera;
  Widget _previewWidget = Container();
  int _cameraFacing = CameraInfo.cameraFacingFront;
  final double _deviceRotation = 0;
  late MediaRecorder _mediaRecorder;

  @override
  void initState() {
    super.initState();
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

    final Camera camera = await Camera.open(cameraInfo.cameraId);
    final CameraParameters params = await camera.getParameters();

    bool hasAutoFocus = false;
    final List<String> focusModes = await params.getSupportedFocusModes();
    if (focusModes.contains(CameraParameters.focusModeAuto)) {
      params.setFocusMode(CameraParameters.focusModeAuto);
      camera.setParameters(params);
      hasAutoFocus = true;
    }

    debugPrint((await params.getSupportedPreviewSizes()).toString());
    debugPrint((await params.getFocusAreas()).toString());

    late int result;
    if (cameraInfo.facing == CameraInfo.cameraFacingFront) {
      result = cameraInfo.orientation % 360;
      result = (360 - result) % 360;
    } else {
      result = (cameraInfo.orientation + 360) % 360;
    }
    camera.setDisplayOrientation(result);

    camera.startPreview();
    final int textureId = await camera.attachPreviewTexture();

    setState(() {
      _previewWidget = Texture(textureId: textureId);
    });

    if (hasAutoFocus) {
      camera.autoFocus((bool success) => debugPrint('AutoFocus: $success'));
    }

    _camera = camera;
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
      _previewWidget = Container();
    });

    _cameraFacing = (_cameraFacing + 1) % 2;

    return _setupCamera();
  }

  Future<Directory> _storageDir() async {
    final List<Directory>? dirs =
        await getExternalStorageDirectories(type: StorageDirectory.dcim);
    if (dirs == null) {
      throw StateError('Could not get storage directory.');
    }
    return dirs[0];
  }

  void _takePicture() {
    _camera?.takePicture(
      null,
      null,
      null,
      (Uint8List data) async {
        debugPrint('Image taken with jpeg data length: ${data.length}');
        final Directory dir = await _storageDir();
        final File imageFile = File('${dir.path}/my_image${data.hashCode}.jpg');
        imageFile.writeAsBytes(data);

        _camera!.startPreview();
      },
    );
  }

  // ignore: unused_element
  Future<void> _recordAVideo() async {
    if (_camera == null) {
      debugPrint('Camera is null.');
      return Future<void>.value();
    }

    final Directory dir = await _storageDir();

    _mediaRecorder = MediaRecorder();
    _mediaRecorder.setCamera(_camera!);
    _mediaRecorder.setVideoSource(VideoSource.camera);
    _mediaRecorder.setAudioSource(AudioSource.defaultSource);
    _mediaRecorder.setOutputFormat(OutputFormat.mpeg4);
    _mediaRecorder.setVideoEncoder(VideoEncoder.mpeg4Sp);
    _mediaRecorder.setAudioEncoder(AudioEncoder.amrNb);
    _mediaRecorder.setOutputFilePath(
      '${dir.path}/my_video${Random().nextInt(10000)}.mp4',
    );

    _camera!.unlock();
    _mediaRecorder.prepare();
    _mediaRecorder.start();
    await Future<void>.delayed(const Duration(seconds: 8));
    _mediaRecorder.stop();
    _mediaRecorder.release();
  }

  Widget _buildPictureButton() {
    return InkResponse(
      onTap: () {
        _takePicture();
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
