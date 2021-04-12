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
  // final InstancePairManager instancePairManager =
  //     InstancePairManager((message) => print(message));
  InstancePairManager? manager;

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
            },
            child: const Text('HI'),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // final Object object = Object();
            // print(instancePairManager.addPair(object, 'yolo', owner: true));
            //final Object object = Object();
            manager = InstancePairManager((message) => print(message));
            manager?.addPair(Object(), 'fhwoiefj', owner: true);

            print('new manager');
            manager = InstancePairManager((_) => print(_));
          },
          child: const Icon(Icons.ac_unit),
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
