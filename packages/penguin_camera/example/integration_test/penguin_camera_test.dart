import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';
import 'package:penguin_camera/penguin_camera.dart';
import 'package:integration_test/integration_test.dart';
import 'package:permission_handler/permission_handler.dart';

// These tests are only ran manually since they require permissions and CI
// isn't setup to test on physical devices.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    while (!(await Permission.camera.request().isGranted)) {}
    while (!(await Permission.microphone.request().isGranted)) {}
  });

  testWidgets('setFocusMode', (WidgetTester tester) async {
    final CameraController controller = await setupCamera();

    final List<FocusMode> focusModes = await controller.supportedFocusModes();
    expect(focusModes, isNotEmpty);

    expect(controller.setFocusMode(focusModes[0]), completes);

    controller.stop();
    controller.dispose();
  });

  testWidgets('setExposureMode', (WidgetTester tester) async {
    final CameraController controller = await setupCamera();

    final List<ExposureMode> exposureModes =
        await controller.supportedExposureModes();
    expect(exposureModes, isNotEmpty);

    expect(controller.setExposureMode(exposureModes[0]), completes);

    controller.stop();
    controller.dispose();
  });

  testWidgets('setTorchMode', (WidgetTester tester) async {
    final CameraController controller = await setupCamera();

    final List<TorchMode> torchModes = await controller.supportedTorchModes();
    expect(torchModes, isNotEmpty);

    expect(controller.setTorchMode(TorchMode.on), completes);

    controller.stop();
    controller.dispose();
  });

  testWidgets('setZoom', (WidgetTester tester) async {
    final CameraController controller = await setupCamera();

    expect(controller.zoomSupported(), completion(true));
    expect(controller.setZoom(2.0), completes);

    controller.stop();
    controller.dispose();
  });

  testWidgets('setFlashMode', (WidgetTester tester) async {
    final ImageCaptureOutput imageOutput = ImageCaptureOutput();
    final CameraController controller = await setupCamera(
      <CameraOutput>[imageOutput],
    );

    final List<FlashMode> flashModes = await imageOutput.supportedFlashModes();
    expect(flashModes, isNotEmpty);

    expect(imageOutput.setFlashMode(flashModes[0]), completes);

    controller.stop();
    controller.dispose();
  });

  testWidgets('setControllerPreset', (WidgetTester tester) async {
    final CameraController controller = await setupCamera();

    expect(
      controller.setControllerPreset(CameraControllerPreset.high),
      completes,
    );

    controller.stop();
    controller.dispose();
  });

  testWidgets(
    'capture video',
    (WidgetTester tester) async {
      final VideoCaptureOutput videoOutput = VideoCaptureOutput(
        includeAudio: true,
      );

      final CameraController controller = await setupCamera(
        <CameraOutput>[videoOutput],
      );
      controller.start();

      final Directory dir = await getStorageDir();
      expect(
        videoOutput.startRecording(
          fileOutput: '${dir.path}/my_video${Random().nextInt(10000)}.mp4',
        ),
        completes,
      );
      await Future.delayed(const Duration(seconds: 2));
      expect(videoOutput.stopRecording(), completes);

      controller.stop();
      controller.dispose();
    },
    timeout: const Timeout(Duration(seconds: 10)),
  );

  testWidgets(
    'capture image',
    (WidgetTester tester) async {
      final ImageCaptureOutput imageOutput = ImageCaptureOutput();

      final CameraController controller = await setupCamera(
        <CameraOutput>[imageOutput],
      );
      controller.start();

      final Completer<Uint8List> bytesCompleter = Completer<Uint8List>();
      imageOutput.takePicture((Uint8List bytes) {
        bytesCompleter.complete(bytes);
      });

      final Uint8List bytes = await bytesCompleter.future;
      expect(bytes, isNotEmpty);

      controller.stop();
      controller.dispose();
    },
    timeout: const Timeout(Duration(seconds: 10)),
  );
}

Future<CameraController> setupCamera([List<CameraOutput>? outputs]) async {
  final List<CameraDevice> devices =
      await CameraController.getAllCameraDevices();
  final CameraDevice device = devices.firstWhere(
    (CameraDevice device) => device.position == CameraPosition.back,
  );

  final CameraController controller = CameraController(
    device: device,
    outputs: <CameraOutput>[PreviewOutput(), if (outputs != null) ...outputs],
  );
  await controller.initialize();

  return controller;
}

Future<Directory> getStorageDir() async {
  late final Directory? directory;
  if (defaultTargetPlatform == TargetPlatform.android) {
    final List<Directory>? directories = await getExternalStorageDirectories(
      type: StorageDirectory.dcim,
    );
    directory = directories?.first;
  } else {
    directory = await getApplicationDocumentsDirectory();
  }

  if (directory == null) throw StateError('Could not get storage directory.');
  return directory;
}
