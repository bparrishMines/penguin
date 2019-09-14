import 'package:flutter/material.dart';
import 'package:penguin_usage/usage.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
          child: RaisedButton(
            onPressed: () async {
              final Usage1 usage1 = Usage1();
              print(usage1.$uniqueId);
              await usage1.aMethod();
              await usage1.anotherMethod();
            },
            child: const Text('Click Me'),
          ),
        ),
      ),
    );
  }
}
