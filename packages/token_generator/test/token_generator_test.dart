import 'dart:convert';

import 'package:file/file.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';

import '../bin/generator.dart';
import '../bin/token.dart';
import '../bin/token_generator_options.dart';
import 'token_generator_test.mocks.dart';

@GenerateMocks(<Type>[FileSystem])
void main() {
  group('token_generator', () {
    // late MockFileSystem mockFileSystem;
    //
    // setUp(() {
    //   mockFileSystem = MockFileSystem();
    // });

    group('runGenerator', () {
      test('$EraseToken', () {
        final TokenGeneratorOptions options = TokenGeneratorOptions(
          tokenOpener: '/*',
          tokenCloser: '*/',
          template: 'Hello,/*erase*/__hello__/**/ World!',
          jsonData: <String, dynamic>{'hello': 23},
          outputFile: null,
        );
        expect(runGenerator(options), 'Hello, World!');
      });

      group('$ReplaceToken', () {
        test('replace', () {
          final TokenGeneratorOptions options = TokenGeneratorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template: '/*replace hello*/__hello__/**/',
            jsonData: <String, dynamic>{'hello': 23},
            outputFile: null,
          );
          expect(runGenerator(options), '23');
        });

        test('replace what', () {
          final TokenGeneratorOptions options = TokenGeneratorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template: "/*replace :what='Friend' place*/Hello, Friend!/**/",
            jsonData: <String, dynamic>{'place': 'World'},
            outputFile: null,
          );
          expect(runGenerator(options), 'Hello, World!');
        });
      });

      group('$IterateToken', () {
        test('iterate', () {
          final TokenGeneratorOptions options = TokenGeneratorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template: '/*iterate color colors*/__color_name__/**/',
            jsonData: <String, dynamic>{
              'colors': <Map<dynamic, dynamic>>[
                {'name': 'red'},
                {'name': 'green'},
                {'name': 'blue'},
              ],
            },
            outputFile: null,
          );
          expect(runGenerator(options), 'redgreenblue');
        });

        test('iterate with nested replace', () {
          final TokenGeneratorOptions options = TokenGeneratorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template:
                '/*iterate color colors*//*replace color_name*/name/**//**/',
            jsonData: <String, dynamic>{
              'colors': <Map<dynamic, dynamic>>[
                {'name': 'red'},
                {'name': 'green'},
                {'name': 'blue'},
              ],
            },
            outputFile: null,
          );
          expect(runGenerator(options), 'redgreenblue');
        });

        test('iterate with nested if', () {
          final TokenGeneratorOptions options = TokenGeneratorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template:
                '/*iterate color colors*//*if color_hasName*/__color_name__/**//**/',
            jsonData: <String, dynamic>{
              'colors': <Map<dynamic, dynamic>>[
                {'hasName': true, 'name': 'red'},
                {'hasName': false, 'name': 'green'},
                {'hasName': true, 'name': 'blue'},
              ],
            },
            outputFile: null,
          );
          expect(runGenerator(options), 'redblue');
        });
      });

      group('$ConditionalToken', () {
        test('if true', () {
          final TokenGeneratorOptions options = TokenGeneratorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template: '/*if imCool*/ice cold/**/',
            jsonData: <String, dynamic>{'imCool': true},
            outputFile: null,
          );
          expect(runGenerator(options), 'ice cold');
        });

        test('if false', () {
          final TokenGeneratorOptions options = TokenGeneratorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template: '/*if imCool*/ice cold/**/',
            jsonData: <String, dynamic>{'imCool': false},
            outputFile: null,
          );
          expect(runGenerator(options), '');
        });

        test('if true', () {
          final TokenGeneratorOptions options = TokenGeneratorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template: '/*if imCool*/ice cold/**/',
            jsonData: <String, dynamic>{'imCool': true},
            outputFile: null,
          );
          expect(runGenerator(options), 'ice cold');
        });

        test('if false', () {
          final TokenGeneratorOptions options = TokenGeneratorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template: '/*if imCool*/ice cold/**/',
            jsonData: <String, dynamic>{'imCool': false},
            outputFile: null,
          );
          expect(runGenerator(options), '');
        });

        test('if! true', () {
          final TokenGeneratorOptions options = TokenGeneratorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template: '/*if! imCool*/ice cold/**/',
            jsonData: <String, dynamic>{'imCool': false},
            outputFile: null,
          );
          expect(runGenerator(options), 'ice cold');
        });

        test('if! false', () {
          final TokenGeneratorOptions options = TokenGeneratorOptions(
            tokenOpener: '/*',
            tokenCloser: '*/',
            template: '/*if! imCool*/ice cold/**/',
            jsonData: <String, dynamic>{'imCool': true},
            outputFile: null,
          );
          expect(runGenerator(options), '');
        });
      });
    });
  });
}
