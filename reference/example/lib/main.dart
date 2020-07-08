import 'package:flutter/material.dart';

// ignore: implementation_imports
import 'package:reference/src/template/template.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(child: Text('Hello, World!')),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final ClassTemplate classTemplate = ClassTemplate(44);
            final String result = await classTemplate.methodTemplate('Hello,');
            print(result);
          },
          child: Icon(Icons.ac_unit),
        ),
      ),
    );
  }
}
