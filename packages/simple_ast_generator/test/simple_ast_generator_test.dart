import 'dart:convert';

import 'package:build_test/build_test.dart';
import 'package:simple_ast/simple_ast.dart';
import 'package:simple_ast_generator/src/simple_ast_builder.dart';
import 'package:test/test.dart';

void main() {
  group('simple_ast_generator', () {
    test('simple class', () async {
      var reader = await PackageAssetReader.currentIsolate(
          rootPackage: 'simple_ast_generator');

      const JsonEncoder jsonEncoder = JsonEncoder.withIndent('  ');
      const SimpleLibrary expectedOutputAst = SimpleLibrary(
        classes: <SimpleClass>[
          SimpleClass(
            name: 'Apple',
            methods: <SimpleMethod>[],
            constructors: <SimpleConstructor>[
              SimpleConstructor(name: '', parameters: <SimpleParameter>[]),
            ],
            fields: <SimpleField>[],
            customValues: <String, Object?>{},
          )
        ],
        functions: <SimpleFunction>[],
        enums: <SimpleEnum>[],
      );

      await testBuilder(
        SimpleAstBuilder(),
        {
          'simple_ast_generator|src/some_file.dart': '''
import 'package:simple_ast/annotations.dart';

@SimpleClassAnnotation()
class Apple { }
'''
        },
        outputs: {
          'simple_ast_generator|src/some_file.simple_ast.json':
              jsonEncoder.convert(expectedOutputAst.toJson()),
        },
        reader: reader,
      );
    });

    test('SimpleClassAnnotation.customValues', () async {
      var reader = await PackageAssetReader.currentIsolate(
          rootPackage: 'simple_ast_generator');

      const JsonEncoder jsonEncoder = JsonEncoder.withIndent('  ');
      const SimpleLibrary expectedOutputAst = SimpleLibrary(
        classes: <SimpleClass>[
          SimpleClass(
            name: 'Apple',
            methods: <SimpleMethod>[],
            constructors: <SimpleConstructor>[
              SimpleConstructor(name: '', parameters: <SimpleParameter>[]),
            ],
            fields: <SimpleField>[],
            customValues: <String, Object?>{'a': 'value'},
          )
        ],
        functions: <SimpleFunction>[],
        enums: <SimpleEnum>[],
      );

      await testBuilder(
        SimpleAstBuilder(),
        {
          'simple_ast_generator|src/some_file.dart': '''
import 'package:simple_ast/annotations.dart';

@SimpleClassAnnotation(customValues: <String, Object?>{'a': 'value'})
class Apple { }
'''
        },
        outputs: {
          'simple_ast_generator|src/some_file.simple_ast.json':
              jsonEncoder.convert(expectedOutputAst.toJson()),
        },
        reader: reader,
      );
    });
  });
}
