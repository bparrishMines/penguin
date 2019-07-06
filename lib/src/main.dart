// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as path;

import 'java.dart';
import 'penguin_option.dart';

void main(List<String> args) async {
  final ArgParser parser = new ArgParser(usageLineLength: 140);

  for (PenguinOption option in PenguinOption.values) {
    if (option.isFlag) {
      parser.addFlag(
        option.name,
        abbr: option.abbr,
        help: option.help,
        negatable: option.negatable,
        callback: option.callback,
      );
    } else if (option.isMultiple != null && option.isMultiple) {
      parser.addMultiOption(
        option.name,
        abbr: option.abbr,
        help: option.help,
        defaultsTo: option.defaultsTo,
        callback: option.callback,
        valueHelp: option.valueHelp,
        splitCommas: option.splitCommas,
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

  /*
  final int flutterCreateCode = _runFlutterCreate(
    directory: directory,
    projectName: results[PenguinOption.projectName.name],
    org: results[PenguinOption.org.name],
  );

  if (flutterCreateCode != 0) exit(64);
  */
  final List<Directory> androidDirectories = <Directory>[];
  if (results.wasParsed(PenguinOption.android.name)) {
    for (String dir in results[PenguinOption.android.name]) {
      androidDirectories.add(
        Directory(path.join(Directory.current.path, dir)),
      );
    }
  }

  final List<File> androidFiles = <File>[];
  if (androidDirectories.isNotEmpty) {
    for (Directory dir in androidDirectories) {
      final bool recursive = results[PenguinOption.recursive.name];
      final List<FileSystemEntity> entities = dir.listSync(
        recursive: recursive,
      );

      for (FileSystemEntity entity in entities) {
        if (entity is File) {
          final File file = entity;

          if (file.path.endsWith('.java')) {
            androidFiles.add(file);
          }
        }
      }
    }
  }

  final JavaLibrary library = _createLibrary(androidFiles);

  final String org = results[PenguinOption.org.name];

  final Directory pluginAndroidDir = Directory(path.join(
    directory.path,
    'android/src/main/java',
    org.replaceAll('.', '/'),
    results[PenguinOption.projectName.name],
  ));

  if (!pluginAndroidDir.existsSync()) {
    print('Directory for android code does not exit.');
    exit(64);
  }

  final Directory pluginLibDir = Directory(path.join(directory.path, 'lib'));

  if (!pluginLibDir.existsSync()) {
    print('Directory for dart code does not exit.');
    exit(64);
  }


}

int _runFlutterCreate({Directory directory, String projectName, String org}) {
  assert(directory != null);
  assert(projectName != null);
  assert(org != null);

  final ProcessResult result = Process.runSync(
    'flutter',
    <String>[
      'create',
      '-t',
      'plugin',
      '--project-name',
      projectName,
      '--org',
      org,
      directory.path,
    ],
  );

  print(result.stdout);
  print(result.stderr);
  return exitCode;
}

JavaLibrary _createLibrary(List<File> files) {
  final List<JavaClass> classes = <JavaClass>[];

  for (File file in files) {
    for (String line in file.readAsLinesSync()) {
      final RegExp exp = RegExp(r'class\s(\w+)');

      final RegExpMatch match = exp.firstMatch(line);
      if (match != null) {
        final JavaClass javaClass = JavaClass(match.group(1));
        classes.add(javaClass);
      }
    }
  }

  final JavaLibrary library = JavaLibrary()..classes = classes;
  return library;
}
