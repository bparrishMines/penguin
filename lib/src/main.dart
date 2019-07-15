// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as path;

import 'penguin_option.dart';
import 'package:yaml/yaml.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

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

  final Directory dartDir = Directory(path.join(pluginDir.path, 'lib/'));

  final File file =
      File(path.join(Directory.current.path, 'tool/penguin.yaml'));
  final YamlMap yaml = loadYaml(file.readAsStringSync());

  _createLibraryFile(yaml, dartDir, results[PenguinOption.projectName.name]);
  _createClassFiles(yaml, dartDir);
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

void _createClassFiles(YamlMap yaml, Directory dartDir) {
  final YamlMap classes = yaml['classes'];

  if (classes == null) return;

  final DartEmitter emitter = DartEmitter();
  final DartFormatter formatter = DartFormatter();

  for (String className in classes.keys) {
    final Class dartClass = _createClass(className, classes[className]);

    final String content = formatter.format('${dartClass.accept(emitter)}');

    final String filename = '${_camelCaseToSnakeCase(className)}.dart';
    final File classFile = File(path.join(dartDir.path, 'src/', filename));

    classFile.createSync(recursive: true);
    classFile.writeAsString(content);
  }
}

Class _createClass(String className, YamlMap classYaml) {
  return Class((ClassBuilder builder) {
    builder.name = className;
  });
}

String _camelCaseToSnakeCase(String str) {
  final RegExp regExp = RegExp(r'([A-Z][a-z]*)');

  final StringBuffer buffer = StringBuffer();

  final List<Match> matches = regExp.allMatches(str).toList();
  for (int i = 0; i < matches.length; i++) {
    final String word = matches[i].group(0).toLowerCase();
    buffer.write(word);

    if (i < matches.length - 1) buffer.write('_');
  }

  return buffer.toString();
}

void _createLibraryFile(YamlMap yaml, Directory dartDir, String projectName) {
  final File libraryFile = File('${path.join(dartDir.path, projectName)}.dart');

  libraryFile.writeAsStringSync('library $projectName;\n\n');

  final Library library = Library((LibraryBuilder builder) {
    builder.directives.addAll(<Directive>[
      Directive((DirectiveBuilder builder) {
        builder.type = DirectiveType.import;
        builder.url = 'package:flutter/services.dart';
      }),
      Directive((DirectiveBuilder builder) {
        builder.type = DirectiveType.import;
        builder.url = 'package:flutter/foundation.dart';
      }),
    ]);
  });

  final DartEmitter emitter = DartEmitter();
  final String content = DartFormatter().format('${library.accept(emitter)}');

  libraryFile.writeAsStringSync(content, mode: FileMode.append);

  final YamlMap classes = yaml['classes'];
  if (classes == Null) return;

  final IOSink sink = libraryFile.openWrite(mode: FileMode.append);
  sink.writeln();
  for (String className in classes.keys) {
    sink.writeln('part \'src/${_camelCaseToSnakeCase(className)}.dart\';');
  }

  sink.close();
}
