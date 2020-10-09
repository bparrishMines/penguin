import 'dart:convert';

import 'package:reference_generator/src/ast.dart';
import 'package:reference_generator/src/reference_generator.dart';
import 'package:test/test.dart';
import 'package:build_test/build_test.dart';

void main() {
  test('print to dart', () async {
    var reader = await PackageAssetReader.currentIsolate(
        rootPackage: 'reference_generator');

    await testBuilder(
        ReferenceAstBuilder(),
        {
          'reference_generator|src/some_file.dart': '''
import 'package:reference/reference.dart';

@Reference()
class Apple { }
'''
        },
        outputs: {
          'reference_generator|src/some_file.reference_ast':
              jsonEncode(LibraryNode(<ClassNode>[ClassNode('Apple')])),
        },
        reader: reader);
  });
}
