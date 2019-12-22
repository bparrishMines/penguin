import 'package:build/build.dart';
import 'package:penguin_generator/src/builders/ios_builder.dart';

import 'src/builders/android_builder.dart';
import 'src/builders/dart_builders.dart';
import 'src/builders/platform_builder.dart';

Builder readBuilder(BuilderOptions options) => ReadInfoBuilder();

Builder platformWriteBuilder(BuilderOptions options) =>
    PlatformWriteBuilder(<PenguinBuilder>[AndroidBuilder(), IosBuilder()]);

Builder dartWriteBuilder(BuilderOptions options) =>
    DartWriteBuilder(<PenguinBuilder>[DartMethodChannelBuilder()]);
