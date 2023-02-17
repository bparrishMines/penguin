// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:recase/recase.dart';
import 'package:simple_ast/simple_ast.dart';
import 'package:path/path.dart' as path;

void main() {
  final Directory currentDirectory = Directory.current;

  print('Running in `${currentDirectory.path}`');

  final Iterable<File> allFiles = currentDirectory
      .listSync(
        recursive: true,
        followLinks: false,
      )
      .whereType<File>();

  if (!allFiles
      .any((File file) => path.basename(file.path) == 'pubspec.yaml')) {
    print('No `pubspec.yaml` found. This should be ran inside of a plugin.');
    exit(1);
  }

  // run('flutter', <String>[
  //   'pub',
  //   'run',
  //   'build_runner',
  //   'build',
  //   '--delete-conflicting-outputs',
  // ]);

  // Filter the list of files to only include files that have a name ending in `.simple_ast.json`.
  final List<File> simpleAstJsonFiles = allFiles
      .whereType<File>()
      .where((File file) => file.path.endsWith('.simple_ast.json'))
      .toList();

  if (simpleAstJsonFiles.isEmpty) {
    print('No `.simple_ast.json` files found');
    exit(0);
  }

  final Iterable<File> allDartLibFiles =
      Directory(path.join(currentDirectory.path, 'lib'))
          .listSync(recursive: true, followLinks: false)
          .whereType<File>();

  final Directory iosDirectory = Directory(
    path.join(currentDirectory.path, 'ios'),
  );
  final bool isObjc = iosDirectory.existsSync() &&
      iosDirectory
          .listSync(recursive: true, followLinks: false)
          .any((FileSystemEntity entity) => entity.path.endsWith('.m'));

  final StringBuffer pigeonOutputBuffer = StringBuffer();

  final Directory testDirectory = Directory(
    path.join(currentDirectory.path, 'test'),
  );
  final bool testDirectoryExists = testDirectory.existsSync();
  if (!testDirectoryExists) {
    print('No `test` directory found!');
  }

  final Directory androidMainDirectory = Directory(
    path.join(currentDirectory.path, 'android', 'src', 'main'),
  );
  Directory? androidJavaDirectory;
  if (androidMainDirectory.existsSync()) {
    final File firstJavaFile = androidMainDirectory
        .listSync(recursive: true, followLinks: false)
        .whereType<File>()
        .firstWhere((File file) {
      return path.extension(file.path) == '.java';
    });
    androidJavaDirectory = Directory(path.dirname(firstJavaFile.path));
  }

  for (final File file in simpleAstJsonFiles) {
    final Map<String, dynamic> astJson =
        jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;

    final String classFileWithoutExtension =
        path.basename(file.path).split('.').first;

    final SimpleLibrary library = updateLibrary(
      SimpleLibrary.fromJson(astJson),
      baseObjectClassName: findBaseObjectClassName(allDartLibFiles),
      isObjc: isObjc,
      dartApiFilename: path.setExtension(
        classFileWithoutExtension,
        '.dart',
      ),
    );

    genDartApiImplementations(
      library,
      outputFile: path.setExtension(
        path.withoutExtension(file.path),
        '.gen_api_impls.dart',
      ),
    );

    if (testDirectoryExists) {
      genDartApiImplementationsTests(
        library,
        outputFile: path.join(
          testDirectory.path,
          path.setExtension(
            path.withoutExtension(path.basename(file.path)),
            '_test.gen_api_impls.dart',
          ),
        ),
      );
    }

    if (androidJavaDirectory != null && androidJavaDirectory.existsSync()) {
      genJavaHostApiImplementation(
        library,
        outputFile: path.join(
          androidJavaDirectory.path,
          'GenApiImpls${classFileWithoutExtension.pascalCase}HostApiImpl.java',
        ),
      );

      genJavaFlutterApiImplementation(
        library,
        outputFile: path.join(
          androidJavaDirectory.path,
          'GenApiImpls${classFileWithoutExtension.pascalCase}FlutterApiImpl.java',
        ),
      );
    }

    pigeonOutputBuffer.writeln(genPigeonOutput(library));
    pigeonOutputBuffer.writeln();
  }

  final Directory pigeonDirectory = Directory(
    path.join(currentDirectory.path, 'pigeons'),
  );

  if (pigeonDirectory.existsSync()) {
    final File pigeonFile = File(
      path.join(
        pigeonDirectory.path,
        'aggregated_pigeons.gen_api_impls.dart',
      ),
    );
    if (!pigeonFile.existsSync()) {
      pigeonFile.createSync();
    }
    pigeonFile.writeAsStringSync(pigeonOutputBuffer.toString());
  } else {
    print('No `pigeons` directory found!');
  }

  final Directory androidTestDirectory = Directory(
    path.join(currentDirectory.path, 'android', 'src', 'test'),
  );
  Directory? androidJavaTestsDirectory;
  if (androidTestDirectory.existsSync()) {
    final File firstJavaFile = androidTestDirectory
        .listSync(recursive: true)
        .whereType<File>()
        .firstWhere((File file) {
      return path.extension(file.path) == '.java';
    });
    androidJavaTestsDirectory = Directory(path.dirname(firstJavaFile.path));
  }

  // for (File file in simpleAstJsonFiles) {
  //   file.deleteSync();
  // }
}

ProcessResult run(String executable, List<String> arguments) {
  final String printableArguments = arguments.map((String argument) {
    if (argument.length >= 40) {
      return '${argument.substring(0, 15)}...${argument.substring(argument.length - 25)}';
    }
    return argument;
  }).join(' ');
  print('Running `$executable $printableArguments`');

  final ProcessResult result = Process.runSync(executable, arguments);
  if (result.exitCode == 0) {
    return result;
  } else {
    print('Failed to run `$executable $printableArguments`');
    print(result.stdout);
    print(result.stderr);
    exit(1);
  }
}

void genDartApiImplementations(
  SimpleLibrary library, {
  required String outputFile,
}) {
  run('flutter', <String>[
    'pub',
    'run',
    'code_template_processor',
    '--template-file',
    // TODO(bparrishMines): download template file
    'lib/src/my_class.template.dart',
    '--data',
    const JsonEncoder().convert(library.toJson()),
    outputFile,
  ]);
}

String genPigeonOutput(SimpleLibrary library) {
  return run('flutter', <String>[
    'pub',
    'run',
    'code_template_processor',
    '--template-file',
    // TODO(bparrishMines): download template file
    'pigeons/example_library.template.dart',
    '--data',
    const JsonEncoder().convert(library.toJson()),
  ]).stdout;
}

void genDartApiImplementationsTests(
  SimpleLibrary library, {
  required String outputFile,
}) {
  run('flutter', <String>[
    'pub',
    'run',
    'code_template_processor',
    '--template-file',
    // TODO(bparrishMines): download template file
    'test/my_class_test.template.dart',
    '--data',
    const JsonEncoder().convert(library.toJson()),
    outputFile,
  ]);
}

void genJavaHostApiImplementation(
  SimpleLibrary library, {
  required String outputFile,
}) {
  run('flutter', <String>[
    'pub',
    'run',
    'code_template_processor',
    '--token-opener=/*-',
    '--template-file',
    // TODO(bparrishMines): download template file
    'android/src/main/java/com/example/wrapper_example/TemplateMyClassHostApiImpl.java',
    '--data',
    const JsonEncoder().convert(library.toJson()),
    outputFile,
  ]);
}

void genJavaFlutterApiImplementation(
  SimpleLibrary library, {
  required String outputFile,
}) {
  run('flutter', <String>[
    'pub',
    'run',
    'code_template_processor',
    '--token-opener=/*-',
    '--template-file',
    // TODO(bparrishMines): download template file
    'android/src/main/java/com/example/wrapper_example/TemplateMyClassFlutterApiImpl.java',
    '--data',
    const JsonEncoder().convert(library.toJson()),
    outputFile,
  ]);
}

/// 1. Removes Futures from method return types For example, Future<String> -> String.
/// 2. Removes parameters from constructors and methods that have type 'BinaryMessenger' or 'InstanceManager'.
/// 3. Uses [updateType] and [updateParameter] on all types and parameters.
/// 4. Remove functions from non 'detached' constructor parameters.
SimpleLibrary updateLibrary(
  SimpleLibrary library, {
  required String baseObjectClassName,
  required bool isObjc,
  // Only the basename
  required String dartApiFilename,
}) {
  return SimpleLibrary(
    classes: library.classes.map<SimpleClass>((SimpleClass simpleClass) {
      // Parameters in the constructor named detached.
      final List<SimpleParameter> detachedParameters = simpleClass.constructors
          .firstWhere((SimpleConstructor simpleConstructor) {
            return simpleConstructor.name == 'detached';
          })
          .parameters
          .where(
            (SimpleParameter simpleParameter) {
              return simpleParameter.type.name != 'BinaryMessenger' &&
                  simpleParameter.type.name != 'InstanceManager';
            },
          )
          .map(updateParameter)
          .toList();

      final List<SimpleField> attachedFields =
          simpleClass.fields.where((SimpleField simpleField) {
        return !detachedParameters.any((SimpleParameter simpleParameter) {
          return simpleField.name == simpleParameter.name;
        });
      }).toList();

      return SimpleClass(
        name: simpleClass.name,
        methods: simpleClass.methods.map((SimpleMethod simpleMethod) {
          final SimpleType returnType = simpleMethod.returnType.name != 'Future'
              ? simpleMethod.returnType
              : simpleMethod.returnType.typeArguments[0];
          return SimpleMethod(
            name: simpleMethod.name,
            returnType: updateType(returnType),
            returnsVoid: returnType.isVoid,
            parameters: simpleMethod.parameters
                .where(
                  (SimpleParameter simpleParameter) {
                    return simpleParameter.type.name != 'BinaryMessenger' &&
                        simpleParameter.type.name != 'InstanceManager';
                  },
                )
                .map(updateParameter)
                .toList(),
            private: simpleMethod.private,
            static: simpleMethod.static,
            customValues: <String, Object?>{
              ...simpleMethod.customValues,
              'hasParameters': simpleMethod.parameters.where(
                (SimpleParameter simpleParameter) {
                  return simpleParameter.type.name != 'BinaryMessenger' &&
                      simpleParameter.type.name != 'InstanceManager';
                },
              ).isNotEmpty,
            },
          );
        }).toList(),
        private: simpleClass.private,
        constructors: simpleClass.constructors.where(
          (SimpleConstructor simpleConstructor) {
            return simpleConstructor.parameters.isNotEmpty;
          },
        ).map(
          (SimpleConstructor simpleConstructor) {
            return SimpleConstructor(
              name: simpleConstructor.name,
              private: simpleConstructor.private,
              parameters: simpleConstructor.parameters
                  .where(
                    (SimpleParameter simpleParameter) {
                      return simpleParameter.type.name != 'BinaryMessenger' &&
                          simpleParameter.type.name != 'InstanceManager' &&
                          (simpleConstructor.name == 'detached' ||
                              !simpleParameter.type.isFunction);
                    },
                  )
                  .map(updateParameter)
                  .toList(),
            );
          },
        ).toList(),
        fields: simpleClass.fields.map((SimpleField simpleField) {
          return SimpleField(
            name: simpleField.name,
            private: simpleField.private,
            static: simpleField.static,
            type: updateType(simpleField.type),
          );
        }).toList(),
        customValues: <String, Object?>{
          ...simpleClass.customValues,
          'detachedParameters': detachedParameters,
          'attachedFields': attachedFields,
          'baseObjectClassName': baseObjectClassName,
          'isObjc': isObjc,
          'needsProxy': simpleClass.methods.any(
                (SimpleMethod simpleMethod) {
                  return simpleMethod.static;
                },
              ) ||
              simpleClass.constructors.where(
                (SimpleConstructor simpleConstructor) {
                  return simpleConstructor.parameters.isNotEmpty;
                },
              ).any(
                (SimpleConstructor simpleConstructor) {
                  return simpleConstructor.name != 'detached';
                },
              ),
          'hasCallbacks': simpleClass.fields.any(
            (SimpleField simpleField) => simpleField.type.isFunction,
          ),
        },
      );
    }).toList(),
    functions: library.functions.map((SimpleFunction simpleFunction) {
      return SimpleFunction(
        name: simpleFunction.name,
        returnType: updateType(simpleFunction.returnType),
        parameters: simpleFunction.parameters.map(updateParameter).toList(),
        private: simpleFunction.private,
      );
    }).toList(),
    enums: library.enums,
    customValues: <String, Object?>{
      ...library.customValues,
      'dartApiFilename': dartApiFilename,
    },
  );
}

String findBaseObjectClassName(Iterable<File> files) {
  for (File file in files) {
    String? currentClass;
    for (String line in file.readAsLinesSync()) {
      currentClass =
          RegExp(r'(?<=class\s)\w+(?=\s)').stringMatch(line) ?? currentClass;

      if (currentClass != null &&
          line.contains('InstanceManager get globalInstanceManager')) {
        return currentClass;
      }
    }
  }

  print(
    'Could not find a class that contains `InstanceManager get globalInstanceManager`.',
  );
  exit(1);
}

/// 1. Adds if type is a class supported by the codec: `isCodecClass`
/// 2. Adds `javaName` to use for java code.
/// 3. Adds `dartName` with the nullable token on the type name.
/// 4. Removes Futures from function return types For example, Future<String> -> String.
/// 5. Adds a `dartTestValue` when testing codec values in tests;
SimpleType updateType(SimpleType simpleType) {
  final String typeName = simpleType.name;
  late final bool isCodecClass;
  late final String javaName;
  Object? dartTestValue;
  switch (typeName) {
    case 'int':
      isCodecClass = true;
      dartTestValue = '0';
      javaName = 'Long';
      break;
    case 'bool':
      isCodecClass = true;
      dartTestValue = 'true';
      javaName = 'Boolean';
      break;
    case 'String':
      isCodecClass = true;
      dartTestValue = "'testString'";
      javaName = 'String';
      break;
    case 'Uint8List':
      isCodecClass = true;
      dartTestValue = 'Uint8List(0)';
      javaName = 'byte[]';
      break;
    case 'double':
      isCodecClass = true;
      dartTestValue = '1.0';
      javaName = 'Double';
      break;
    case 'void':
      isCodecClass = true;
      javaName = 'void';
      break;
    default:
      isCodecClass = false;
      javaName = simpleType.name;
  }
  final SimpleType? functionReturnType =
      simpleType.functionReturnType?.name != 'Future'
          ? simpleType.functionReturnType
          : simpleType.functionReturnType!.typeArguments[0];
  return SimpleType(
    name: simpleType.name,
    nullable: simpleType.nullable,
    typeArguments: simpleType.typeArguments,
    isVoid: simpleType.isVoid,
    isClass: simpleType.isClass,
    isFunction: simpleType.isFunction,
    isEnum: simpleType.isEnum,
    isSimpleClass: simpleType.isSimpleClass,
    isUnknownOrUnsupportedType: simpleType.isUnknownOrUnsupportedType,
    functionParameters:
        simpleType.functionParameters.map(updateParameter).toList(),
    functionReturnType:
        functionReturnType == null ? null : updateType(functionReturnType),
    customValues: <String, Object?>{
      ...simpleType.customValues,
      'isCodecClass': isCodecClass,
      'javaName': javaName,
      'dartName': '${simpleType.name}${simpleType.nullable ? '?' : ''}',
      if (simpleType.functionReturnType != null)
        'isFuture': simpleType.functionReturnType!.name == 'Future',
      'dartTestValue': dartTestValue,
    },
  );
}

int testIdentifier = 1;

/// 1. Uses [updateType] on type.
/// 2. Adds an incrementing test identifier.
SimpleParameter updateParameter(SimpleParameter simpleParameter) {
  return SimpleParameter(
    name: simpleParameter.name,
    type: updateType(simpleParameter.type),
    isNamed: simpleParameter.isNamed,
    customValues: <String, Object?>{
      ...simpleParameter.customValues,
      'testIdentifier': testIdentifier++,
    },
  );
}
