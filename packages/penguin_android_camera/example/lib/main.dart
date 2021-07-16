// ignore_for_file: public_member_api_docs

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

enum CameraMode {
  prePicture,
  preVideo,
  picture,
  video,
  none,
  videoRecording,
}

class _MyApp extends StatefulWidget {
  const _MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<_MyApp> {
  CameraMode currentMode = CameraMode.none;

  late Camera _camera;
  late MediaRecorder _mediaRecorder;
  int _cameraPreviewTextureId = 0;

  int _cameraFacing = CameraInfo.cameraFacingFront;

  final double _deviceRotation = 0;

  @override
  void initState() {
    super.initState();
    _setupForPicture();

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom],
    );
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);
  }

  Future<void> _getPicturePermission() async {
    while (!(await Permission.camera.request().isGranted)) {}
    while (!(await Permission.storage.request().isGranted)) {}
  }

  Future<void> _getAudioPermission() async {
    while (!(await Permission.microphone.request().isGranted)) {}
  }

  Future<void> _setupForPicture() async {
    await _getPicturePermission();
    final Camera camera = await _setupCamera();

    final CameraParameters params = await camera.getParameters();

    final List<String> focusModes = await params.getSupportedFocusModes();
    if (focusModes.contains(CameraParameters.focusModeContinuousPicture)) {
      params.setFocusMode(CameraParameters.focusModeContinuousPicture);
      camera.setParameters(params);
    }

    camera.startPreview();
    _cameraPreviewTextureId = await camera.attachPreviewTexture();
    setState(() {
      currentMode = CameraMode.picture;
    });
  }

  Future<void> _setupForVideo() async {
    await _getAudioPermission();
    final Camera camera = await _setupCamera();

    final CameraParameters params = await camera.getParameters();

    final List<String> focusModes = await params.getSupportedFocusModes();
    if (focusModes.contains(CameraParameters.focusModeContinuousVideo)) {
      params.setFocusMode(CameraParameters.focusModeContinuousVideo);
      params.setRecordingHint(hint: true);
      camera.setParameters(params);
    }

    camera.startPreview();
    _cameraPreviewTextureId = await camera.attachPreviewTexture();
    setState(() {
      currentMode = CameraMode.video;
    });
  }

  Future<Camera> _setupCamera() async {
    final List<CameraInfo> allCameraInfo = await Camera.getAllCameraInfo();

    final CameraInfo cameraInfo = allCameraInfo.firstWhere(
      (CameraInfo info) => info.facing == _cameraFacing,
    );

    final Camera camera = await Camera.open(cameraInfo.cameraId);

    late int result;
    if (cameraInfo.facing == CameraInfo.cameraFacingFront) {
      result = cameraInfo.orientation % 360;
      result = (360 - result) % 360;
    } else {
      result = (cameraInfo.orientation + 360) % 360;
    }
    camera.setDisplayOrientation(result);

    _camera = camera;
    return camera;
  }

  @override
  void dispose() {
    super.dispose();
    if (currentMode != CameraMode.none) {
      _camera.releasePreviewTexture();
      _camera.release();
    }
  }

  Future<void> _toggleCameraMode() {
    switch (currentMode) {
      case CameraMode.prePicture:
      case CameraMode.preVideo:
      case CameraMode.none:
        return Future<void>.value();
      case CameraMode.picture:
        setState(() => currentMode = CameraMode.preVideo);
        _camera.releasePreviewTexture();
        _camera.release();
        return _setupForVideo();
      case CameraMode.video:
        setState(() => currentMode = CameraMode.prePicture);
        _camera.releasePreviewTexture();
        _camera.release();
        return _setupForPicture();
      case CameraMode.videoRecording:
        const SnackBar snackBar = SnackBar(
          content: Text('Please end video recording first.'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return Future<void>.value();
    }
  }

  Future<void> _toggleLensDirection(BuildContext context) {
    switch (currentMode) {
      case CameraMode.prePicture:
      case CameraMode.preVideo:
      case CameraMode.none:
        return Future<void>.value();
      case CameraMode.picture:
        setState(() => currentMode = CameraMode.prePicture);
        _camera.releasePreviewTexture();
        _camera.release();
        _cameraFacing = (_cameraFacing + 1) % 2;
        return _setupForPicture();
      case CameraMode.video:
        setState(() => currentMode = CameraMode.preVideo);
        _camera.releasePreviewTexture();
        _camera.release();
        _cameraFacing = (_cameraFacing + 1) % 2;
        return _setupForVideo();
      case CameraMode.videoRecording:
        const SnackBar snackBar = SnackBar(
          content: Text('Please end video recording first.'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return Future<void>.value();
    }
  }

  Future<Directory> _getStorageDir() async {
    final List<Directory>? dirs = await getExternalStorageDirectories(
      type: StorageDirectory.dcim,
    );
    if (dirs == null) {
      throw StateError('Could not get storage directory.');
    }
    return dirs[0];
  }

  void _takePicture(BuildContext context) {
    _camera.takePicture(
      null,
      null,
      null,
      PictureCallback((Uint8List data) async {
        debugPrint('Image taken with jpeg data length: ${data.length}');
        final Directory dir = await _getStorageDir();
        final File imageFile = File('${dir.path}/my_image${data.hashCode}.jpg');
        imageFile.writeAsBytes(data);

        final String message = 'Pictured stored at: $imageFile';
        debugPrint(message);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );

        _camera.startPreview();
      }),
    );
  }

  Future<void> _startRecording() async {
    final Directory dir = await _getStorageDir();

    _mediaRecorder = MediaRecorder();
    _mediaRecorder.setCamera(_camera);
    _mediaRecorder.setVideoSource(VideoSource.camera);
    _mediaRecorder.setAudioSource(AudioSource.defaultSource);
    _mediaRecorder.setOutputFormat(OutputFormat.mpeg4);
    _mediaRecorder.setVideoEncoder(VideoEncoder.mpeg4Sp);
    _mediaRecorder.setAudioEncoder(AudioEncoder.amrNb);
    _mediaRecorder.setOutputFilePath(
      '${dir.path}/my_video${Random().nextInt(10000)}.mp4',
    );
    _camera.unlock();
    _mediaRecorder.prepare();
    _mediaRecorder.start();

    setState(() {
      currentMode = CameraMode.videoRecording;
    });
  }

  void _stopRecording() {
    _mediaRecorder.stop();
    _mediaRecorder.release();

    setState(() {
      currentMode = CameraMode.video;
    });
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
              child: CameraPreview(
                textureId: _cameraPreviewTextureId,
                cameraMode: currentMode,
              ),
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
                      onPressed: () => _toggleLensDirection(context),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: CameraButton(
                    cameraMode: currentMode,
                    onTakePicture: () => _takePicture(context),
                    onStartRecording: _startRecording,
                    onStopRecording: _stopRecording,
                  ),
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(color: Colors.black),
            child: ToggleButtons(
              color: Colors.blue,
              fillColor: Colors.grey,
              selectedColor: Colors.blue,
              onPressed: (int index) {
                if (index == 0 && currentMode != CameraMode.picture) {
                  _toggleCameraMode();
                } else if (index == 1 && currentMode != CameraMode.video) {
                  _toggleCameraMode();
                }
              },
              isSelected: <bool>[
                currentMode == CameraMode.picture ||
                    currentMode == CameraMode.prePicture,
                currentMode == CameraMode.video ||
                    currentMode == CameraMode.preVideo ||
                    currentMode == CameraMode.videoRecording,
              ],
              children: const <Widget>[
                Icon(Icons.camera_alt),
                Icon(Icons.videocam),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CameraPreview extends StatelessWidget {
  const CameraPreview({
    Key? key,
    required this.textureId,
    required this.cameraMode,
  }) : super(key: key);

  final int textureId;

  final CameraMode cameraMode;

  @override
  Widget build(BuildContext context) {
    switch (cameraMode) {
      case CameraMode.picture:
      case CameraMode.video:
      case CameraMode.videoRecording:
        return Texture(textureId: textureId);
      case CameraMode.prePicture:
      case CameraMode.preVideo:
      case CameraMode.none:
        return Container();
    }
  }
}

class CameraButton extends StatelessWidget {
  const CameraButton({
    Key? key,
    required this.cameraMode,
    required this.onTakePicture,
    required this.onStartRecording,
    required this.onStopRecording,
  }) : super(key: key);

  final CameraMode cameraMode;
  final VoidCallback onTakePicture;
  final Future<void> Function() onStartRecording;
  final VoidCallback onStopRecording;

  @override
  Widget build(BuildContext context) {
    switch (cameraMode) {
      case CameraMode.picture:
      case CameraMode.prePicture:
        return CircledIconButton(icon: Icons.camera_alt, onTap: onTakePicture);
      case CameraMode.video:
      case CameraMode.preVideo:
        return CircledIconButton(icon: Icons.videocam, onTap: onStartRecording);
      case CameraMode.videoRecording:
        return CircledIconButton(
          icon: Icons.videocam,
          color: Colors.red,
          onTap: onStopRecording,
        );
      case CameraMode.none:
        return Container();
    }
  }
}

class CircledIconButton extends StatelessWidget {
  const CircledIconButton({
    Key? key,
    required this.icon,
    this.onTap,
    this.color = Colors.white,
  }) : super(key: key);

  final IconData icon;

  final VoidCallback? onTap;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () {
        if (onTap != null) onTap!();
      },
      child: Container(
        width: 65,
        height: 65,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey, width: 2),
        ),
        child: Icon(icon, color: Colors.grey, size: 60),
      ),
    );
  }
}
