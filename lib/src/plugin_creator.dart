import 'package:code_builder/code_builder.dart' as cb;
import 'package:pub_semver/pub_semver.dart';
import 'package:pubspec_parse/pubspec_parse.dart';

import 'plugin.dart';
import 'references.dart';
import 'utils.dart';
import 'writers.dart';

class ClassDetails {
  ClassDetails(this.hasConstructor, this.isReferenced, this.file)
      : assert(hasConstructor != null),
        assert(isReferenced != null),
        assert(file != null);

  final bool hasConstructor;

  /// Referenced by another class method or
  final bool isReferenced;

  /// File of the class
  final String file;
}

class PluginCreator {
  PluginCreator(this.plugin) : assert(plugin != null) {
    initialize();
  }

  final Plugin plugin;

  void initialize() {
    final Set<String> allClassNames = plugin.classes
        .map<String>(
          (Class theClass) => theClass.name,
        )
        .toSet();

    final Set<String> referencedClasses = <String>{};
    for (Class theClass in plugin.classes) {
      for (Method method in theClass.methods) {
        if ((method.isStatic || theClass.name != method.returns) &&
            allClassNames.contains(method.returns)) {
          referencedClasses.add(method.returns);
        }
      }

      for (Field field in theClass.fields) {
        if ((field.isStatic || theClass.name != field.type) &&
            allClassNames.contains(field.type)) {
          referencedClasses.add(field.type);
        }
      }
    }

    for (Class theClass in plugin.classes) {
      theClass.details = ClassDetails(
        theClass.constructors.isNotEmpty,
        referencedClasses.contains(theClass.name),
        '${camelCaseToSnakeCase(theClass.name)}.dart',
      );
    }
  }

  static final cb.DartEmitter _emitter = cb.DartEmitter(cb.Allocator());

  cb.Library get _channelClass => cb.Library((cb.LibraryBuilder builder) =>
      builder.body.add(cb.Class((cb.ClassBuilder builder) {
        builder.name = 'Channel';
        builder.fields.addAll([
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
          cb.Field((cb.FieldBuilder builder) {
            builder.name = 'nextHandle';
            builder.static = true;
            builder.type = cb.refer('int');
            builder.assignment = cb.Code('0');
            builder.annotations.add(References.visibleForTesting);
          })
        ]);
      })));

  Pubspec get _pubspec => Pubspec(
        plugin.name,
        description: 'A new flutter plugin project.',
        version: Version.parse('0.0.1'),
        homepage: '',
        environment: <String, VersionConstraint>{
          'sdk': VersionConstraint.compatibleWith(
            Version.parse('2.1.0'),
          ),
          'flutter': VersionConstraint.compatibleWith(
            Version.parse('1.0.0'),
          ),
        },
        dependencies: <String, Dependency>{
          'flutter': SdkDependency('flutter'),
          'json_annotation': HostedDependency(
            version: VersionConstraint.compatibleWith(
              Version.parse('2.4.0'),
            ),
          ),
        },
        devDependencies: <String, Dependency>{
          'flutter_test': SdkDependency('flutter'),
          'json_serializable': HostedDependency(
            version: VersionConstraint.compatibleWith(
              Version.parse('3.0.0'),
            ),
          ),
          'build_runner': HostedDependency(
            version: VersionConstraint.compatibleWith(
              Version.parse('1.0.0'),
            ),
          ),
        },
        flutter: <String, dynamic>{
          'plugin': <String, dynamic>{
            'androidPackage': '${plugin.organization}.${plugin.name}',
            'pluginClass': '${snakeCaseToCamelCase(plugin.name)}Plugin',
          }
        },
      );

  String _channelAsString() => '${_channelClass.accept(_emitter)}';

  Map<String, String> pluginAsStrings() {
    final Map<String, String> classes = <String, String>{};

    classes['channel.dart'] = _channelAsString();

    final ClassWriter writer = ClassWriter(plugin);
    for (Class theClass in plugin.classes) {
      final cb.Library codeClass = writer.write(theClass);
      classes[theClass.details.file] = '${codeClass.accept(_emitter)}';
    }

    return classes;
  }
}
