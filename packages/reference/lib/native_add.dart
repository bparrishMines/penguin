import 'dart:ffi'; // For FFI
import 'dart:io'; // For Platform.isX

import 'package:ffi/ffi.dart';

final DynamicLibrary nativeAddLib = Platform.isAndroid
    ? DynamicLibrary.open("libnative_add.so")
    : DynamicLibrary.process();

final int Function(int x, int y) nativeAdd = nativeAddLib
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>("native_add")
    .asFunction();

typedef reference_finalizer = Void Function(Pointer<Void>);

final void Function(Object object) passObjectToC =
    nativeAddLib.lookupFunction<Void Function(Handle), void Function(Object)>(
        "PassObjectToC");

final void Function(Pointer<Void> data) reference_dart_dl_initialize =
    nativeAddLib.lookupFunction<Void Function(Pointer<Void> data),
        void Function(Pointer<Void> data)>("reference_dart_dl_initialize");

void attachFinalizer(Object o) {
  passObjectToC(o);
}

final void Function(Pointer<Int8>, Object object) sendCreateNewInstancePair =
    nativeAddLib.lookupFunction<Void Function(Pointer<Int8>, Handle),
        void Function(Pointer<Int8>, Object)>("dart_send_create_new_instance_pair");

void trySend(String channel, Object object) {
  sendCreateNewInstancePair(channel.toNativeUtf8().cast<Int8>(), object);
}
