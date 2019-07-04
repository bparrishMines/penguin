// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:args/args.dart';

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
        callback: option.callback,
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

  //final ProcessResult result = Process.runSync('pwd', <String>[]);

  //final Directory directory = Directory('./');
}

class PenguinOption implements Option {
  const PenguinOption._({
    this.abbr,
    this.allowed,
    this.allowedHelp,
    this.callback,
    this.defaultsTo,
    this.help,
    this.hide,
    this.isFlag,
    this.isMultiple,
    this.isSingle,
    this.name,
    this.negatable,
    this.splitCommas,
    this.type,
    this.valueHelp,
  })  : assert(name != null),
        assert(isFlag != null);

  static PenguinOption usage = PenguinOption._(
    name: 'help',
    abbr: 'h',
    help: 'Print usage.',
    negatable: false,
    isFlag: true,
  );

  static PenguinOption projectName = PenguinOption._(
    name: 'project-name',
    abbr: 'n',
    valueHelp: 'name',
    help:
        'The project name for this new Flutter project. This must be a valid dart package name.',
    defaultsTo: 'new_plugin',
    isFlag: false,
  );

  static PenguinOption directory = PenguinOption._(
    name: 'directory',
    abbr: 'd',
    help: 'Output path for plugin.',
    defaultsTo: './',
    valueHelp: 'path',
    isFlag: false,
  );

  static List<PenguinOption> values = <PenguinOption>[
    usage,
    projectName,
    directory,
  ];

  @override
  final String abbr;

  @override
  @deprecated
  final String abbreviation = null;

  @override
  final List<String> allowed;

  @override
  final Map<String, String> allowedHelp;

  @override
  final Function callback;

  @override
  @deprecated
  final dynamic defaultValue = null;

  @override
  final dynamic defaultsTo;

  @override
  void getOrDefault(dynamic value) => value ?? defaultsTo;

  @override
  final String help;

  @override
  final bool hide;

  @override
  final bool isFlag;

  @override
  final bool isMultiple;

  @override
  final bool isSingle;

  @override
  final String name;

  @override
  final bool negatable;

  @override
  final bool splitCommas;

  @override
  final OptionType type;

  @override
  final String valueHelp;
}
