import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as path;
import 'package:reference_generator/src/ast.dart';

final ArgParser parser = ArgParser()
  ..addOption('package-root', defaultsTo: '.')
  ..addOption('dart-out')
  ..addFlag('help');

void main(List<String> arguments) async {
  final ArgResults results = parser.parse(arguments);
  if (results['help']) {
    print(parser.usage);
    exit(64);
  }
  final options = ReferenceGeneratorOptions.parse(results);

  final Process process = await Process.start(
    'flutter',
    ['pub', 'run', 'build_runner', 'build'],
    workingDirectory: options.packageRoot.path,
  );

  process.stdout.transform(utf8.decoder).listen((String data) => print(data));
  process.stderr.transform(utf8.decoder).listen((String data) => print(data));
  await process.exitCode;

  final File astInputFile = File(path.setExtension(
    path.withoutExtension(options.inputFile.path),
    '.reference_ast',
  ));

  // TODO: make sure astInputFile exists

  final libraryNode = LibraryNode.fromJson(
    jsonDecode(
      astInputFile.readAsStringSync(),
    ),
  );

  final HttpClientRequest request = await HttpClient().getUrl(Uri.parse(
      'https://raw.githubusercontent.com/bparrishMines/penguin/reference_generator/reference/lib/src/template/src/template.g.dart'));
  final HttpClientResponse response = await request.close();

  final StringBuffer buffer = StringBuffer()
    ..writeAll(await response.transform(utf8.decoder).toList());

  final String dartTemplate = buffer.toString();

  options?.dartOut?.writeAsStringSync(dartTemplate);
}

class ReferenceGeneratorOptions {
  ReferenceGeneratorOptions._({this.packageRoot, this.dartOut, this.inputFile});

  factory ReferenceGeneratorOptions.parse(ArgResults results) {
    if (results.rest.isEmpty || results.rest.length > 1) {
      throw ArgumentError('Please provide only one input file.');
    }

    final inputFile = File(results.rest.first);
    if (!inputFile.existsSync()) {
      throw ArgumentError('Please provide an existing input file.');
    } else if (path.extension(inputFile.path) != '.dart') {
      throw ArgumentError('Please provide an input file ending in `.dart`.');
    }

    return ReferenceGeneratorOptions._(
      packageRoot: File(results['package-root']),
      dartOut: results.wasParsed('dart-out') ? File(results['dart-out']) : null,
      inputFile: File(results.rest.first),
    );
  }

  final File packageRoot;
  final File dartOut;
  final File inputFile;
}
