import 'dart:convert';

import 'package:args/args.dart';
import 'package:file/file.dart';

const String helpFlag = 'help';
const String tokenOpenerOption = 'token-opener';
const String tokenCloserOption = 'token-closer';
const String templateFileOption = 'template-file';
const String templateOption = 'template';
const String dataFileOption = 'data-file';
const String dataOption = 'data';

class TokenGeneratorOptions {
  TokenGeneratorOptions._({
    required this.fileSystem,
    required this.template,
    required this.tokenOpener,
    required this.tokenCloser,
    required this.jsonData,
    required this.outputFile,
  });

  factory TokenGeneratorOptions.parse(
    FileSystem fileSystem,
    ArgResults results,
  ) {
    return TokenGeneratorOptions._(
      fileSystem: fileSystem,
      tokenOpener: _parseTokenOpener(results[tokenOpenerOption]),
      tokenCloser: _parseTokenCloser(results[tokenCloserOption]),
      outputFile: _parseOutputFile(results.rest, fileSystem: fileSystem),
      jsonData: _parseJsonData(
        dataFileString: results[dataFileOption],
        data: results[dataOption],
        fileSystem: fileSystem,
      ),
      template: _parseTemplate(
        templateFileString: results[templateFileOption],
        template: results[templateOption],
        fileSystem: fileSystem,
      ),
    );
  }

  static String _parseTokenOpener(String tokenOpener) {
    if (tokenOpener.isEmpty) {
      throw ArgumentError('Token opener cannot be an empty string.');
    }
    return tokenOpener;
  }

  static String _parseTokenCloser(String tokenCloser) {
    if (tokenCloserOption.isEmpty) {
      throw ArgumentError('Token closer cannot be an empty string.');
    }
    return tokenCloser;
  }

  static File? _parseOutputFile(
    List<String> rest, {
    required FileSystem fileSystem,
  }) {
    if (rest.isEmpty) {
      return null;
    } else if (rest.length > 1) {
      throw ArgumentError('Please provide only a single output file.');
    }

    final String outputFileString = rest.first;

    if (outputFileString.trim().isEmpty) {
      throw ArgumentError('Output file cannot be an empty string.');
    }
    return fileSystem.currentDirectory.childFile(outputFileString.trim());
  }

  static Map<String, Object> _parseJsonData({
    required String? dataFileString,
    required String? data,
    required FileSystem fileSystem,
  }) {
    if (dataFileString == null && data == null) {
      throw ArgumentError(
        'Please provide json data or a file with json data with options `--$dataFileOption` or `--$dataOption`.',
      );
    } else if (dataFileString != null && data != null) {
      throw ArgumentError(
        'Data can only be provided with only one of `--$dataFileOption` or `--$dataOption`. Both options were provided.',
      );
    } else if (dataFileString != null) {
      final File dataFile =
          fileSystem.currentDirectory.childFile(dataFileString);
      return jsonDecode(dataFile.readAsStringSync()).cast<String, Object>();
    }

    return jsonDecode(data!).cast<String, Object>();
  }

  static String _parseTemplate({
    required String? templateFileString,
    required String? template,
    required FileSystem fileSystem,
  }) {
    if (templateFileString == null && template == null) {
      throw ArgumentError(
        'Please provide a template or a template file with options `--$templateFileOption` or `--$templateOption`.',
      );
    } else if (templateFileString != null && template != null) {
      throw ArgumentError(
        'A template can only be provided with only one of `--$templateFileOption` or '
        '`--$templateOption`. Both options were provided.',
      );
    } else if (templateFileString != null) {
      final File templateFile =
          fileSystem.currentDirectory.childFile(templateFileString);
      return templateFile.readAsStringSync();
    }

    return template!;
  }

  final FileSystem fileSystem;

  final File? outputFile;

  final String template;

  final String tokenOpener;

  final String tokenCloser;

  final Map<String, dynamic> jsonData;

  @override
  String toString() {
    return 'TokenGeneratorOptions(fileSystem:$fileSystem, '
        'template:$template, tokenOpener:\'$tokenOpener\', '
        'tokenCloser:\'$tokenCloser\', outputFile:$outputFile, data:$jsonData)';
  }
}
