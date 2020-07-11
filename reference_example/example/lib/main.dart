import 'package:flutter/material.dart';

import 'package:reference_example/reference_example.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _methodResult = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text(_methodResult),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final MyClass myClass = MyClass('apple');
            _methodResult = await myClass.myMethod(23, MyOtherClass(44));
            setState(() {});
          },
          child: Icon(Icons.ac_unit),
        ),
      ),
    );
  }
}
