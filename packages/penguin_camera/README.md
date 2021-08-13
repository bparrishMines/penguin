# penguin_camera

A cross-platform framework for accessing various cameras and camera features available on devices,
allowing you to capture pictures and videos in your applications.

On top of providing an interface that is cross platform, this also provides easy access to platform
specific features.

## Supported Platform

Android, iOS

## Permissions

Android and iOS require permissions to access camera and audio devices, but this package doesn't
provide an API to request them. Consider using [permission_handler](https://pub.dev/packages/permission_handler)
to request permissions. See the `example` for an example.

## Use Cases

### Getting Camera Device Information

```dart
final List<CameraDevice> devices = await CameraController.getAllCameraDevices();
for (CameraDevice device in devices) {
  print('CameraDevice: ${device.name}, ${device.position}');
}
```

### Displaying a Preview

```dart
final List<CameraDevice> devices = await CameraController.getAllCameraDevices();
final CameraDevice device = devices.firstWhere(
  (CameraDevice device) => device.position == CameraPosition.back,
);

final PreviewOutput previewOutput = PreviewOutput();
final CameraController controller = CameraController(
  device: device,
  outputs: <CameraOutput>[previewOutput],
);

// This must finish before anything else is called.
await controller.initialize();

final Widget previewWidget = await previewOutput.previewWidget();

controller.start();
```

### Taking a picture

```dart
final List<CameraDevice> devices =
    await CameraController.getAllCameraDevices();
final CameraDevice device = devices.firstWhere(
  (CameraDevice device) => device.position == CameraPosition.back,
);

final ImageCaptureOutput imageOutput = ImageCaptureOutput();
// Android requires a PreviewOutput, so it is added despite it not being used.
final CameraController controller = CameraController(
  device: device,
  outputs: <CameraOutput>[PreviewOutput(), imageOutput],
);
// This must finish before anything else is called.  
await controller.initialize();
controller.start();

imageOutput.takePicture((Uint8List data) {
  print(data.length);
});

controller.stop();
controller.dispose();
```

### Recording a Video

```dart
final List<CameraDevice> devices =
    await CameraController.getAllCameraDevices();
final CameraDevice device = devices.firstWhere(
      (CameraDevice device) => device.position == CameraPosition.back,
);

final VideoCaptureOutput videoOutput = VideoCaptureOutput();
// Android requires a PreviewOutput, so it is added despite it not being used.
final CameraController controller = CameraController(
  device: device,
  outputs: <CameraOutput>[PreviewOutput(), videoOutput],
);
// This must finish before anything else is called.
await controller.initialize();
controller.start();

videoOutput.startRecording(fileOutput: 'myFile');
videoOutput.stopRecording();

controller.stop();
controller.dispose();
```

### Setting Exposure

```dart
final CameraController controller = ....
final List<ExposureMode> modes = await controller.supportedExposureModes();
if (modes.contains(ExposureMode.continuous)) {
  controller.setExposureMode(ExposureMode.locked);
}
```

### Setting Focus

```dart
final CameraController controller = ....
final List<FocusMode> modes = await controller.supportedFocusModes();
if (modes.contains(FocusMode.continuousImageAutoFocus)) {
  controller.setFocusMode(FocusMode.continuousImageAutoFocus);
}
```

### Setting Zoom

```dart
final CameraController controller = ....
if (await controller.zoomSupported()) {
  final double minZoom = await controller.minZoom();
  final double maxZoom = await controller.maxZoom();
  controller.setZoom((maxZoom + minZoom) / 2);
}
```

### Setting Flash

```dart
final List<CameraDevice> devices = await CameraController.getAllCameraDevices();
final CameraDevice device = devices.firstWhere(
  (CameraDevice device) => device.position == CameraPosition.back,
);

final ImageCaptureOutput imageOutput = ImageCaptureOutput();
// Android requires a PreviewOutput, so it is added despite it not being used.
final CameraController controller = CameraController(
  device: device,
  outputs: <CameraOutput>[PreviewOutput(), imageOutput],
);
// This must finish before anything else is called.
await controller.initialize();

final List<FlashMode> modes = await imageOutput.supportedFlashModes();
if (modes.contains(FlashMode.auto)) {
  imageOutput.setFlashMode(FlashMode.auto);
}
```

### Android Specific Feature

### iOS Specific Feature