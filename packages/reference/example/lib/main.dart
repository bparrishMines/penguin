import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(child: Text(_text)),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            print(nativeAdd(3, 5));
            final Object object = Object();
            attachFinalizer(object);
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
