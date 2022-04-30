import 'dart:io' as io;

import 'package:args/args.dart';
import 'package:colorize/colorize.dart';
import 'package:file/local.dart';

import 'processor.dart';
import 'code_template_processor_options.dart';

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
        'File containing a template to populate with data. Cannot be given with `--$templateOption`.',
  )
  ..addOption(templateOption,
      help:
          'Template to populate with data. Cannot be given with `--$templateFileOption`.')
  ..addOption(
    dataFileOption,
    help: 'File containing JSON data to populate the output file. Cannot be '
        'given with `--$dataOption`.',
  )
  ..addOption(
    dataOption,
    help: 'JSON data to populate the output file. Cannot be given with '
        '`--$dataFileOption`.',
  );

const String supportedTokens = '''Supported tokens:
Iterate: `/*iterate :start=1 :end=4 :join=',' mapKey valueName*/`
Replace: `/*replace :case=pascal :what='strToReplace' mapKey*/`
If: `/*if mapKey*/` or `/*if! mapKey*/`
Erase: `/*erase*/`
''';

void main(List<String> arguments) {
  final ArgResults results = parser.parse(arguments);
  if (results[helpFlag]) {
    print('${parser.usage}\n\n$supportedTokens');
    io.exit(0);
  }

  late final TemplateProcessorOptions options;
  late final String output;
  try {
    options = TemplateProcessorOptions.parse(const LocalFileSystem(), results);
    output = runProcessor(options);
  } on ArgumentError catch (error) {
    print(Colorize(error.message).red());
    if (error.stackTrace != null) {
      print(Colorize(error.stackTrace!.toString()).red());
    }
    print('${parser.usage}\n\n$supportedTokens');

    io.exit(64);
  }

  if (options.outputFile == null) {
    print(output);
  } else {
    options.outputFile!.writeAsStringSync(output);
  }
}
