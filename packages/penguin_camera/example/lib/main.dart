// ignore_for_file: public_member_api_docs

import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:penguin_camera/penguin_camera.dart';
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

  late CameraController _cameraController;
  PreviewOutput _previewOutput = PreviewOutput();
  late ImageCaptureOutput _imageCaptureOutput;
  late VideoCaptureOutput _videoCaptureOutput;
  Size? _previewOutputSize;

  CameraPosition _cameraPosition = CameraPosition.front;

  final double _deviceRotation = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom],
    );
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);
    _setupForPicture();
  }

  Future<void> _getPicturePermission() async {
    while (!(await Permission.camera.request().isGranted)) {}
    while (!(await Permission.storage.request().isGranted)) {}

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      while (!(await Permission.photosAddOnly.request().isGranted)) {}
    }
  }

  Future<void> _getAudioPermission() async {
    while (!(await Permission.microphone.request().isGranted)) {}
  }

  Future<void> _setupForPicture() async {
    await _getPicturePermission();

    _imageCaptureOutput = ImageCaptureOutput();
    _cameraController = await _setupCameraController(_imageCaptureOutput);

    final List<FocusMode> supportedFocusMode =
        await _cameraController.supportedFocusModes();
    if (supportedFocusMode.contains(FocusMode.continuousImageAutoFocus)) {
      _cameraController.setFocusMode(FocusMode.continuousImageAutoFocus);
    }

    _cameraController.start();
    setState(() {
      currentMode = CameraMode.picture;
    });
  }

  Future<void> _setupForVideo() async {
    await _getPicturePermission();
    await _getAudioPermission();

    _videoCaptureOutput = VideoCaptureOutput(includeAudio: true);
    _cameraController = await _setupCameraController(_videoCaptureOutput);
    final List<FocusMode> supportedFocusMode =
        await _cameraController.supportedFocusModes();
    if (supportedFocusMode.contains(FocusMode.continuousVideoAutoFocus)) {
      _cameraController.setFocusMode(FocusMode.continuousVideoAutoFocus);
    }
    _cameraController.start();
    setState(() {
      currentMode = CameraMode.video;
    });
  }

  Future<CameraController> _setupCameraController(CameraOutput output) async {
    final List<CameraDevice> allCameraDevices =
        await CameraController.getAllCameraDevices();

    final CameraDevice device = allCameraDevices.firstWhere(
      (CameraDevice device) => device.position == _cameraPosition,
    );

    _previewOutput = PreviewOutput();
    final CameraController cameraController = CameraController(
      device: device,
      outputs: <CameraOutput>[_previewOutput, output],
    );

    await cameraController.initialize();

    await cameraController.setControllerPreset(CameraControllerPreset.high);
    _previewOutput.setRotation(OutputRotation.rotation0);
    output.setRotation(OutputRotation.rotation0);
    _previewOutputSize = await _previewOutput.outputSize();
    return cameraController;
  }

  @override
  void dispose() {
    super.dispose();
    if (currentMode != CameraMode.none) _cameraController.dispose();
  }

  Future<void> _toggleCameraMode() {
    switch (currentMode) {
      case CameraMode.prePicture:
      case CameraMode.preVideo:
      case CameraMode.none:
        return Future<void>.value();
      case CameraMode.picture:
        setState(() => currentMode = CameraMode.preVideo);
        _cameraController.dispose();
        return _setupForVideo();
      case CameraMode.video:
        setState(() => currentMode = CameraMode.prePicture);
        _cameraController.dispose();
        return _setupForPicture();
      case CameraMode.videoRecording:
        const SnackBar snackBar = SnackBar(
          content: Text('Please end video recording first.'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return Future<void>.value();
    }
  }

  Future<void> _toggleCameraPosition(BuildContext context) {
    void switchCameraPosition() {
      if (_cameraPosition == CameraPosition.front) {
        _cameraPosition = CameraPosition.back;
      } else {
        _cameraPosition = CameraPosition.front;
      }
    }

    switch (currentMode) {
      case CameraMode.prePicture:
      case CameraMode.preVideo:
      case CameraMode.none:
        return Future<void>.value();
      case CameraMode.picture:
        setState(() => currentMode = CameraMode.prePicture);
        _cameraController.dispose();
        switchCameraPosition();
        return _setupForPicture();
      case CameraMode.video:
        setState(() => currentMode = CameraMode.preVideo);
        _cameraController.dispose();
        switchCameraPosition();
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
    final Directory? directory;
    if (defaultTargetPlatform == TargetPlatform.android) {
      final List<Directory>? directories = await getExternalStorageDirectories(
        type: StorageDirectory.dcim,
      );
      directory = directories?.first;
    } else {
      directory = await getApplicationDocumentsDirectory();
    }
    if (directory == null) {
      throw StateError('Could not get storage directory.');
    }
    return directory;
  }

  void _takeImage(BuildContext context) {
    _imageCaptureOutput.takePicture((Uint8List bytes) async {
      debugPrint('Image taken with jpeg data length: ${bytes.length}');
      final Directory dir = await _getStorageDir();
      final File imageFile = File('${dir.path}/my_image${bytes.hashCode}.jpg');
      imageFile.writeAsBytes(bytes);

      final String message = 'Pictured stored at: $imageFile';
      debugPrint(message);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    });
  }

  Future<void> _startRecording() async {
    final Directory dir = await _getStorageDir();
    _videoCaptureOutput.startRecording(
      fileOutput: '${dir.path}/my_video${Random().nextInt(10000)}.mp4',
    );

    setState(() {
      currentMode = CameraMode.videoRecording;
    });
  }

  void _stopRecording() {
    _videoCaptureOutput.stopRecording();
    setState(() {
      currentMode = CameraMode.video;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: const BoxDecoration(color: Colors.black),
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      CameraPreview(
                        previewOutput: _previewOutput,
                        cameraMode: currentMode,
                        size: _previewOutputSize,
                      ),
                      if (currentMode == CameraMode.picture ||
                          currentMode == CameraMode.video ||
                          currentMode == CameraMode.videoRecording)
                        Positioned(
                          bottom: 0,
                          child: ZoomWidget(_cameraController),
                        )
                    ],
                  ),
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
                        onPressed: () => _toggleCameraPosition(context),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: CameraButton(
                      cameraMode: currentMode,
                      onTakePicture: () => _takeImage(context),
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
      ),
    );
  }
}

class ZoomWidget extends StatefulWidget {
  const ZoomWidget(this.controller, {Key? key}) : super(key: key);

  final CameraController controller;

  @override
  State<StatefulWidget> createState() {
    return ZoomWidgetState();
  }
}

class ZoomWidgetState extends State<ZoomWidget> {
  static const _maxAllowedZoom = 5;

  late int _minZoom;
  late int _maxZoom;
  late int _currentZoom;
  bool _supportsZoom = false;
  bool _supportsSmoothZoom = false;

  @override
  void initState() {
    super.initState();
    getZoomInfo();
  }

  Future<void> getZoomInfo() async {
    final CameraController controller = widget.controller;

    final bool supportsZoom = await controller.zoomSupported();
    if (!supportsZoom) return;

    final bool supportsSmoothZoom = await controller.smoothZoomSupported();
    final int minZoom = (await controller.minZoom()).ceil();
    final int maxZoom = min(
      (await controller.maxZoom()).floor(),
      _maxAllowedZoom,
    );

    setState(() {
      _supportsZoom = supportsZoom;
      _supportsSmoothZoom = supportsSmoothZoom;
      _currentZoom = 0;
      _minZoom = minZoom;
      _maxZoom = maxZoom;
    });
  }

  Future<void> zoom(int value) {
    if (_supportsSmoothZoom) {
      return widget.controller.smoothZoomTo((value + _minZoom).toDouble());
    }
    return widget.controller.setZoom((value + _minZoom).toDouble());
  }

  @override
  Widget build(BuildContext context) {
    if (!_supportsZoom) return Container();

    final int length = _maxZoom - _minZoom + 1;
    return ToggleButtons(
      color: Colors.blue,
      fillColor: Colors.grey,
      selectedColor: Colors.blue,
      onPressed: (int index) {
        setState(() => _currentZoom = index);
        zoom(index);
      },
      isSelected: List<int>.generate(length, (index) => index)
          .map<bool>((int value) => value == _currentZoom)
          .toList(),
      children: List<int>.generate(length, (index) => index)
          .map<Widget>((int value) => Text('${value + 1}x'))
          .toList(),
    );
  }
}

class CameraPreview extends StatelessWidget {
  const CameraPreview({
    Key? key,
    required this.previewOutput,
    required this.cameraMode,
    this.size,
  }) : super(key: key);

  final PreviewOutput previewOutput;

  final CameraMode cameraMode;

  final Size? size;

  @override
  Widget build(BuildContext context) {
    switch (cameraMode) {
      case CameraMode.picture:
      case CameraMode.video:
      case CameraMode.videoRecording:
        return FutureBuilder<Widget>(
          future: previewOutput.previewWidget(),
          builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
            if (snapshot.hasData) {
              if (size != null) {
                return AspectRatio(
                  aspectRatio: size!.height / size!.width,
                  child: snapshot.data!,
                );
              }
              return snapshot.data!;
            }

            return Container();
          },
        );
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
