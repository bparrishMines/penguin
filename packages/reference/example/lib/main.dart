import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:reference/reference.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final InstancePairManager instancePairManager =
      InstancePairManager((message) => print(message));

  @override
  void initState() {
    super.initState();
    //InstancePairManager.instance;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              debugPrint('HI!');
              final Object object = Object();
              instancePairManager.addPair(object, 'yolo', owner: true);
              // final Point point = createPoint(12, 32);
              // print(point.x);
              // print(point.y);
              // print(add(point));
            },
            child: const Text('HI'),
          ),
        ),
      ),
    );
  }
}

// class Point extends Struct {
//   @Int32()
//   external int x;
//
//   @Int32()
//   external int y;
//
//   external Pointer<Void> c;
// }
//
// final int Function(Point) add = InstancePairManager.referenceLib
//     .lookupFunction<Int32 Function(Point), int Function(Point)>('add');
//
// final Point Function(int, int) createPoint = InstancePairManager.referenceLib
//     .lookupFunction<Point Function(Int32, Int32), Point Function(int, int)>(
//         'create_point');
