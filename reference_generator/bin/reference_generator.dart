import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as path;
import 'package:reference_generator/src/ast.dart';

import 'dart_generator.dart' show generateDart;

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
    String parameterTemplate
  ) {
    return referencePairManager.invokeRemoteStaticMethod(
      $ClassTemplate,
      'staticMethodTemplate',
      <Object>[parameterTemplate],
    );
  }

  Future<Object> $methodTemplate(
    $ReferencePairManager referencePairManager,
    String parameterTemplate
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
    this.classTemplate$staticMethodTemplate
  });

  static final Map<Type, _$LocalCreatorHandler> _creators =
      <Type, _$LocalCreatorHandler>{
    $ClassTemplate: (
      $LocalHandler localHandler,
      ReferencePairManager manager,
      List<Object> arguments,
    ) {
      return localHandler.createClassTemplate(manager, arguments[0]);
    }
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
      }
    }
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
  ..addFlag('help')
  ..addFlag('build', abbr: 'b', defaultsTo: true);

void main(List<String> arguments) async {
  final ArgResults results = parser.parse(arguments);
  if (results['help']) {
    print(parser.usage);
    exit(64);
  }
  final options = ReferenceGeneratorOptions.parse(results);

  if (options.build) {
    final Process process = await Process.start(
      'flutter',
      ['pub', 'run', 'build_runner', 'build'],
      workingDirectory: options.packageRoot.path,
    );

    process.stdout.transform(utf8.decoder).listen((String data) => print(data));
    process.stderr.transform(utf8.decoder).listen((String data) => print(data));
    await process.exitCode;
  }

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

  options?.dartOut?.writeAsStringSync(generateDart(darty, libraryNode));
}

class ReferenceGeneratorOptions {
  ReferenceGeneratorOptions._({
    this.packageRoot,
    this.dartOut,
    this.inputFile,
    this.build,
  });

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
      build: results['build'],
    );
  }

  final File packageRoot;
  final File dartOut;
  final File inputFile;
  final bool build;
}
