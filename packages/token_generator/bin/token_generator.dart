import 'dart:io' as io;

import 'package:args/args.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';

const String helpFlag = 'help';
const String inputOption = 'input';

final ArgParser parser = ArgParser()
  ..addFlag('help', abbr: 'h', help: 'Prints usage.');

void main(List<String> arguments) {
  final ArgResults results = parser.parse(arguments);
  if (results[helpFlag]) {
    print(parser.usage);
    io.exit(0);
  }

  late final TokenGeneratorOptions options;
  try {
    options = TokenGeneratorOptions.parse(const LocalFileSystem(), results);
  } on ArgumentError catch (error) {
    print(error.message);
    print(parser.usage);
    io.exit(64);
  }
}

class TokenGeneratorOptions {
  TokenGeneratorOptions._({required this.inputFile});

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

    final TokenGeneratorOptions options = TokenGeneratorOptions._(
      inputFile: inputFile,
    );

    return options;
  }

  final File inputFile;
}
