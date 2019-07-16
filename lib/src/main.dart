// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as path;

import 'penguin_option.dart';
import 'plugin.dart';
import 'plugin_creator.dart';
import 'utils.dart';

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

  final File file =
      File(path.join(Directory.current.path, 'tool/penguin.yaml'));
  final Plugin plugin = Plugin.parse(file.readAsStringSync());

  final PluginCreator creator = PluginCreator(plugin);
  final Directory dartDir = Directory(path.join(pluginDir.path, 'lib/'));

  _createLibraryFile(creator, dartDir, results[PenguinOption.projectName.name]);
  _createClassFiles(creator, dartDir);
  _createChannelFile(creator, dartDir, results[PenguinOption.projectName.name]);
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

void _createChannelFile(PluginCreator creator, Directory dartDir, String projectName) {
  final File channelFile = File(path.join(dartDir.path, 'src/channel.dart'));

  channelFile.createSync(recursive: true);
  channelFile.writeAsStringSync(creator.channelAsString());
}

void _createClassFiles(PluginCreator creator, Directory dartDir) {
  final Map<String, String> classes = creator.classesAsStrings();

  for (String className in classes.keys) {
    final String filename = '${camelCaseToSnakeCase(className)}.dart';
    final File classFile = File(path.join(dartDir.path, 'src/', filename));

    classFile.createSync(recursive: true);
    classFile.writeAsStringSync(classes[className]);
  }
}

void _createLibraryFile(
  PluginCreator creator,
  Directory dartDir,
  String projectName,
) {
  final File libraryFile = File(path.join(dartDir.path, '$projectName.dart'));
  libraryFile.writeAsStringSync(creator.libraryAsString());
}
