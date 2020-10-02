import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as path;
import 'package:reference_generator/src/ast.dart';

final String darty = r'''import 'package:reference/reference.dart';

// Helper Typedefs
typedef _$LocalCreatorHandler = LocalReference Function(
  $LocalHandler localHandler,
  ReferencePairManager manager,
  List<Object> arguments,
);

typedef _$LocalStaticMethodHandler = Object Function(
  $LocalHandler localHandler,
  ReferencePairManager manager,
  List<Object> arguments,
);

typedef _$LocalMethodHandler = Object Function(
  LocalReference localReference,
  List<Object> arguments,
);

typedef _$CreationArgumentsHandler = List<Object> Function(
  LocalReference localReference,
);

// Classes
abstract class $ClassTemplate implements LocalReference {
  int get fieldTemplate;

  Future<String> methodTemplate(String parameterTemplate);

  @override
  Type get referenceType => $ClassTemplate;
}

// Class Extensions
extension $ClassTemplateMethods on $ClassTemplate {
  static Future<Object> $staticMethodTemplate(
    $ReferencePairManager referencePairManager,
    String parameterTemplate,
  ) {
    return referencePairManager.invokeRemoteStaticMethod(
      $ClassTemplate,
      'staticMethodTemplate',
      <Object>[parameterTemplate],
    );
  }

  Future<Object> $methodTemplate(
    $ReferencePairManager referencePairManager,
    String parameterTemplate,
  ) {
    if (referencePairManager.getPairedRemoteReference(this) == null) {
      return referencePairManager.invokeRemoteMethodOnUnpairedReference(
        this,
        'methodTemplate',
        <Object>[parameterTemplate],
      );
    }

    return referencePairManager.invokeRemoteMethod(
      referencePairManager.getPairedRemoteReference(this),
      'methodTemplate',
      <Object>[parameterTemplate],
    );
  }
}

// Reference Pair Manager
abstract class $ReferencePairManager extends MethodChannelReferencePairManager {
  $ReferencePairManager(
    String channelName, {
    ReferenceMessageCodec messageCodec,
  }) : super(
          <Type>[$ClassTemplate],
          channelName,
          messageCodec: messageCodec,
          poolId: channelName,
        );

  @override
  $LocalHandler get localHandler;

  @override
  MethodChannelRemoteHandler get remoteHandler => $RemoteHandler(channel.name);
}

// LocalReferenceCommunicationHandler
class $LocalHandler with LocalReferenceCommunicationHandler {
  const $LocalHandler({
    this.createClassTemplate,
    this.classTemplate$staticMethodTemplate,
  });

  static final Map<Type, _$LocalCreatorHandler> _creators =
      <Type, _$LocalCreatorHandler>{
    $ClassTemplate: (
      $LocalHandler localHandler,
      ReferencePairManager manager,
      List<Object> arguments,
    ) {
      return localHandler.createClassTemplate(manager, arguments[0]);
    },
  };

  static final Map<Type, Map<String, _$LocalStaticMethodHandler>>
      _staticMethods = <Type, Map<String, _$LocalStaticMethodHandler>>{
    $ClassTemplate: <String, _$LocalStaticMethodHandler>{
      'staticMethodTemplate': (
        $LocalHandler localHandler,
        ReferencePairManager manager,
        List<Object> arguments,
      ) {
        return localHandler.classTemplate$staticMethodTemplate(
          manager,
          arguments[0],
        );
      },
    },
  };

  static final Map<Type, Map<String, _$LocalMethodHandler>> _methods =
      <Type, Map<String, _$LocalMethodHandler>>{
    $ClassTemplate: <String, _$LocalMethodHandler>{
      'methodTemplate': (
        LocalReference localReference,
        List<Object> arguments,
      ) {
        return (localReference as $ClassTemplate).methodTemplate(arguments[0]);
      },
    },
  };

  final double Function(
    ReferencePairManager manager,
    String parameterTemplate,
  ) classTemplate$staticMethodTemplate;

  final $ClassTemplate Function(
    ReferencePairManager manager,
    int fieldTemplate,
  ) createClassTemplate;

  @override
  LocalReference create(
    ReferencePairManager manager,
    Type referenceType,
    List<Object> arguments,
  ) {
    return _creators[referenceType](this, manager, arguments);
  }

  @override
  Object invokeStaticMethod(
    ReferencePairManager referencePairManager,
    Type referenceType,
    String methodName,
    List<Object> arguments,
  ) {
    return _staticMethods[referenceType][methodName](
      this,
      referencePairManager,
      arguments,
    );
  }

  @override
  Object invokeMethod(
    ReferencePairManager referencePairManager,
    LocalReference localReference,
    String methodName,
    List<Object> arguments,
  ) {
    final _$LocalMethodHandler handler =
        _methods[localReference.referenceType][methodName];
    if (handler != null) return handler(localReference, arguments);

    // Based on inheritance.
    if (localReference is $ClassTemplate) {
      switch (methodName) {
        case 'methodTemplate':
          return localReference.methodTemplate(arguments[0]);
      }
    }

    throw ArgumentError.value(
      localReference,
      'localReference',
      'Unable to invoke method `$methodName` on',
    );
  }
}

// MethodChannelRemoteHandler
class $RemoteHandler extends MethodChannelRemoteHandler {
  static final Map<Type, _$CreationArgumentsHandler> _creationArguments =
      <Type, _$CreationArgumentsHandler>{
    $ClassTemplate: (LocalReference localReference) {
      return <Object>[(localReference as $ClassTemplate).fieldTemplate];
    },
  };

  $RemoteHandler(String channelName) : super(channelName);

  @override
  List<Object> getCreationArguments(LocalReference localReference) {
    return _creationArguments[localReference.referenceType](localReference);
  }
}''';

final ArgParser parser = ArgParser()
  ..addOption('package-root', defaultsTo: '.')
  ..addOption('dart-out')
  ..addFlag('help');

void main(List<String> arguments) async {
  final ArgResults results = parser.parse(arguments);
  if (results['help']) {
    print(parser.usage);
    exit(64);
  }
  final options = ReferenceGeneratorOptions.parse(results);

  final Process process = await Process.start(
    'flutter',
    ['pub', 'run', 'build_runner', 'build'],
    workingDirectory: options.packageRoot.path,
  );

  process.stdout.transform(utf8.decoder).listen((String data) => print(data));
  process.stderr.transform(utf8.decoder).listen((String data) => print(data));
  await process.exitCode;

  final File astInputFile = File(path.setExtension(
    path.withoutExtension(options.inputFile.path),
    '.reference_ast',
  ));

  // TODO: make sure astInputFile exists

  final libraryNode = LibraryNode.fromJson(
    jsonDecode(
      astInputFile.readAsStringSync(),
    ),
  );

  // final HttpClientRequest request = await HttpClient().getUrl(Uri.parse(
  //     'https://raw.githubusercontent.com/bparrishMines/penguin/reference_generator/reference/lib/src/template/src/template.g.dart'));
  // await request.done;
  // final HttpClientResponse response = await request.close();
  //
  // final StringBuffer buffer = StringBuffer()
  //   ..writeAll(await response.transform(utf8.decoder).toList());
  //
  //final String dartTemplate = buffer.toString();

  //final String aClass = DartTemplateLibrary.aClass.stringMatch(darty);
  final String Function(ReferenceType type) getTrueTypeName =
      (ReferenceType type) {
    if (type.codeGeneratedClass) return '\$${type.name}';
    return type.name;
  };
  options?.dartOut?.writeAsStringSync(
    darty.replaceAll(
      DartTemplateLibrary.aClass,
      libraryNode.classes
          .map<String>(
            (ClassNode classNode) => DartTemplateLibrary.aClass
                .stringMatch(darty)
                .replaceAll(DartTemplateClass.name, classNode.name)
                .replaceAll(
                  DartTemplateClass.aField,
                  classNode.fields
                      .map<String>(
                        (FieldNode fieldNode) => DartTemplateClass.aField
                            .replaceAll(DartTemplateField.name, fieldNode.name)
                            .replaceAll(DartTemplateField.type,
                                getTrueTypeName(fieldNode.type)),
                      )
                      .join('\n'),
                )
                .replaceAll(
                  DartTemplateClass.aMethod,
                  classNode.methods
                      .map<String>(
                        (MethodNode methodNode) => DartTemplateClass.aMethod
                            .replaceAll(
                              DartTemplateMethod.returnType,
                              getTrueTypeName(methodNode.returnType),
                            )
                            .replaceAll(
                              DartTemplateMethod.name,
                              methodNode.name,
                            )
                            .replaceAll(
                                DartTemplateMethod.aParameter,
                                methodNode.parameters
                                    .map<String>(
                                      (ParameterNode parameterNode) =>
                                          DartTemplateMethod.aParameter
                                              .replaceAll(
                                                DartTemplateParameter.type,
                                                getTrueTypeName(
                                                  parameterNode.type,
                                                ),
                                              )
                                              .replaceAll(
                                                DartTemplateParameter.name,
                                                parameterNode.name,
                                              ),
                                    )
                                    .join(', ')),
                      )
                      .join('\n\n'),
                ),
          )
          .join('\n\n'),
    ),
  );
}

class ReferenceGeneratorOptions {
  ReferenceGeneratorOptions._({this.packageRoot, this.dartOut, this.inputFile});

  factory ReferenceGeneratorOptions.parse(ArgResults results) {
    if (results.rest.isEmpty || results.rest.length > 1) {
      throw ArgumentError('Please provide only one input file.');
    }

    final inputFile = File(results.rest.first);
    if (!inputFile.existsSync()) {
      throw ArgumentError('Please provide an existing input file.');
    } else if (path.extension(inputFile.path) != '.dart') {
      throw ArgumentError('Please provide an input file ending in `.dart`.');
    }

    return ReferenceGeneratorOptions._(
      packageRoot: File(results['package-root']),
      dartOut: results.wasParsed('dart-out') ? File(results['dart-out']) : null,
      inputFile: File(results.rest.first),
    );
  }

  final File packageRoot;
  final File dartOut;
  final File inputFile;
}

class DartTemplateLibrary {
  static final RegExp aClass = RegExp(
    r'abstract\sclass\s\$ClassTemplate.+?Type\sget\sreferenceType\s=>\s\$ClassTemplate;.+?}',
    multiLine: true,
    dotAll: true,
  );
}

class DartTemplateClass {
  static final RegExp name = RegExp(
    r'ClassTemplate(?=.+?implements|;.*?\})',
    multiLine: true,
    dotAll: true,
  );

  static final String aField = 'int get fieldTemplate;';

  static final String aMethod =
      r'Future<String> methodTemplate(String parameterTemplate);';
}

class DartTemplateField {
  static final RegExp type = RegExp(
    r'^int',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp name = RegExp(
    r'fieldTemplate(?=;)',
    multiLine: true,
    dotAll: true,
  );
}

class DartTemplateMethod {
  static final RegExp returnType = RegExp(
    r'^Future<String>',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp name = RegExp(
    'methodTemplate(?=\\($aParameter\\);)',
    multiLine: true,
    dotAll: true,
  );

  static final String aParameter = 'String parameterTemplate';
}

class DartTemplateParameter {
  static final RegExp type = RegExp(
    r'^String',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp name = RegExp(
    r'parameterTemplate$',
    multiLine: true,
    dotAll: true,
  );
}
