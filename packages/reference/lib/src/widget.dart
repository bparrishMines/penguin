import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'instance_manager.dart';
import 'method_channel.dart';

// TODO: Widget tests for Android and IOS

/// Embeds an Android view from an [InstanceManager] in the Widget hierarchy.
///
/// Requires Android API level 19 or greater.
///
/// This widget uses
/// [Hybrid Composition](https://github.com/flutter/flutter/wiki/Hybrid-Composition)
/// with a [PlatformViewLink] and a [AndroidViewSurface].
///
/// The associated [instanceId] should be retrieved from an [InstanceManager].
class AndroidReferenceWidget extends StatelessWidget {
  /// Construct a [AndroidReferenceWidget] widget.
  AndroidReferenceWidget({
    Key? key,
    required this.instance,
    InstanceManager? instanceManager,
    this.viewType = 'github.penguin.reference/AndroidReferenceWidget',
    this.hitTestBehavior = PlatformViewHitTestBehavior.opaque,
    this.gestureRecognizers = const <Factory<OneSequenceGestureRecognizer>>{},
    this.layoutDirection = TextDirection.rtl,
    this.platformViewCreatedListener,
    this.onFocus,
  })  : _instanceManager =
            instanceManager ?? MethodChannelMessenger.instance.instanceManager,
        assert(defaultTargetPlatform == TargetPlatform.android),
        super(key: key);

  final InstanceManager _instanceManager;

  /// The object that will be stored in [instanceManager].
  ///
  /// The Android object paired with this instance MUST implement the Android
  /// `PlatformView` class.
  final Object instance;

  /// The unique identifier for the view type to be embedded.
  ///
  /// Typically, this viewType has already been registered on the platform side.
  /// The default value is used with `ReferenceViewFactory.java`.
  final String viewType;

  /// Which gestures should be forwarded to the PlatformView.
  ///
  /// {@macro flutter.widgets.AndroidView.gestureRecognizers.descHead}
  ///
  /// For example, with the following setup vertical drags will not be dispatched to the platform view
  /// as the vertical drag gesture is claimed by the parent [GestureDetector].
  ///
  /// ```dart
  /// GestureDetector(
  ///   onVerticalDragStart: (DragStartDetails details) {},
  ///   child: PlatformViewSurface(
  ///   ),
  /// )
  /// ```
  ///
  /// To get the [PlatformViewSurface] to claim the vertical drag gestures we can pass a vertical drag
  /// gesture recognizer factory in [gestureRecognizers] e.g:
  ///
  /// ```dart
  /// GestureDetector(
  ///   onVerticalDragStart: (DragStartDetails details) {},
  ///   child: SizedBox(
  ///     width: 200.0,
  ///     height: 100.0,
  ///     child: PlatformViewSurface(
  ///       gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
  ///         new Factory<OneSequenceGestureRecognizer>(
  ///           () => new EagerGestureRecognizer(),
  ///         ),
  ///       ].toSet(),
  ///     ),
  ///   ),
  /// )
  /// ```
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;

  /// {@macro flutter.widgets.AndroidView.hitTestBehavior}
  final PlatformViewHitTestBehavior hitTestBehavior;

  /// Callback signature for when a platform view was created.
  ///
  /// `id` is the platform view's unique identifier.
  final PlatformViewCreatedCallback? platformViewCreatedListener;

  /// Direction the text flows.
  ///
  /// An Android View doesn't use this feature, but this is useful for Flutter.
  final TextDirection layoutDirection;

  /// A callback that will be invoked when the Android View asks to get the input focus.
  final VoidCallback? onFocus;

  @override
  Widget build(BuildContext context) {
    assert(_instanceManager.containsInstance(instance));
    return PlatformViewLink(
      viewType: viewType,
      surfaceFactory: (
        BuildContext context,
        PlatformViewController controller,
      ) {
        return AndroidViewSurface(
          controller: controller as AndroidViewController,
          gestureRecognizers: gestureRecognizers,
          hitTestBehavior: PlatformViewHitTestBehavior.opaque,
        );
      },
      onCreatePlatformView: (PlatformViewCreationParams params) {
        final SurfaceAndroidViewController controller =
            PlatformViewsService.initSurfaceAndroidView(
          id: params.id,
          viewType: viewType,
          layoutDirection: layoutDirection,
          creationParams: _instanceManager.getInstanceId(instance),
          creationParamsCodec: const StandardMessageCodec(),
          onFocus: onFocus,
        );

        controller.addOnPlatformViewCreatedListener(
          params.onPlatformViewCreated,
        );
        if (platformViewCreatedListener != null) {
          controller.addOnPlatformViewCreatedListener(
            platformViewCreatedListener!,
          );
        }

        controller.create();
        return controller;
      },
    );
  }
}

/// Embeds a UIKit view from an [InstanceManager] in the Widget hierarchy.
///
/// This widget uses [UiKit] underneath and passes all parameters to it.
///
/// The associated [instanceId] should be retrieved from an [InstanceManager].
class UiKitReferenceWidget extends StatelessWidget {
  /// Construct a [UiKitReferenceWidget] widget.
  UiKitReferenceWidget({
    Key? key,
    required this.instance,
    InstanceManager? instanceManager,
    this.viewType = 'github.penguin.reference/UiKitReferenceWidget',
    this.hitTestBehavior = PlatformViewHitTestBehavior.opaque,
    this.gestureRecognizers = const <Factory<OneSequenceGestureRecognizer>>{},
    this.layoutDirection = TextDirection.rtl,
    this.platformViewCreatedListener,
  })  : _instanceManager =
            instanceManager ?? MethodChannelMessenger.instance.instanceManager,
        assert(defaultTargetPlatform == TargetPlatform.iOS),
        super(key: key);

  final InstanceManager _instanceManager;

  /// The object that will be stored in [instanceManager].
  ///
  /// The iOS object paired with this instance MUST implement the iOS
  /// `FlutterPlatformView` class.
  final Object instance;

  /// The unique identifier for the view type to be embedded.
  ///
  /// Typically, this viewType has already been registered on the platform side.
  /// The default value is used with `REFReferenceViewFactory`.
  final String viewType;

  /// {@macro flutter.widgets.AndroidView.hitTestBehavior}
  final PlatformViewHitTestBehavior hitTestBehavior;

  /// Which gestures should be forwarded to the PlatformView.
  ///
  /// {@macro flutter.widgets.AndroidView.gestureRecognizers.descHead}
  ///
  /// For example, with the following setup vertical drags will not be dispatched to the platform view
  /// as the vertical drag gesture is claimed by the parent [GestureDetector].
  ///
  /// ```dart
  /// GestureDetector(
  ///   onVerticalDragStart: (DragStartDetails details) {},
  ///   child: PlatformViewSurface(
  ///   ),
  /// )
  /// ```
  ///
  /// To get the [PlatformViewSurface] to claim the vertical drag gestures we can pass a vertical drag
  /// gesture recognizer factory in [gestureRecognizers] e.g:
  ///
  /// ```dart
  /// GestureDetector(
  ///   onVerticalDragStart: (DragStartDetails details) {},
  ///   child: SizedBox(
  ///     width: 200.0,
  ///     height: 100.0,
  ///     child: PlatformViewSurface(
  ///       gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
  ///         new Factory<OneSequenceGestureRecognizer>(
  ///           () => new EagerGestureRecognizer(),
  ///         ),
  ///       ].toSet(),
  ///     ),
  ///   ),
  /// )
  /// ```
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;

  /// Callback signature for when a platform view was created.
  ///
  /// `id` is the platform view's unique identifier.
  final PlatformViewCreatedCallback? platformViewCreatedListener;

  /// Direction the text flows.
  ///
  /// An Android View doesn't use this feature, but this is useful for Flutter.
  final TextDirection layoutDirection;

  @override
  Widget build(BuildContext context) {
    assert(_instanceManager.containsInstance(instance));
    return UiKitView(
      viewType: viewType,
      hitTestBehavior: hitTestBehavior,
      gestureRecognizers: gestureRecognizers,
      onPlatformViewCreated: platformViewCreatedListener,
      creationParams: _instanceManager.getInstanceId(instance),
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}
