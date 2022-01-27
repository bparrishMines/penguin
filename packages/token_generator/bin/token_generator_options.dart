import 'dart:convert';

import 'package:args/args.dart';
import 'package:file/file.dart';

const String helpFlag = 'help';
const String tokenOpenerOption = 'token-opener';
const String tokenCloserOption = 'token-closer';
const String outputOption = 'output';
const String dataFileOption = 'data-file';
const String dataOption = 'data';

class TokenGeneratorOptions {
  TokenGeneratorOptions._({
    required this.fileSystem,
    required this.inputFile,
    required this.tokenOpener,
    required this.tokenCloser,
    required this.outputFile,
    required this.jsonData,
  });

  factory TokenGeneratorOptions.parse(
    FileSystem fileSystem,
    ArgResults results,
  ) {
    if (results.rest.isEmpty || results.rest.length > 1) {
      throw ArgumentError('Please provide only a single input file.');
    }

    final File inputFile =
        fileSystem.currentDirectory.childFile(results.rest.first);
    if (!inputFile.existsSync()) {
      throw ArgumentError('Please provide an existing input file.');
    }

    final String tokenOpener = results[tokenOpenerOption];
    if (tokenOpener.isEmpty) {
      throw ArgumentError('Token opener cannot be an empty string.');
    }

    final String tokenCloser = results[tokenCloserOption];
    if (tokenCloserOption.isEmpty) {
      throw ArgumentError('Token closer cannot be an empty string.');
    }

    final String? outputFileString = results[outputOption];

    final Map<String, Object> inputJsonData;
    final String? dataFileString = results[dataFileOption];
    final String? data = results[dataOption];
    if (dataFileString == null && data == null) {
      throw ArgumentError(
        'Please provide json data or a file with json data with option `--$dataFileOption` or `--$dataOption`',
      );
    } else if (dataFileString != null && data != null) {
      throw ArgumentError(
        'Data can only be provided with only one of `--$dataFileOption` or `--$dataOption`. Both options were provided.',
      );
    } else if (dataFileString != null) {
      final File dataFile =
          fileSystem.currentDirectory.childFile(dataFileString);
      inputJsonData = jsonDecode(dataFile.readAsStringSync());
    } else {
      inputJsonData = jsonDecode(data!);
    }

    final TokenGeneratorOptions options = TokenGeneratorOptions._(
      fileSystem: fileSystem,
      inputFile: inputFile,
      tokenOpener: tokenOpener,
      tokenCloser: tokenCloser,
      outputFile: outputFileString != null
          ? fileSystem.currentDirectory.childFile(outputFileString)
          : null,
      jsonData: inputJsonData,
    );

    return options;
  }

  final FileSystem fileSystem;

  final File inputFile;

  final String tokenOpener;

  final String tokenCloser;

  final File? outputFile;

  final Map<String, Object> jsonData;

  @override
  String toString() {
    return 'TokenGeneratorOptions(fileSystem:$fileSystem, '
        'inputFile:${inputFile.absolute}, tokenOpener:\'$tokenOpener\', '
        'tokenCloser:\'$tokenCloser\', outputFile:$outputFile, data:$jsonData)';
  }
}
