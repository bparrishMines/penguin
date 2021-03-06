import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as path;
import 'package:reference_generator/src/ast.dart';

import 'dart_generator.dart' show generateDart;
import 'java_generator.dart' show generateJava;
import 'objc_impl_generator.dart' show generateObjcImpl;
import 'objc_header_generator.dart' show generateObjcHeader;

const String packageRootOption = 'package-root';
const String dartOutOption = 'dart-out';
const String javaOutOption = 'java-out';
const String buildFlag = 'build';
const String javaPackageOption = 'java-package';
const String objcHeaderOutOption = 'objc-header-out';
const String objcImplOutOption = 'objc-impl-out';
const String objcPrefixOption = 'objc-prefix';
const String dartImportsOption = 'dart-imports';
const String branchOption = 'branch';

final ArgParser parser = ArgParser()
  ..addOption(packageRootOption, defaultsTo: '.')
  ..addOption(dartOutOption)
  ..addOption(javaOutOption)
  ..addOption(javaPackageOption)
  ..addOption(objcHeaderOutOption)
  ..addOption(objcImplOutOption)
  ..addOption(objcPrefixOption)
  ..addOption(branchOption)
  ..addMultiOption(dartImportsOption)
  ..addFlag('help', abbr: 'h')
  ..addFlag(buildFlag, abbr: 'b', defaultsTo: true);

void main(List<String> arguments) async {
  final ArgResults results = parser.parse(arguments);
  if (results['help']) {
    print(parser.usage);
    exit(0);
  }

  ReferenceGeneratorOptions options;
  try {
    options = ReferenceGeneratorOptions.parse(results);
  } on ArgumentError catch (error) {
    print(error.message);
    exit(64);
  }

  if (options.build) {
    final Process process = await Process.start(
      'flutter',
      ['pub', 'run', 'build_runner', 'build', '-v'],
      workingDirectory: options.packageRoot.path,
    );

    process.stdout.transform(utf8.decoder).listen((String data) => print(data));
    process.stderr.transform(utf8.decoder).listen((String data) => print(data));
    final int exitCode = await process.exitCode;
    if (exitCode != 0) exit(exitCode);
  }

  final String astFileName = path.setExtension(
    path.basenameWithoutExtension(options.inputFile.path),
    '.reference_ast',
  );

  final File? astInputFile = options.packageRoot
      .listSync(recursive: true)
      .cast<FileSystemEntity?>()
      .firstWhere(
    (FileSystemEntity? entity) {
      return entity is File && path.basename(entity.path) == astFileName;
    },
    orElse: () => null,
  ) as File?;

  if (astInputFile == null) {
    final String message =
        'No file named $astFileName was found. This could be caused by missing'
        ' `Reference()` annotations or not including `reference_generator` in'
        ' `dev_dependencies`';
    throw StateError(message);
  }

  final libraryNode = LibraryNode.fromJson(
    jsonDecode(astInputFile.readAsStringSync()),
  );

  if (options.dartOut != null) {
    final HttpClientRequest request = await HttpClient().getUrl(
      Uri.parse(
        'https://raw.githubusercontent.com/bparrishMines/penguin/${options.branch}/packages/reference_example/lib/src/template.g.dart',
      ),
    );
    final HttpClientResponse response = await request.close();

    final StringBuffer buffer = StringBuffer()
      ..writeAll(await response.transform(utf8.decoder).toList());

    final String dartTemplate = buffer.toString();

    if (dartTemplate == '404: Not Found') {
      throw StateError('Invalid link to Dart template');
    }

    options.dartOut!.writeAsStringSync(
      generateDart(dartTemplate, libraryNode, options.dartImports),
    );
  }

  // TODO: Template files should be come from a specific version of reference
  if (options.javaOut != null) {
    final HttpClientRequest request = await HttpClient().getUrl(
      Uri.parse(
        'https://raw.githubusercontent.com/bparrishMines/penguin/${options.branch}/packages/reference_example/android/src/main/java/com/example/reference_example/LibraryTemplate.java',
      ),
    );
    final HttpClientResponse response = await request.close();

    final StringBuffer buffer = StringBuffer()
      ..writeAll(await response.transform(utf8.decoder).toList());

    final String javaTemplate = buffer.toString();

    if (javaTemplate == '404: Not Found') {
      throw StateError('Invalid link to Java template');
    }

    options.javaOut!.writeAsStringSync(
      generateJava(
        template: javaTemplate,
        libraryNode: libraryNode,
        libraryName: path.basenameWithoutExtension(options.javaOut!.path),
        package: options.javaPackage!,
      ),
    );
  }

  if (options.objcHeaderOut != null) {
    final HttpClientRequest request = await HttpClient().getUrl(
      Uri.parse(
        'https://raw.githubusercontent.com/bparrishMines/penguin/${options.branch}/packages/reference_example/ios/Classes/REFLibraryTemplate.h',
      ),
    );
    final HttpClientResponse response = await request.close();

    final StringBuffer buffer = StringBuffer()
      ..writeAll(await response.transform(utf8.decoder).toList());

    final String objcHeaderTemplate = buffer.toString();

    if (objcHeaderTemplate == '404: Not Found') {
      throw StateError('Invalid link to objcHeader template.');
    }

    options.objcHeaderOut!.writeAsStringSync(
      generateObjcHeader(
        template: objcHeaderTemplate,
        libraryNode: libraryNode,
        prefix: options.objcPrefix!,
      ),
    );
  }

  if (options.objcImplOut != null) {
    final HttpClientRequest request = await HttpClient().getUrl(
      Uri.parse(
        'https://raw.githubusercontent.com/bparrishMines/penguin/${options.branch}/packages/reference_example/ios/Classes/REFLibraryTemplate.m',
      ),
    );
    final HttpClientResponse response = await request.close();

    final StringBuffer buffer = StringBuffer()
      ..writeAll(await response.transform(utf8.decoder).toList());

    final String objcImplTemplate = buffer.toString();

    if (objcImplTemplate == '404: Not Found') {
      throw StateError('Invalid link to objcImpl template.');
    }

    options.objcImplOut!.writeAsStringSync(
      generateObjcImpl(
        template: objcImplTemplate,
        libraryNode: libraryNode,
        prefix: options.objcPrefix!,
        headerFilename: path.basename(options.objcHeaderOut!.path),
      ),
    );
  }
}

class ReferenceGeneratorOptions {
  ReferenceGeneratorOptions._({
    required this.packageRoot,
    this.dartOut,
    required this.inputFile,
    this.javaOut,
    required this.build,
    this.javaPackage,
    this.objcHeaderOut,
    this.objcImplOut,
    this.objcPrefix,
    this.dartImports,
    required this.branch,
  });

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
      packageRoot: Directory(results[packageRootOption]),
      dartOut: results.wasParsed(dartOutOption)
          ? File(results[dartOutOption])
          : null,
      inputFile: File(results.rest.first),
      build: results[buildFlag],
      javaOut: results.wasParsed(javaOutOption)
          ? File(results[javaOutOption])
          : null,
      javaPackage: results[javaPackageOption],
      objcHeaderOut: results.wasParsed(objcHeaderOutOption)
          ? File(results[objcHeaderOutOption])
          : null,
      objcImplOut: results.wasParsed(objcImplOutOption)
          ? File(results[objcImplOutOption])
          : null,
      objcPrefix: results[objcPrefixOption],
      dartImports: results[dartImportsOption],
      branch: results[branchOption] ?? 'master',
    );

    if (options.javaOut != null && options.javaPackage == null) {
      throw ArgumentError(
        'Please provide a `--$javaPackageOption` when setting `--$javaOutOption`.',
      );
    } else if ((options.objcImplOut != null || options.objcHeaderOut != null) &&
        options.objcPrefix == null) {
      throw ArgumentError(
        'Please provide a `--$objcPrefixOption` when setting `--$objcHeaderOutOption` or `--$objcImplOutOption`.',
      );
    } else if (options.objcImplOut != null && options.objcHeaderOut == null) {
      throw ArgumentError(
        'Please provide a `--$objcHeaderOutOption` when setting `--$objcImplOutOption`.',
      );
    }

    return options;
  }

  final Directory packageRoot;
  final File? dartOut;
  final File inputFile;
  final bool build;
  final File? javaOut;
  final String? javaPackage;
  final File? objcHeaderOut;
  final File? objcImplOut;
  final String? objcPrefix;
  final List<String>? dartImports;
  final String branch;
}
