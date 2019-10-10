// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_plugin/test_plugin.dart';

void main() {
  final Completer<String> completer = Completer<String>();
  enableFlutterDriverExtension(handler: (_) => completer.future);
  tearDownAll(() => completer.complete(null));

  group('test_plugin', () {
    group('android', () {
      test('noParametersMethod', () {
        expect(AndroidTestClass1().noParametersMethod(), completion(72));
      });

      test('singleParameterMethod', () {
        expect(AndroidTestClass1().singleParameterMethod('Hello'),
            completion('Hello, World!'));
      });
    }, skip: !Platform.isAndroid);
  });
}
