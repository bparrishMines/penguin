import 'dart:ffi'; // For FFI
import 'dart:io'; // For Platform.isX

final DynamicLibrary nativeAddLib = Platform.isAndroid
    ? DynamicLibrary.open("libnative_add.so")
    : DynamicLibrary.process();

final int Function(int x, int y) nativeAdd = nativeAddLib
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>("native_add")
    .asFunction();

final void Function(Object object) passObjectToC =
    nativeAddLib.lookupFunction<Void Function(Handle), void Function(Object)>(
        "PassObjectToC");

void attachFinalizer(Object o) => passObjectToC(o);
