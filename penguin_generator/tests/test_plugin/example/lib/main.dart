import 'package:flutter/material.dart';
import 'package:test_plugin/test_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TestProtocol _testProtocol = TestProtocol();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: TextView('Apple'),
      ),
    );
  }
}

class TestProtocol extends IosProtocol {
  @override
  void callbackMethod() {
    super.callbackMethod();
  }
}
