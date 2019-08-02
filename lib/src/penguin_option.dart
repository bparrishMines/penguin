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

  static PenguinOption directory = PenguinOption._(
    name: 'directory',
    abbr: 'd',
    help: 'Output path for plugin.',
    defaultsTo: './',
    valueHelp: 'path',
    isFlag: false,
  );

  static PenguinOption pluginYaml = PenguinOption._(
    name: 'plugin-yaml',
    abbr: 'p',
    help: 'Directory of the of plugin.yaml.',
    defaultsTo: './',
    valueHelp: 'path',
    isFlag: false,
  );

  static List<PenguinOption> values = <PenguinOption>[
    usage,
    directory,
    pluginYaml,
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
