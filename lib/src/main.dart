// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:args/args.dart';

void main(List<String> args) {
  final ArgParser parser = new ArgParser();
  parser
    ..addFlag(
      'help',
      abbr: 'h',
      help: 'Print usage.',
      negatable: false,
      callback: (bool help) {
        if (help) print(parser.usage);
      },
    )
    ..addOption(
      'project-name',
      abbr: 'n',
      valueHelp: 'name',
      help:
          'The project name for this new Flutter project. This must be a valid dart package name.',
      defaultsTo: 'new_plugin',
    )
    ..addOption(
      'directory',
      abbr: 'd',
      help: 'Output path for plugin.',
      defaultsTo: './',
      valueHelp: 'path',
    );

  try {
    final ArgResults results = parser.parse(args);
  } on FormatException catch (exception) {
    print(exception.message);
  }
}
