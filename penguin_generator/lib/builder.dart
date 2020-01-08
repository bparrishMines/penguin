import 'package:build/build.dart';

import 'src/builders/android_builder.dart';
import 'src/builders/code_builder.dart';
import 'src/builders/dart_builders.dart';
import 'src/builders/info_builder.dart';
import 'src/builders/ios_builder.dart';
import 'src/builders/penguin_builder.dart';

Builder infoBuilder(BuilderOptions options) => InfoBuilder();

Builder platformBuilder(BuilderOptions options) =>
    PlatformBuilder(<PenguinBuilder>[AndroidBuilder(), IosBuilder()]);

Builder dartBuilder(BuilderOptions options) =>
    DartBuilder(<PenguinBuilder>[DartMethodChannelBuilder()]);
