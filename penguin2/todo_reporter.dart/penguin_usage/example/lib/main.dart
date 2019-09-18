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
              print(await usage1.getStringMethod());
              print(await usage1.addTwo(14));
              print(await usage1.divide(100, 10));
              print(await usage1.getList(<int, int>{1: 2, 800: 4000}));
              print(await usage1.giveUsage2(Usage2()));

              final GenericUsage<String> genericUsage = GenericUsage<String>();
              genericUsage.setValue('Hello, World!');
              print(await genericUsage.get());
            },
            child: const Text('Click Me'),
          ),
        ),
      ),
    );
  }
}
