// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

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

  for (final File file in simpleAstJsonFiles) {
    final Map<String, dynamic> astJson =
        jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;

    final SimpleLibrary library = updateLibrary(
      SimpleLibrary.fromJson(astJson),
      baseObjectClassName: findBaseObjectClassName(allDartLibFiles),
    );

    genDartApiImplementations(
      library,
      outputFile: path.setExtension(file.path, 'gen_api_impls.dart'),
    );
  }
}

ProcessResult run(String executable, List<String> arguments) {
  print('Running `$executable ${arguments.join(' ')}`');
  final ProcessResult result = Process.runSync(executable, arguments);
  if (result.exitCode == 0) {
    return result;
  } else {
    print('Failed to run `$executable ${arguments.join(' ')}`');
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

/// 1. Removes Futures from method return types For example, Future<String> -> String.
/// 2. Removes parameters from constructors and methods that have type 'BinaryMessenger' or 'InstanceManager'.
/// 3. Uses [updateType] and [updateParameter] on all types and parameters.
/// 4. Remove functions from non 'detached' constructor parameters.
SimpleLibrary updateLibrary(
  SimpleLibrary library, {
  required String baseObjectClassName,
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
            customValues: simpleMethod.customValues,
          );
        }).toList(),
        private: simpleClass.private,
        constructors: simpleClass.constructors.map(
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
SimpleType updateType(SimpleType simpleType) {
  final String typeName = simpleType.name;
  late final bool isCodecClass;
  late final String javaName;
  switch (typeName) {
    case 'int':
      isCodecClass = true;
      javaName = 'Long';
      break;
    case 'bool':
      isCodecClass = true;
      javaName = 'Boolean';
      break;
    case 'String':
      isCodecClass = true;
      javaName = 'String';
      break;
    case 'Uint8List':
      isCodecClass = true;
      javaName = 'byte[]';
      break;
    case 'double':
      isCodecClass = true;
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
        'isFuture': simpleType.functionReturnType!.name == 'Future'
    },
  );
}

/// 1. Uses [updateType] on type.
SimpleParameter updateParameter(SimpleParameter simpleParameter) {
  return SimpleParameter(
    name: simpleParameter.name,
    type: updateType(simpleParameter.type),
    isNamed: simpleParameter.isNamed,
    customValues: simpleParameter.customValues,
  );
}
