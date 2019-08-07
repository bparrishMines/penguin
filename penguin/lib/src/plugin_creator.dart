import 'package:code_builder/code_builder.dart' as cb;

import 'plugin.dart';
import 'references.dart';
import 'string_utils.dart';
import 'writers.dart';

class ClassDetails {
  ClassDetails({
    this.hasConstructor,
    this.isReferenced,
    this.file,
    this.hasInitializedFields,
    this.isInitializedField,
  })  : assert(hasConstructor != null),
        assert(isReferenced != null),
        assert(file != null),
        assert(hasInitializedFields != null);

  final bool hasConstructor;

  /// Referenced by a method or field
  final bool isReferenced;

  /// File of the class
  final String file;

  final bool hasInitializedFields;

  final bool isInitializedField;
}

class PluginCreator {
  PluginCreator(this.plugin) : assert(plugin != null) {
    setupClassDetails();
  }

  final Plugin plugin;

  void setupClassDetails() {
    final Set<String> allClassNames = plugin.classes
        .map<String>(
          (Class theClass) => theClass.name,
        )
        .toSet();

    final Set<String> referencedClasses = <String>{};
    final Set<String> initializedClasses = <String>{};
    for (Class theClass in plugin.classes) {
      for (dynamic fieldOrMethod in theClass.fieldsAndMethods) {
        final String returnType = Plugin.returnType(fieldOrMethod);
        if (!allClassNames.contains(returnType)) continue;

        if (!Plugin.mutable(fieldOrMethod)) {
          referencedClasses.add(returnType);
        }

        if (Plugin.initialized(fieldOrMethod)) {
          initializedClasses.add(returnType);
        }
      }
    }

    for (Class theClass in plugin.classes) {
      theClass.details = ClassDetails(
        hasConstructor: theClass.constructors.isNotEmpty,
        isReferenced: referencedClasses.contains(theClass.name),
        file: '${StringUtils.camelCaseToSnakeCase(theClass.name)}.dart',
        hasInitializedFields: theClass.fields.any(
          (Field field) => field.initialized,
        ),
        isInitializedField: initializedClasses.contains(theClass.name),
      );
    }
  }

  cb.Library get _channelClass => cb.Library((cb.LibraryBuilder builder) =>
      builder.body.add(cb.Class((cb.ClassBuilder builder) {
        builder
          ..name = 'Channel'
          ..fields.add(
            cb.Field((cb.FieldBuilder builder) {
              builder.name = 'channel';
              builder.modifier = cb.FieldModifier.constant;
              builder.static = true;
              builder.type = References.methodChannel;
              builder.assignment = References.methodChannel.call(
                <cb.Expression>[
                  cb.literalString('${plugin.organization}/${plugin.name}'),
                ],
              ).code;
              builder.annotations.add(References.visibleForTesting);
            }),
          )
          ..methods.add(cb.Method((cb.MethodBuilder builder) {
            builder
              ..name = 'nextHandle'
              ..static = true
              ..returns = cb.refer('String')
              ..annotations.add(References.visibleForTesting)
              ..body = cb
                  .literalString('dart\${DateTime.now().toIso8601String()}')
                  .code;
          }));
      })));

  String _channelAsString() => '${_channelClass.accept(_createEmitter())}';

  Map<String, String> pluginAsStrings() {
    final Map<String, String> classes = <String, String>{};

    classes['channel.dart'] = _channelAsString();

    final ClassWriter writer = ClassWriter(plugin);
    for (Class theClass in plugin.classes) {
      final cb.Library codeClass = writer.write(theClass);
      classes[theClass.details.file] = '${codeClass.accept(_createEmitter())}';
    }

    return classes;
  }

  cb.DartEmitter _createEmitter() => cb.DartEmitter(cb.Allocator());
}
