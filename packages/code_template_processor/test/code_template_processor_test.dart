import 'dart:collection';

import 'package:file/file.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';

import '../bin/processor.dart';
import '../bin/code_template_processor_options.dart';
import '../bin/processor_utils.dart';
import '../bin/token.dart';

@GenerateMocks(<Type>[FileSystem])
void main() {
  group('code_template_processor', () {
    group('retrieveValueForIdentifier', () {
      test('retrieve values for in map', () {
        expect(
          retrieveValueForIdentifier(
            tokenStack: Queue<Token>(),
            identifier: 'find_me_please',
            data: <String, Object>{
              'find': <Object, Object>{
                'me': <String, Object>{'please': 23}
              },
            },
          ),
          23,
        );
      });
    });

    group('runProcessor', () {
      group('TemplateProcessorOptions', () {
        test('can change token opener and closer', () {
          final TemplateProcessorOptions options = TemplateProcessorOptions(
            tokenOpener: '/*-',
            tokenCloser: '-*/',
            template: 'Hello,/*-erase-*/__hello__/*--*/ World!',
            jsonData: <String, dynamic>{'hello': 23},
            outputFile: null,
          );
          expect(runProcessor(options), 'Hello, World!');
        });
      });

      test('EraseToken', () {
        final TemplateProcessorOptions options = TemplateProcessorOptions(
          tokenOpener: '/*',
          tokenCloser: '*/',
          template: 'Hello,/*erase*/__hello__/**/ World!',
          jsonData: <String, dynamic>{'hello': 23},
          outputFile: null,
        );
        expect(runProcessor(options), 'Hello, World!');
      });

      group('ReplaceToken', () {
        test('replace', () {
          final TemplateProcessorOptions options = TemplateProcessorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template: '/*replace hello*/__hello__/**/',
            jsonData: <String, dynamic>{'hello': 23},
            outputFile: null,
          );
          expect(runProcessor(options), '23');
        });

        test('replace what', () {
          final TemplateProcessorOptions options = TemplateProcessorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template: "/*replace :what='Friend' place*/Hello, Friend!/**/",
            jsonData: <String, dynamic>{'place': 'World'},
            outputFile: null,
          );
          expect(runProcessor(options), 'Hello, World!');
        });

        test('replace case', () {
          // pascal case
          final TemplateProcessorOptions pascalOptions =
              TemplateProcessorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template: "/*replace :case=pascal key*/replaceMe/**/",
            jsonData: <String, dynamic>{'key': 'pascalCase'},
            outputFile: null,
          );
          expect(runProcessor(pascalOptions), 'PascalCase');

          // camel case
          final TemplateProcessorOptions camelOptions =
              TemplateProcessorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template: "/*replace :case=camel key*/ReplaceMe/**/",
            jsonData: <String, dynamic>{'key': 'CamelCase'},
            outputFile: null,
          );
          expect(runProcessor(camelOptions), 'camelCase');

          // constant case
          final TemplateProcessorOptions options = TemplateProcessorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template: "/*replace :case=constant key*/replaceMe/**/",
            jsonData: <String, dynamic>{'key': 'constantCase'},
            outputFile: null,
          );
          expect(runProcessor(options), 'CONSTANT_CASE');
        });
      });

      group('IterateToken', () {
        test('iterate', () {
          final TemplateProcessorOptions options = TemplateProcessorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template: '/*iterate colors color*/__color_name__/**/',
            jsonData: <String, dynamic>{
              'colors': <Map<dynamic, dynamic>>[
                {'name': 'red'},
                {'name': 'green'},
                {'name': 'blue'},
              ],
            },
            outputFile: null,
          );
          expect(runProcessor(options), 'redgreenblue');
        });

        test('join', () {
          final TemplateProcessorOptions options = TemplateProcessorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template: "[/*iterate :join=', ' colors color*/__color_name__/**/]",
            jsonData: <String, dynamic>{
              'colors': <Map<dynamic, dynamic>>[
                {'name': 'red'},
                {'name': 'green'},
                {'name': 'blue'},
              ],
            },
            outputFile: null,
          );
          expect(runProcessor(options), '[red, green, blue]');
        });

        test('start', () {
          final TemplateProcessorOptions options = TemplateProcessorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template: "/*iterate :start=1 colors color*/__color_name__/**/",
            jsonData: <String, dynamic>{
              'colors': <Map<dynamic, dynamic>>[
                {'name': 'red'},
                {'name': 'green'},
                {'name': 'blue'},
              ],
            },
            outputFile: null,
          );
          expect(runProcessor(options), 'greenblue');
        });

        test('start has max value equal to data list length - 1', () {
          final TemplateProcessorOptions options = TemplateProcessorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template: "/*iterate :start=5 colors color*/__color_name__/**/",
            jsonData: <String, dynamic>{
              'colors': <Map<dynamic, dynamic>>[
                {'name': 'red'},
                {'name': 'green'},
                {'name': 'blue'},
              ],
            },
            outputFile: null,
          );
          expect(runProcessor(options), '');
        });

        test('end', () {
          final TemplateProcessorOptions options = TemplateProcessorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template: "/*iterate :end=2 colors color*/__color_name__/**/",
            jsonData: <String, dynamic>{
              'colors': <Map<dynamic, dynamic>>[
                {'name': 'red'},
                {'name': 'green'},
                {'name': 'blue'},
              ],
            },
            outputFile: null,
          );
          expect(runProcessor(options), 'redgreen');
        });

        test('end has max value of data list length', () {
          final TemplateProcessorOptions options = TemplateProcessorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template: "/*iterate :end=18 colors color*/__color_name__/**/",
            jsonData: <String, dynamic>{
              'colors': <Map<dynamic, dynamic>>[
                {'name': 'red'},
                {'name': 'green'},
                {'name': 'blue'},
              ],
            },
            outputFile: null,
          );
          expect(runProcessor(options), 'redgreenblue');
        });

        test('iterate with nested replace', () {
          final TemplateProcessorOptions options = TemplateProcessorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template:
                '/*iterate colors color*//*replace color_name*/name/**//**/',
            jsonData: <String, dynamic>{
              'colors': <Map<dynamic, dynamic>>[
                {'name': 'red'},
                {'name': 'green'},
                {'name': 'blue'},
              ],
            },
            outputFile: null,
          );
          expect(runProcessor(options), 'redgreenblue');
        });

        test('iterate with nested if', () {
          final TemplateProcessorOptions options = TemplateProcessorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template:
                '/*iterate colors color*//*if color_hasName*/__color_name__/**//**/',
            jsonData: <String, dynamic>{
              'colors': <Map<dynamic, dynamic>>[
                {'hasName': true, 'name': 'red'},
                {'hasName': false, 'name': 'green'},
                {'hasName': true, 'name': 'blue'},
              ],
            },
            outputFile: null,
          );
          expect(runProcessor(options), 'redblue');
        });

        test('iterate with nested erase', () {
          final TemplateProcessorOptions options = TemplateProcessorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template:
                '/*iterate colors color*/Hello, /*erase*/some stuff to erase/**/World!/**/',
            jsonData: <String, dynamic>{
              'colors': <Map<dynamic, dynamic>>[
                {'name': 'red'},
              ],
            },
            outputFile: null,
          );
          expect(runProcessor(options), 'Hello, World!');
        });

        test('iterate with nested iterate', () {
          final TemplateProcessorOptions options = TemplateProcessorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template:
                '/*iterate colors color*//*iterate redObjects object*/__name__ is __color_name__. /**//**/',
            jsonData: <String, dynamic>{
              'colors': <Map<dynamic, dynamic>>[
                {
                  'name': 'red',
                  'redObjects': <Map<dynamic, dynamic>>[
                    <dynamic, dynamic>{'name': 'Fire Truck'},
                    <dynamic, dynamic>{'name': 'Apple'},
                    <dynamic, dynamic>{'name': 'Fire Hydrant'},
                  ]
                },
              ],
            },
            outputFile: null,
          );
          expect(
            runProcessor(options),
            'Fire Truck is red. Apple is red. Fire Hydrant is red. ',
          );
        });

        test('iterate with nested identifier values', () {
          final TemplateProcessorOptions options = TemplateProcessorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template: '/*iterate people person*/__person_name_first__/**/',
            jsonData: <String, dynamic>{
              'people': <Map<dynamic, dynamic>>[
                {
                  'name': <dynamic, dynamic>{'first': 'Johnny'},
                },
              ],
            },
            outputFile: null,
          );
          expect(runProcessor(options), 'Johnny');
        });
      });

      group('ConditionalToken', () {
        test('if true', () {
          final TemplateProcessorOptions options = TemplateProcessorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template: '/*if imCool*/ice cold/**/',
            jsonData: <String, dynamic>{'imCool': true},
            outputFile: null,
          );
          expect(runProcessor(options), 'ice cold');
        });

        test('if false', () {
          final TemplateProcessorOptions options = TemplateProcessorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template: '/*if imCool*/ice cold/**/',
            jsonData: <String, dynamic>{'imCool': false},
            outputFile: null,
          );
          expect(runProcessor(options), '');
        });

        test('if when value is not null', () {
          final TemplateProcessorOptions options = TemplateProcessorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template: '/*if imCool*/ice cold/**/',
            jsonData: <String, dynamic>{'imCool': 'fwoi'},
            outputFile: null,
          );
          expect(runProcessor(options), 'ice cold');
        });

        test('if when value is null', () {
          final TemplateProcessorOptions options = TemplateProcessorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template: '/*if imCool*/ice cold/**/',
            jsonData: <String, dynamic>{},
            outputFile: null,
          );
          expect(runProcessor(options), '');
        });

        test('if! true', () {
          final TemplateProcessorOptions options = TemplateProcessorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template: '/*if! imCool*/ice cold/**/',
            jsonData: <String, dynamic>{'imCool': false},
            outputFile: null,
          );
          expect(runProcessor(options), 'ice cold');
        });

        test('if! false', () {
          final TemplateProcessorOptions options = TemplateProcessorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template: '/*if! imCool*/ice cold/**/',
            jsonData: <String, dynamic>{'imCool': true},
            outputFile: null,
          );
          expect(runProcessor(options), '');
        });

        test('if! when value is not null', () {
          final TemplateProcessorOptions options = TemplateProcessorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template: '/*if! imCool*/ice cold/**/',
            jsonData: <String, dynamic>{'imCool': 'fwoi'},
            outputFile: null,
          );
          expect(runProcessor(options), '');
        });

        test('if! when value is null', () {
          final TemplateProcessorOptions options = TemplateProcessorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template: '/*if! imCool*/ice cold/**/',
            jsonData: <String, dynamic>{},
            outputFile: null,
          );
          expect(runProcessor(options), 'ice cold');
        });
      });
    });
  });
}
