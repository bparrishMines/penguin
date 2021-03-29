import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:reference/reference.dart';

// ignore: implementation_imports
import 'package:reference/src/template/template.dart';
import 'package:reference/native_add.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _text = 'nada';
  Object? object;

  @override
  void initState() {
    super.initState();
    //reference_dart_dl_initialize(NativeApi.initializeApiDLData);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(children: <Widget>[
          Text(_text),
          ElevatedButton(
            onPressed: () => print(object),
            child: const Text('HI'),
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (object == null) {
              object = Object();
              print(MethodChannelMessenger.instance.isPaired(object!));
              MethodChannelMessenger.instance.registerHandler(
                  'channelName', MyHandler());
              MethodChannelMessenger.instance.sendCreateNewInstancePair(
                'channelName',
                object!,
              );
              print(MethodChannelMessenger.instance.isPaired(object!));
            } else {
              object = null;
            }
            // print(nativeAdd(3, 5));
            // if (object == null) {
            //   final Object object1 = Object();
            //   attachFinalizer(object1);
            //   object = object1;
            // } else {
            //   object = null;
            // }
            // trySend('my_channel', Object());
            //print(object);
            // final ClassTemplate classTemplate = ClassTemplate(44);
            // final String result = await classTemplate.methodTemplate('Hello,');
            // setState(() {
            //   _text = result;
            // });
          },
          child: const Icon(Icons.ac_unit),
        ),
      ),
    );
  }
}

class MyHandler with TypeChannelHandler {
  @override
  Object createInstance(TypeChannelMessenger messenger, List<Object?> arguments) {
    // TODO: implement createInstance
    throw UnimplementedError();
  }

  @override
  List<Object?> getCreationArguments(TypeChannelMessenger messenger, Object instance) {
    // TODO: implement getCreationArguments
    throw UnimplementedError();
  }

  @override
  Object? invokeMethod(TypeChannelMessenger messenger, Object instance, String methodName, List<Object?> arguments) {
    // TODO: implement invokeMethod
    throw UnimplementedError();
  }

  @override
  Object? invokeStaticMethod(TypeChannelMessenger messenger, String methodName, List<Object?> arguments) {
    // TODO: implement invokeStaticMethod
    throw UnimplementedError();
  }

}

// class MyObject {
//   Pointer<Void> finalizer;
//
//   MyObject() {
//     attachFinalizer()
//   }
// }
