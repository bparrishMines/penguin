import 'package:flutter/material.dart';

import 'package:reference_example/reference_example.dart';

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
        body: Center(
          child: Column(
            children: <Widget>[
              Text(_text),
              ElevatedButton(
                onPressed: () => debugPrint('HI!'),
                child: const Text('HI'),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final ClassTemplate classTemplate = ClassTemplate(23);
            final String result = await classTemplate.methodTemplate('Hello, ');
            setState(() {
              _text = result;
            });
          },
          child: const Icon(Icons.ac_unit),
        ),
      ),
    );
  }
}
