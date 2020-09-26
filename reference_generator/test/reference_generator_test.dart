import 'package:build/build.dart';
import 'package:reference_generator/reference_generator.dart';
import 'package:reference_generator/src/reference_generator.dart';
import 'package:test/test.dart';
import 'package:build_test/build_test.dart';

void main() {
  test('print to dart', () async {
    var reader = await PackageAssetReader.currentIsolate(
        rootPackage: 'reference_generator');

    await testBuilder(
        ReferenceGenerator(), {'reference_generator|src/some_file.dart': ''},
        outputs: {
          'reference_generator|src/some_file.g.dart':
              'void main() {print(\'hi\');}'
        },
        reader: reader);
  });
}
