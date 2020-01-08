import 'package:flutter/material.dart';
import 'package:test_plugin/test_plugin.dart';

void main() => runApp(MyApp());

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
        body: Column(
          children: <Widget>[
            Text('A TextView is below'),
            Container(
              width: 200,
              height: 200,
              child: TextViewWidget(PlatformTextView.fromText('Apple')),
            ),
          ],
        ),
      ),
    );
  }
}
