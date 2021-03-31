import 'dart:ffi';
import 'dart:io';

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
    MethodChannelMessenger.instance.registerHandler('channelName', MyHandler());
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
            // if (object == null) {
            //   print('setting object');
            //   object = Object();
            //   InstancePairManager.instance.addPair(
            //     object!,
            //     object.hashCode.toString(),
            //     owner: true,
            //   );
            //   print('InstanceId should be ${object.hashCode}');
            //   print(InstancePairManager.instance.getInstanceId(object!));
            //   print(object == InstancePairManager.instance.getObject(object.hashCode.toString()));
            //
            //   print(InstancePairManager.instance.getInstanceId(Object()));
            //   print(InstancePairManager.instance.getObject('woiefjwoijef'));
            // } else {
            //   print('unsetting object');
            //   object = null;
            // }
            if (object == null) {
              object = Object();
              MethodChannelMessenger.instance.sendCreateNewInstancePair(
                'channelName',
                object!,
                owner: true,
              );
              MethodChannelMessenger.instance.sendInvokeMethod(
                "channelName",
                object!,
                '',
                <Object?>[],
              );
            } else {
              object = null;
            }
          },
          child: const Icon(Icons.ac_unit),
        ),
      ),
    );
  }
}

class MyHandler with TypeChannelHandler {
  @override
  Object createInstance(
      TypeChannelMessenger messenger, List<Object?> arguments) {
    // TODO: implement createInstance
    throw UnimplementedError();
  }

  @override
  List<Object?> getCreationArguments(
      TypeChannelMessenger messenger, Object instance) {
    return <Object?>[];
  }

  @override
  Object? invokeMethod(TypeChannelMessenger messenger, Object instance,
      String methodName, List<Object?> arguments) {
    // TODO: implement invokeMethod
    throw UnimplementedError();
  }

  @override
  Object? invokeStaticMethod(TypeChannelMessenger messenger, String methodName,
      List<Object?> arguments) {
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
