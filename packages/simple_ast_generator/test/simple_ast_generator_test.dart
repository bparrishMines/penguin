import 'dart:convert';

import 'package:build_test/build_test.dart';
import 'package:simple_ast/simple_ast.dart';
import 'package:simple_ast_generator/src/simple_ast_builder.dart';
import 'package:test/test.dart';

void main() {
  group('simple_ast_generator', () {
    group('SimpleClassAnnotation', () {
      test('simple class', () async {
        var reader = await PackageAssetReader.currentIsolate(
          rootPackage: 'simple_ast_generator',
        );

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

      test('customValues', () async {
        var reader = await PackageAssetReader.currentIsolate(
          rootPackage: 'simple_ast_generator',
        );

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

    group('SimpleMethodAnnotation', () {
      test('customValues', () async {
        var reader = await PackageAssetReader.currentIsolate(
          rootPackage: 'simple_ast_generator',
        );

        const JsonEncoder jsonEncoder = JsonEncoder.withIndent('  ');
        const SimpleLibrary expectedOutputAst = SimpleLibrary(
          classes: <SimpleClass>[
            SimpleClass(
              name: 'Apple',
              methods: <SimpleMethod>[
                SimpleMethod(
                  name: 'aMethod',
                  returnType: SimpleType(
                    name: 'void',
                    nullable: false,
                    typeArguments: <SimpleType>[],
                    isVoid: true,
                    isClass: false,
                    isFunction: false,
                    isEnum: false,
                    isSimpleClass: false,
                    isUnknownOrUnsupportedType: false,
                    functionParameters: <SimpleParameter>[],
                    customValues: <String, Object?>{},
                  ),
                  returnVoid: true,
                  parameters: <SimpleParameter>[],
                  static: false,
                  customValues: <String, Object?>{'a': 'value'},
                ),
              ],
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
class Apple {
  @SimpleMethodAnnotation(customValues: <String, Object?>{'a': 'value'})
  void aMethod() { }
}
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

    group('SimpleTypeAnnotation', () {
      test('method type annotaitons', () async {
        var reader = await PackageAssetReader.currentIsolate(
          rootPackage: 'simple_ast_generator',
        );

        const JsonEncoder jsonEncoder = JsonEncoder.withIndent('  ');
        const SimpleLibrary expectedOutputAst = SimpleLibrary(
          classes: <SimpleClass>[
            SimpleClass(
              name: 'Apple',
              methods: <SimpleMethod>[
                SimpleMethod(
                  name: 'aMethod',
                  returnVoid: true,
                  returnType: SimpleType(
                    name: 'void',
                    nullable: false,
                    typeArguments: <SimpleType>[],
                    isVoid: true,
                    isClass: false,
                    isFunction: false,
                    isEnum: false,
                    isSimpleClass: false,
                    isUnknownOrUnsupportedType: false,
                    functionParameters: <SimpleParameter>[],
                    customValues: <String, Object?>{'a': 'value'},
                  ),
                  parameters: <SimpleParameter>[
                    SimpleParameter(
                      name: 'aParameter',
                      type: SimpleType(
                        name: 'String',
                        nullable: false,
                        typeArguments: <SimpleType>[],
                        isVoid: false,
                        isClass: true,
                        isFunction: false,
                        isEnum: false,
                        isSimpleClass: false,
                        isUnknownOrUnsupportedType: false,
                        functionParameters: <SimpleParameter>[],
                        customValues: <String, Object?>{'a': 'value'},
                      ),
                      customValues: <String, Object?>{},
                    )
                  ],
                  static: false,
                  customValues: <String, Object?>{},
                ),
              ],
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
class Apple {
  @SimpleMethodAnnotation()
  @SimpleTypeAnnotation(customValues: <String, Object?>{'a': 'value'})
  void aMethod(
    @SimpleTypeAnnotation(customValues: <String, Object?>{'a': 'value'}) String aParameter,
  ) { }
}
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

    group('SimpleParameterAnnotation', () {
      test('customValues', () async {
        var reader = await PackageAssetReader.currentIsolate(
          rootPackage: 'simple_ast_generator',
        );

        const JsonEncoder jsonEncoder = JsonEncoder.withIndent('  ');
        const SimpleLibrary expectedOutputAst = SimpleLibrary(
          classes: <SimpleClass>[
            SimpleClass(
              name: 'Apple',
              methods: <SimpleMethod>[
                SimpleMethod(
                  name: 'aMethod',
                  returnVoid: true,
                  returnType: SimpleType(
                    name: 'void',
                    nullable: false,
                    typeArguments: <SimpleType>[],
                    isVoid: true,
                    isClass: false,
                    isFunction: false,
                    isEnum: false,
                    isSimpleClass: false,
                    isUnknownOrUnsupportedType: false,
                    functionParameters: <SimpleParameter>[],
                    customValues: <String, Object?>{},
                  ),
                  parameters: <SimpleParameter>[
                    SimpleParameter(
                      name: 'aParameter',
                      type: SimpleType(
                        name: 'String',
                        nullable: false,
                        typeArguments: <SimpleType>[],
                        isVoid: false,
                        isClass: true,
                        isFunction: false,
                        isEnum: false,
                        isSimpleClass: false,
                        isUnknownOrUnsupportedType: false,
                        functionParameters: <SimpleParameter>[],
                        customValues: <String, Object?>{},
                      ),
                      customValues: <String, Object?>{'a': 'value'},
                    )
                  ],
                  static: false,
                  customValues: <String, Object?>{},
                ),
              ],
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
class Apple {
  @SimpleMethodAnnotation()
  void aMethod(
    @SimpleParameterAnnotation(customValues: <String, Object?>{'a': 'value'}) String aParameter,
  ) { }
}
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
  });
}
