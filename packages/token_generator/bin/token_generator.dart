import 'dart:io' as io;

import 'package:args/args.dart';
import 'package:colorize/colorize.dart';
import 'package:file/local.dart';

import 'generator.dart';
import 'token_generator_options.dart';

final ArgParser parser = ArgParser()
  ..addFlag(helpFlag, abbr: 'h', help: 'Prints usage.')
  ..addOption(
    tokenOpenerOption,
    help: 'Unique indicator of the beginning of a token.',
    defaultsTo: '/*',
  )
  ..addOption(
    tokenCloserOption,
    help: 'Unique indicator of an end of a token. '
        'Can be equivalent to --$tokenOpenerOption.',
    defaultsTo: '*/',
  )
  ..addOption(
    templateFileOption,
    help:
        'File containing a template to populate with data. Cannot be supplied with `--$templateOption`.',
  )
  ..addOption(templateOption,
      help:
          'Template to populate with data. Cannot be supplied with `--$templateFileOption`.')
  ..addOption(
    dataFileOption,
    help: 'File containing JSON data to populate the output file. Cannot be '
        'supplied with `--$dataOption`.',
  )
  ..addOption(
    dataOption,
    help: 'JSON data to populate the output file. Cannot be supplied with '
        '`--$dataFileOption`.',
  );

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
    print(Colorize(error.message).red());
    print(parser.usage);
    io.exit(64);
  }

  final String output = runGenerator(
    input: options.template,
    data: options.jsonData,
    options: options,
  );

  if (options.outputFile == null) {
    print(output);
  } else {
    options.outputFile!.writeAsStringSync(output);
  }
}
