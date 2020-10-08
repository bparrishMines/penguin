import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as path;
import 'package:reference_generator/src/ast.dart';

import 'dart_generator.dart' show generateDart;
import 'java_generator.dart' show generateJava;

final ArgParser parser = ArgParser()
  ..addOption('package-root', defaultsTo: '.')
  ..addOption('dart-out')
  ..addOption('java-out')
  ..addOption('java-package')
  ..addFlag('help')
  ..addFlag('build', abbr: 'b', defaultsTo: true);

void main(List<String> arguments) async {
  final ArgResults results = parser.parse(arguments);
  if (results['help']) {
    print(parser.usage);
    exit(64);
  }
  final options = ReferenceGeneratorOptions.parse(results);

  if (options.build) {
    final Process process = await Process.start(
      'flutter',
      ['pub', 'run', 'build_runner', 'build'],
      workingDirectory: options.packageRoot.path,
    );

    process.stdout.transform(utf8.decoder).listen((String data) => print(data));
    process.stderr.transform(utf8.decoder).listen((String data) => print(data));
    await process.exitCode;
  }

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

  if (options.dartOut != null) {
    final HttpClientRequest request = await HttpClient().getUrl(
      Uri.parse(
        'https://raw.githubusercontent.com/bparrishMines/penguin/reference_generator/reference/lib/src/template/src/template.g.dart',
      ),
    );
    final HttpClientResponse response = await request.close();

    final StringBuffer buffer = StringBuffer()
      ..writeAll(await response.transform(utf8.decoder).toList());

    final String dartTemplate = buffer.toString();

    options.dartOut.writeAsStringSync(generateDart(dartTemplate, libraryNode));
  }

  if (options.javaOut != null) {
    final HttpClientRequest request = await HttpClient().getUrl(
      Uri.parse(
        'https://raw.githubusercontent.com/bparrishMines/penguin/reference_generator/reference/android/src/main/java/github/penguin/reference/templates/LibraryTemplate.java',
      ),
    );
    final HttpClientResponse response = await request.close();

    final StringBuffer buffer = StringBuffer()
      ..writeAll(await response.transform(utf8.decoder).toList());

    final String javaTemplate = buffer.toString();

    options.javaOut.writeAsStringSync(
      generateJava(
        template: javaTemplate,
        libraryNode: libraryNode,
        libraryName: path.basenameWithoutExtension(options.javaOut.path),
        package: options.javaPackage,
      ),
    );
  }
}

class ReferenceGeneratorOptions {
  ReferenceGeneratorOptions._({
    this.packageRoot,
    this.dartOut,
    this.inputFile,
    this.javaOut,
    this.build,
    this.javaPackage,
  }) : assert(
          javaOut == null || javaPackage != null,
          'Please provide a `--java-package` when setting `--java-out`.',
        );

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

    final ReferenceGeneratorOptions options = ReferenceGeneratorOptions._(
      packageRoot: File(results['package-root']),
      dartOut: results.wasParsed('dart-out') ? File(results['dart-out']) : null,
      inputFile: File(results.rest.first),
      build: results['build'],
      javaOut: results.wasParsed('java-out') ? File(results['java-out']) : null,
      javaPackage: results['java-package'],
    );

    if(options.javaOut != null && options.javaPackage == null) {
      throw ArgumentError('Please provide a `--java-package` when setting `--java-out`.',);
    }

    return options;
  }

  final File packageRoot;
  final File dartOut;
  final File inputFile;
  final bool build;
  final File javaOut;
  final String javaPackage;
}
