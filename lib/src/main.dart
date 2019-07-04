// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as path;

import 'penguin_option.dart';

void main(List<String> args) {
  final ArgParser parser = new ArgParser();

  for (PenguinOption option in PenguinOption.values) {
    if (option.isFlag) {
      parser.addFlag(
        option.name,
        abbr: option.abbr,
        help: option.help,
        negatable: option.negatable,
        callback: option.callback,
      );
    } else {
      parser.addOption(
        option.name,
        abbr: option.abbr,
        help: option.help,
        defaultsTo: option.defaultsTo,
        callback: option.callback,
        valueHelp: option.valueHelp,
      );
    }
  }

  ArgResults results;
  try {
    results = parser.parse(args);
  } on FormatException catch (exception) {
    print(exception.message);
    exit(64);
  }

  if (results[PenguinOption.usage.name]) {
    print(parser.usage);
    exit(0);
  } else if (results.rest.isNotEmpty) {
    print(parser.usage);
    exit(64);
  }

  final Directory directory = Directory(path.join(
    Directory.current.path,
    results[PenguinOption.directory.name],
  ));

  _runFlutterCreate(directory, results[PenguinOption.projectName.name]);
}

void _runFlutterCreate(Directory directory, String projectName) {
  final ProcessResult result = Process.runSync(
    'flutter',
    <String>[
      'create',
      '-t',
      'plugin',
      '--project-name',
      projectName,
      directory.path,
    ],
  );
  print(result.stdout);
  print(result.stderr);
}
