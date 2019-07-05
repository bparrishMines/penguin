import 'package:args/args.dart';

class PenguinOption implements Option {
  const PenguinOption._({
    this.abbr,
    this.allowed,
    this.allowedHelp,
    this.callback,
    this.defaultsTo,
    this.help,
    this.hide = false,
    this.isFlag,
    this.isMultiple,
    this.isSingle,
    this.name,
    this.negatable = true,
    this.splitCommas = true,
    this.type,
    this.valueHelp,
  })  : assert(name != null),
        assert(isFlag != null);

  static PenguinOption usage = PenguinOption._(
    name: 'help',
    abbr: 'h',
    help: 'Print usage.',
    negatable: false,
    isFlag: true,
  );

  static PenguinOption projectName = PenguinOption._(
    name: 'project-name',
    abbr: 'n',
    valueHelp: 'name',
    help:
        'The project name for this new Flutter project. This must be a valid dart package name.',
    defaultsTo: 'new_plugin',
    isFlag: false,
  );

  static PenguinOption directory = PenguinOption._(
    name: 'directory',
    abbr: 'd',
    help: 'Output path for plugin.',
    defaultsTo: './',
    valueHelp: 'path',
    isFlag: false,
  );

  static PenguinOption android = PenguinOption._(
    name: 'android',
    abbr: 'a',
    isFlag: false,
    help: "Directories containing android '.java' files.",
    isMultiple: true,
    splitCommas: true,
  );

  static PenguinOption recursive = PenguinOption._(
    name: 'recursive',
    abbr: 'r',
    isFlag: true,
    help: 'Search within directories when looking for native library files.',
    negatable: true,
  );

  static PenguinOption org = PenguinOption._(
    name: 'org',
    abbr: 'o',
    isFlag: false,
    help:
        'The organization responsible for your new Flutter project, in reverse '
        'domain name notation. This string is used in Java package names and '
        'as prefix in the iOS bundle identifier.',
    defaultsTo: 'com.example',
  );

  static List<PenguinOption> values = <PenguinOption>[
    usage,
    projectName,
    directory,
    android,
    recursive,
    org,
  ];

  @override
  final String abbr;

  @override
  @deprecated
  final String abbreviation = null;

  @override
  final List<String> allowed;

  @override
  final Map<String, String> allowedHelp;

  @override
  final Function callback;

  @override
  @deprecated
  final dynamic defaultValue = null;

  @override
  final dynamic defaultsTo;

  @override
  void getOrDefault(dynamic value) => value ?? defaultsTo;

  @override
  final String help;

  @override
  final bool hide;

  @override
  final bool isFlag;

  @override
  final bool isMultiple;

  @override
  final bool isSingle;

  @override
  final String name;

  @override
  final bool negatable;

  @override
  final bool splitCommas;

  @override
  final OptionType type;

  @override
  final String valueHelp;
}
