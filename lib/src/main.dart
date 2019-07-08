// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as path;

import 'android_library.dart';
import 'dart_library.dart';
import 'java_library.dart';
import 'penguin_option.dart';
import 'plugin_creator.dart';

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

  final Directory pluginDir = Directory(path.join(
    Directory.current.path,
    results[PenguinOption.directory.name],
  ));

  /*
  final int flutterCreateCode = _runFlutterCreate(
    directory: pluginDir,
    projectName: results[PenguinOption.projectName.name],
    org: results[PenguinOption.org.name],
  );

  if (flutterCreateCode != 0) exit(64);
  */

  JavaLibrary javaLibrary;
  if (results.wasParsed(PenguinOption.android.name)) {
    final List<Directory> javaDirectories = _getAllDirectories(
      results[PenguinOption.android.name],
    );

    final List<File> javaFiles = _getAllJavaFiles(
      directories: javaDirectories,
      recursive: results[PenguinOption.recursive.name],
    );

    javaLibrary = _createLibrary(javaFiles);
  }

  final PluginCreator creator = PluginCreator(
    pluginName: results[PenguinOption.projectName.name],
    javaLibrary: javaLibrary,
    organization: results[PenguinOption.org.name],
  );

  final Directory androidDir = AndroidLibrary.getAndroidDirectory(
    pluginDir: pluginDir,
    organization: results[PenguinOption.org.name],
    pluginName: results[PenguinOption.projectName.name],
  );
  _writeToFiles(androidDir, creator.getAndroidFiles());

  final Directory dartDir = DartLibrary.getDartDirectory(pluginDir);
  _writeToFiles(dartDir, creator.getDartFiles());
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

List<File> _getAllJavaFiles({List<Directory> directories, bool recursive}) {
  final List<File> files = <File>[];

  for (Directory dir in directories) {
    final List<FileSystemEntity> entities = dir.listSync(recursive: recursive);

    for (FileSystemEntity entity in entities) {
      if (entity is File) {
        final File file = entity;

        if (file.path.endsWith('.java')) {
          files.add(file);
        }
      }
    }
  }

  return files;
}

List<Directory> _getAllDirectories(List<String> paths) {
  final List<Directory> directories = <Directory>[];

  for (String dir in paths) {
    directories.add(
      Directory(path.join(Directory.current.path, dir)),
    );
  }

  return directories;
}

void _writeToFiles(Directory directory, Map<File, String> files) {
  for (MapEntry<File, String> entry in files.entries) {
    final File file = File(
      path.join(directory.path, entry.key.path),
    );

    file
      ..createSync(recursive: true)
      ..writeAsStringSync(entry.value);
  }
}
