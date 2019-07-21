// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as path;

import 'penguin_option.dart';
import 'plugin.dart';
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

  final File pluginYaml = File(
    path.join(
      Directory.current.path,
      results[PenguinOption.pluginYaml.name],
      'plugin.yaml',
    ),
  );

  final String yaml = pluginYaml.readAsStringSync();

  final Plugin plugin = Plugin.parse(yaml);
  final PluginCreator creator = PluginCreator(plugin);

  _createPubspecFile(creator, pluginDir);
  _createPluginFiles(creator, pluginDir);
  _createJavaFiles(yaml);
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

_createPluginFiles(PluginCreator creator, Directory pluginDir) {
  final Map<String, String> files = creator.pluginAsStrings();

  for (String filePath in files.keys) {
    final File classFile = File(path.join(pluginDir.path, 'lib', filePath));

    classFile.createSync(recursive: true);
    classFile.writeAsStringSync(files[filePath]);
  }
}

void _createPubspecFile(PluginCreator creator, Directory pluginDir) {
  final File pubspecFile = File(path.join(pluginDir.path, 'pubspec.yaml'));

  pubspecFile.createSync(recursive: true);
  pubspecFile.writeAsStringSync(creator.pubspecAsString());
}

void _createJavaFiles(String yaml) {
  final Map<String, String> replacements = <String, String>{
    'plugin:': '!objects.Plugin',
    'class:': '!objects.PluginClass',
    'method:': '!objects.PluginMethod',
    'required_parameter:': '!objects.PluginParameter',
    'optional_parameter:': '!objects.PluginParameter',
    'field:': '!objects.PluginField',
    'static:': 'isStatic:',
    'int': 'Integer',
    'bool': 'Boolean',
    'double': 'Double',
  };

  for (MapEntry<String, String> entry in replacements.entries) {
    yaml = yaml.replaceAll(entry.key, entry.value);
  }

  final String genAndroidCodeScript = 'tool/android-gen/compile_and_run.sh';

  final ProcessResult result = Process.runSync(
    genAndroidCodeScript,
    <String>[yaml],
  );

  print(result.stdout);
  print(result.stderr);
}
