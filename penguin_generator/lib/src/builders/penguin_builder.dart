import 'package:build/build.dart';

import 'package:path/path.dart' as path;

import '../info.dart';
import '../templates/templates.dart';

class PenguinBuilderBuildStep {
  PenguinBuilderBuildStep(this._buildStep) {}

  static final String _fileHeader = r'''
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// PenguinGenerator
// **************************************************************************
''';

  final BuildStep _buildStep;

  AssetId get inputId => _buildStep.inputId;

  Future<void> writeToAsset(AssetId assetId, String contents) {
    return _buildStep.writeAsString(assetId, contents);
  }

  Future<void> writeToLib(String filename, String content) {
    return _buildStep.writeAsString(
      AssetId(_buildStep.inputId.package, path.join('lib', filename)),
      _fileHeader + content,
    );
  }
}

abstract class PenguinBuilder {
  Iterable<String> get filenames;
  // Platform annotation for the builder (e.g. AndroidPlatform)
  Iterable<Type> get platformTypes;

  Future<void> build(
    List<ClassInfo> libraryClasses,
    List<ClassInfo> importedClasses,
    PenguinBuilderBuildStep buildStep,
  );

  // For passing methods over MethodChannel
  MethodChannelType getChannelType(TypeInfo info) {
    if (info.isMap ||
        info.isList &&
            info.typeArguments.every(
              (_) => getChannelType(_) == MethodChannelType.supported,
            )) {
      return MethodChannelType.supported;
    } else if (info.isStruct) {
      return MethodChannelType.struct;
    } else if (info.isNativeInt32 || info.isNativeInt64) {
      // We must check for primitive before supported because a type will be both.
      return MethodChannelType.primitive;
    } else if (info.isDynamic ||
        info.isObject ||
        info.isString ||
        info.isNum ||
        info.isInt ||
        info.isDouble ||
        info.isBool) {
      return MethodChannelType.supported;
    } else if (info.isVoid) {
      return MethodChannelType.$void;
    } else if (info.isWrapper) {
      return MethodChannelType.wrapper;
    } else if (info.isTypeParameter) {
      return MethodChannelType.typeParameter;
    }

    throw ArgumentError.value(
      info.toString(),
      'info',
      'Can\'t find $MethodChannelType for info',
    );
  }

  String removeBounds(String value) {
    final RegExp genericBrackets = RegExp('<.*>');
    return value.replaceAll(genericBrackets, '');
  }
}
