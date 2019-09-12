import 'package:build/build.dart';
import 'package:penguin_generator/src/builders/platform_builder.dart';
import 'package:penguin_generator/src/central_builder.dart';
import 'package:source_gen/builder.dart';

import 'src/builders/android_builder.dart';
import 'src/builders/dart_builder.dart';

//List<AggregateBuilder> aggregateBuilders = <AggregateBuilder>[
//  AndroidChannelBuilder()
//];
//Builder readBuilder(BuilderOptions options) => ReadBuilder(aggregateBuilders);
//Builder writeBuilder(BuilderOptions options) => WriteBuilder(aggregateBuilders);
//
//Builder dartBuilder(BuilderOptions options) => DartBuilder();
//
//Builder androidBuilder(BuilderOptions options) => AndroidBuilder();
//PostProcessBuilder androidMoveBuilder(BuilderOptions options) =>
//    AndroidMoveBuilder();

Builder readBuilder(BuilderOptions options) => ReadInfoBuilder();
Builder writeBuilder(BuilderOptions options) =>
    WriteBuilder(<PlatformBuilder>[AndroidBuilder()]);
//PostProcessBuilder androidBuilder(BuilderOptions options) => AndroidBuilder();
