import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as path;
import 'package:reference_generator/src/ast.dart';

import 'dart_generator.dart' show generateDart;
import 'java_generator.dart' show generateJava;

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
      }
    }
  };

  final double Function(
    ReferencePairManager manager,
    String parameterTemplate
  ) classTemplate$staticMethodTemplate;

  final $ClassTemplate Function(
    ReferencePairManager manager,
    int fieldTemplate
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
    }
  };

  $RemoteHandler(String channelName) : super(channelName);

  @override
  List<Object> getCreationArguments(LocalReference localReference) {
    return _creationArguments[localReference.referenceType](localReference);
  }
}''';

final String javay = r'''package github.penguin.reference.templates;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import github.penguin.reference.async.Completable;
import github.penguin.reference.method_channel.MethodChannelReferencePairManager;
import github.penguin.reference.method_channel.MethodChannelRemoteHandler;
import github.penguin.reference.method_channel.ReferenceMessageCodec;
import github.penguin.reference.reference.LocalReference;
import github.penguin.reference.reference.ReferencePairManager;
import github.penguin.reference.reference.ReferencePairManager.LocalReferenceCommunicationHandler;
import io.flutter.plugin.common.BinaryMessenger;

@SuppressWarnings({"ArraysAsListWithZeroOrOneArgument", "unused"})
class LibraryTemplate {
  private static abstract class $LocalCreatorHandler {
    abstract LocalReference call($LocalHandler localHandler,
                                 ReferencePairManager referencePairManager,
                                 List<Object> arguments) throws Exception;
  }

  private static abstract class $LocalStaticMethodHandler {
    abstract Object call($LocalHandler localHandler,
                         ReferencePairManager referencePairManager,
                         List<Object> arguments) throws Exception;
  }

  private static abstract class $LocalMethodHandler {
    abstract Object call(LocalReference localReference,
                         List<Object> arguments) throws Exception;
  }

  private static abstract class $CreationArgumentsHandler {
    abstract List<Object> call(LocalReference localReference);
  }

  static abstract class $ClassTemplate implements LocalReference {
    abstract Integer getFieldTemplate();

    abstract Object methodTemplate(String parameterTemplate) throws Exception;

    protected static Completable<Object> $staticMethodTemplate($ReferencePairManager manager,
                                                        String parameterTemplate) {
      return manager.invokeRemoteStaticMethod($ClassTemplate.class,
          "staticMethodTemplate",
          Arrays.asList((Object) parameterTemplate)
      );
    }

    protected Completable<Object> $methodTemplate($ReferencePairManager manager,
                                                  String parameterTemplate) {
      if (manager.getPairedRemoteReference(this) == null) {
        return manager.invokeRemoteMethodOnUnpairedReference(this,
            "methodTemplate",
            Arrays.asList((Object) parameterTemplate));
      }

      return manager.invokeRemoteMethod(manager.getPairedRemoteReference(this),
          "methodTemplate",
          Arrays.asList((Object) parameterTemplate));
    }

    @Override
    public Class<? extends LocalReference> getReferenceClass() {
      return $ClassTemplate.class;
    }
  }

  static class $ClassTemplateCreationArgs {
    Integer fieldTemplate;
  }

  static abstract class $ReferencePairManager extends MethodChannelReferencePairManager {
    $ReferencePairManager(final BinaryMessenger binaryMessenger, final String channelName) {
      this(binaryMessenger, channelName, new ReferenceMessageCodec());
    }

    @SuppressWarnings("ArraysAsListWithZeroOrOneArgument")
    $ReferencePairManager(
        final BinaryMessenger binaryMessenger,
        final String channelName,
        final ReferenceMessageCodec messageCodec) {
      super(Arrays.<Class<? extends LocalReference>>asList($ClassTemplate.class),
          binaryMessenger,
          channelName,
          channelName,
          messageCodec
      );
    }

    @Override
    public abstract $LocalHandler getLocalHandler();

    @Override
    public MethodChannelRemoteHandler getRemoteHandler() {
      return new $RemoteHandler(binaryMessenger, channelName);
    }
  }

  static abstract class $LocalHandler implements LocalReferenceCommunicationHandler {
    static private final Map<Class<? extends LocalReference>, $LocalCreatorHandler> creators =
        new HashMap<Class<? extends LocalReference>, $LocalCreatorHandler>() {{
          put($ClassTemplate.class, new $LocalCreatorHandler() {
            @Override
            LocalReference call($LocalHandler localHandler, ReferencePairManager referencePairManager, List<Object> arguments) throws Exception {
              final $ClassTemplateCreationArgs args = new $ClassTemplateCreationArgs();
              args.fieldTemplate = (Integer) arguments.get(0);
              return localHandler.createClassTemplate(referencePairManager, args);
            }
          });
        }};

    static private final Map<Class<? extends LocalReference>, Map<String, $LocalStaticMethodHandler>> staticMethods =
        new HashMap<Class<? extends LocalReference>, Map<String, $LocalStaticMethodHandler>>() {{
          put($ClassTemplate.class, new HashMap<String, $LocalStaticMethodHandler>(){{
            put("staticMethodTemplate", new $LocalStaticMethodHandler() {
              @Override
              Object call($LocalHandler localHandler, ReferencePairManager referencePairManager, List<Object> arguments) throws Exception {
                return localHandler.classTemplate$staticMethodTemplate(referencePairManager, (String) arguments.get(0));
              }
            });
          }});
        }};

    static private final Map<Class<? extends LocalReference>, Map<String, $LocalMethodHandler>> methods =
        new HashMap<Class<? extends LocalReference>, Map<String, $LocalMethodHandler>>(){{
          put($ClassTemplate.class, new HashMap<String, $LocalMethodHandler>(){{
            put("methodTemplate", new $LocalMethodHandler() {
              @Override
              Object call(LocalReference localReference, List<Object> arguments) throws Exception {
                return (($ClassTemplate) localReference).methodTemplate((String) arguments.get(0));
              }
            });
          }});
        }};

    public abstract $ClassTemplate createClassTemplate(
        ReferencePairManager referencePairManager,
        $ClassTemplateCreationArgs args)
        throws Exception;

    public abstract Double classTemplate$staticMethodTemplate(
        ReferencePairManager referencePairManager,
        String parameterTemplate) throws Exception;

    @SuppressWarnings("ConstantConditions")
    @Override
    public LocalReference create(
        ReferencePairManager referencePairManager,
        Class<? extends LocalReference> referenceClass,
        List<Object> arguments)
        throws Exception {
      return creators.get(referenceClass).call(this, referencePairManager, arguments);
    }

    @SuppressWarnings("ConstantConditions")
    @Override
    public Object invokeStaticMethod(ReferencePairManager referencePairManager, Class<? extends LocalReference> referenceClass, String methodName, List<Object> arguments) throws Exception {
      return staticMethods.get(referenceClass).get(methodName).call(this, referencePairManager, arguments);
    }

    @SuppressWarnings({"ConstantConditions", "SwitchStatementWithTooFewBranches"})
    @Override
    public Object invokeMethod(
        ReferencePairManager referencePairManager,
        LocalReference localReference,
        String methodName,
        List<Object> arguments) throws Exception {
      final $LocalMethodHandler handler = methods.get(localReference.getReferenceClass()).get(methodName);
      if (handler != null) return handler.call(localReference, arguments);

      // Based on inheritance.
      if (localReference instanceof $ClassTemplate) {
        switch(methodName) {
          case "methodTemplate":
            return (($ClassTemplate) localReference).methodTemplate((String) arguments.get(0));
        }
      }

      final String message = String.format("Unable to invoke method `$methodName` on (localReference): %s", localReference.toString());
      throw new IllegalArgumentException(message);
    }

    @SuppressWarnings("RedundantThrows")
    @Override
    public void dispose(ReferencePairManager referencePairManager, LocalReference localReference) throws Exception {
      // Do nothing.
    }
  }

  static class $RemoteHandler extends MethodChannelRemoteHandler {
    private static final Map<Class<? extends LocalReference>, $CreationArgumentsHandler> creationArguments =
        new HashMap<Class<? extends LocalReference>, $CreationArgumentsHandler>() {{
          put($ClassTemplate.class, new $CreationArgumentsHandler() {
            @Override
            List<Object> call(LocalReference localReference) {
              final $ClassTemplate value = ($ClassTemplate) localReference;
              return Arrays.asList((Object) value.getFieldTemplate());
            }
          });
        }};

    $RemoteHandler(BinaryMessenger binaryMessenger, String channelName) {
      super(binaryMessenger, channelName);
    }

    @SuppressWarnings("ConstantConditions")
    @Override
    public List<Object> getCreationArguments(LocalReference localReference) {
      return creationArguments.get(localReference.getReferenceClass()).call(localReference);
    }
  }
}

''';

final ArgParser parser = ArgParser()
  ..addOption('package-root', defaultsTo: '.')
  ..addOption('dart-out')
  ..addOption('java-out')
  ..addOption('java-package')
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

  if (options.dartOut != null) {
    final HttpClientRequest request = await HttpClient().getUrl(
      Uri.parse(
        'https://raw.githubusercontent.com/bparrishMines/penguin/reference_generator/reference/lib/src/template/src/template.g.dart',
      ),
    );
    final HttpClientResponse response = await request.close();

    final StringBuffer buffer = StringBuffer()
      ..writeAll(await response.transform(utf8.decoder).toList());

    final String dartTemplate = buffer.toString();

    options.dartOut.writeAsStringSync(generateDart(dartTemplate, libraryNode));
  }

  if (options.javaOut != null) {
    // final HttpClientRequest request = await HttpClient().getUrl(
    //   Uri.parse(
    //     'https://raw.githubusercontent.com/bparrishMines/penguin/reference_generator/reference/android/src/main/java/github/penguin/reference/templates/LibraryTemplate.java',
    //   ),
    // );
    // final HttpClientResponse response = await request.close();
    //
    // final StringBuffer buffer = StringBuffer()
    //   ..writeAll(await response.transform(utf8.decoder).toList());
    //
    // final String dartTemplate = buffer.toString();

    options.javaOut.writeAsStringSync(
      generateJava(
        template: javay,
        libraryNode: libraryNode,
        libraryName: path.basenameWithoutExtension(options.javaOut.path),
        package: options.javaPackage,
      ),
    );
  }
}

class ReferenceGeneratorOptions {
  ReferenceGeneratorOptions._({
    this.packageRoot,
    this.dartOut,
    this.inputFile,
    this.javaOut,
    this.build,
    this.javaPackage,
  }) : assert(
          javaOut == null || javaPackage != null,
          'Please provide a `--java-package` when setting `--java-out`.',
        );

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

    final ReferenceGeneratorOptions options = ReferenceGeneratorOptions._(
      packageRoot: File(results['package-root']),
      dartOut: results.wasParsed('dart-out') ? File(results['dart-out']) : null,
      inputFile: File(results.rest.first),
      build: results['build'],
      javaOut: results.wasParsed('java-out') ? File(results['java-out']) : null,
      javaPackage: results['java-package'],
    );

    if(options.javaOut != null && options.javaPackage == null) {
      throw ArgumentError('Please provide a `--java-package` when setting `--java-out`.',);
    }

    return options;
  }

  final File packageRoot;
  final File dartOut;
  final File inputFile;
  final bool build;
  final File javaOut;
  final String javaPackage;
}
