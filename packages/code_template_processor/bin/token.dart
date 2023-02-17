import 'dart:collection';
import 'dart:math';

import 'package:recase/recase.dart';

import 'processor_utils.dart';
import 'code_template_processor_options.dart';

typedef RunProcessorCallback = String Function({
  required Queue<String> templateQueue,
  required Queue<StartToken> tokenStack,
  required StringBuffer resultBuffer,
  required Map<String, dynamic> data,
  required TemplateProcessorOptions options,
  required Map<String, String> copies,
});

abstract class Token {}

abstract class StartToken extends Token {
  void onTokenStart({
    required Queue<String> templateQueue,
    required Queue<StartToken> tokenStack,
    required StringBuffer resultBuffer,
    required Map<String, dynamic> data,
    required TemplateProcessorOptions options,
    required Map<String, String> copies,
    required RunProcessorCallback onRunProcessor,
  }) {
    throw UnimplementedError();
  }

  String onTokenEnd({
    required Queue<String> templateQueue,
    required Queue<StartToken> tokenStack,
    required StringBuffer resultBuffer,
    required Map<String, dynamic> data,
    required TemplateProcessorOptions options,
    required Map<String, String> copies,
    required RunProcessorCallback onRunGenerator,
  }) {
    throw UnimplementedError();
  }
}

class IterateToken extends StartToken {
  IterateToken({
    required this.dataInstanceName,
    required this.identifier,
    required this.join,
    this.start = 0,
    this.end,
  }) {
    if (end != null && end! < start) {
      throw ArgumentError('Start must be less than or equal to end.');
    }
  }

  final String dataInstanceName;
  final String identifier;
  final String join;
  final int start;
  final int? end;
  late final Queue<Map<dynamic, dynamic>> dataQueue;

  @override
  void onTokenStart({
    required Queue<String> templateQueue,
    required Queue<StartToken> tokenStack,
    required StringBuffer resultBuffer,
    required Map<String, dynamic> data,
    required TemplateProcessorOptions options,
    required Map<String, String> copies,
    required RunProcessorCallback onRunProcessor,
  }) {
    final List<dynamic>? dataList = retrieveValueForIdentifier(
        tokenStack: tokenStack,
        identifier: identifier,
        data: data) as List<dynamic>?;
    final List<String> outputs = <String>[];

    if (dataList == null) {
      print(data);
      print(dataInstanceName);
      print(resultBuffer.toString());
      throw StateError('Failed to find data!');
    }

    // If start is greater than length, change start = length.
    // If end is greater than length, change end = length.
    dataQueue = Queue<Map<dynamic, dynamic>>.of(
      dataList
          .sublist(
            min(start, dataList.length),
            end != null ? min(end!, dataList.length) : dataList.length,
          )
          .cast(),
    );

    while (dataQueue.isNotEmpty) {
      outputs.add(onRunProcessor(
        templateQueue: Queue<String>.from(templateQueue),
        tokenStack: Queue<StartToken>.from(tokenStack),
        resultBuffer: StringBuffer(),
        data: dataQueue.first.cast<String, dynamic>(),
        options: options,
        copies: copies,
      ));
      dataQueue.removeFirst();
    }
    _flush(
      templateQueue,
      tokenOpener: options.tokenOpener,
      tokenCloser: options.tokenCloser,
      copies: copies,
    );
    tokenStack.removeLast();
    resultBuffer.write(outputs.join(join));
  }

  @override
  String onTokenEnd({
    required Queue<String> templateQueue,
    required Queue<StartToken> tokenStack,
    required StringBuffer resultBuffer,
    required Map<String, dynamic> data,
    required TemplateProcessorOptions options,
    required Map<String, String> copies,
    required RunProcessorCallback onRunGenerator,
  }) {
    return resultBuffer.toString();
  }
}

class ReplaceToken extends StartToken {
  ReplaceToken({this.what, required this.casing, required this.identifier}) {
    if (casing != null && !_validCasings.contains(casing)) {
      throw ArgumentError(_casingErrorMessage);
    }
  }

  static const Set<String> _validCasings = <String>{
    'pascal',
    'camel',
    'constant',
  };

  static final String _casingErrorMessage =
      'Casing must be one of `$_validCasings`.';

  final String? what;
  final String? casing;
  final String identifier;

  @override
  void onTokenStart({
    required Queue<String> templateQueue,
    required Queue<StartToken> tokenStack,
    required StringBuffer resultBuffer,
    required Map<String, dynamic> data,
    required TemplateProcessorOptions options,
    required Map<String, String> copies,
    required RunProcessorCallback onRunProcessor,
  }) {
    resultBuffer.write(onRunProcessor(
      templateQueue: templateQueue,
      tokenStack: tokenStack,
      resultBuffer: StringBuffer(),
      data: data,
      options: options,
      copies: copies,
    ));
  }

  @override
  String onTokenEnd({
    required Queue<String> templateQueue,
    required Queue<StartToken> tokenStack,
    required StringBuffer resultBuffer,
    required Map<String, dynamic> data,
    required TemplateProcessorOptions options,
    required Map<String, String> copies,
    required RunProcessorCallback onRunGenerator,
  }) {
    String replacement = retrieveValueForIdentifier(
      tokenStack: tokenStack,
      identifier: identifier,
      data: data,
    ).toString();

    if (casing != null) {
      final ReCase reCase = ReCase(replacement);
      switch (casing) {
        case 'pascal':
          replacement = reCase.pascalCase;
          break;
        case 'camel':
          replacement = reCase.camelCase;
          break;
        case 'constant':
          replacement = reCase.constantCase;
          break;
        default:
          throw ArgumentError(_casingErrorMessage);
      }
    }

    if (what == null) {
      return replacement;
    }

    return resultBuffer.toString().replaceAll(what!, replacement);
  }
}

class ConditionalToken extends StartToken {
  ConditionalToken({
    required this.identifier,
    required this.inverse,
    required this.equalTo,
  });

  final String identifier;
  final bool inverse;
  final String? equalTo;

  @override
  void onTokenStart({
    required Queue<String> templateQueue,
    required Queue<StartToken> tokenStack,
    required StringBuffer resultBuffer,
    required Map<String, dynamic> data,
    required TemplateProcessorOptions options,
    required Map<String, String> copies,
    required RunProcessorCallback onRunProcessor,
  }) {
    final Object? value = retrieveValueForIdentifier(
      tokenStack: tokenStack,
      identifier: identifier,
      data: data,
      throwOnMissing: false,
    );

    late bool condition;
    if (value == null) {
      condition = false;
    } else if (equalTo != null) {
      if (value is String) {
        condition = value == equalTo;
      } else {
        throw ArgumentError(
          'Cannot use `equalTo` with a conditional token that provides a `${value.runtimeType}` value with identifier.',
        );
      }
    } else if (value is bool) {
      condition = value;
    } else {
      condition = true;
    }
    if (inverse) condition = !condition;
    if (condition) {
      resultBuffer.write(onRunProcessor(
        templateQueue: templateQueue,
        tokenStack: tokenStack,
        resultBuffer: StringBuffer(),
        data: data,
        options: options,
        copies: copies,
      ));
    } else {
      tokenStack.removeLast();
      _flush(
        templateQueue,
        tokenOpener: options.tokenOpener,
        tokenCloser: options.tokenCloser,
        copies: copies,
      );
    }
  }

  @override
  String onTokenEnd({
    required Queue<String> templateQueue,
    required Queue<StartToken> tokenStack,
    required StringBuffer resultBuffer,
    required Map<String, dynamic> data,
    required TemplateProcessorOptions options,
    required Map<String, String> copies,
    required RunProcessorCallback onRunGenerator,
  }) {
    return resultBuffer.toString();
  }
}

class CopyToken extends StartToken {
  CopyToken({required this.name});

  final String name;

  @override
  void onTokenStart({
    required Queue<String> templateQueue,
    required Queue<StartToken> tokenStack,
    required StringBuffer resultBuffer,
    required Map<String, dynamic> data,
    required TemplateProcessorOptions options,
    required Map<String, String> copies,
    required RunProcessorCallback onRunProcessor,
  }) {
    final Queue<String> copyQueue = Queue<String>.from(templateQueue);
    _flush(
      copyQueue,
      tokenOpener: options.tokenOpener,
      tokenCloser: options.tokenCloser,
      copies: copies,
    );

    final StringBuffer copyBuffer = StringBuffer();
    final int copyLength = (templateQueue.length - copyQueue.length) -
        (options.tokenOpener.length + options.tokenCloser.length);
    for (int i = 0; i < copyLength; i++) {
      copyBuffer.write(templateQueue.elementAt(i));
    }

    copies[name] = copyBuffer.toString();

    resultBuffer.write(onRunProcessor(
      templateQueue: templateQueue,
      tokenStack: tokenStack,
      resultBuffer: StringBuffer(),
      data: data,
      options: options,
      copies: copies,
    ));
  }

  @override
  String onTokenEnd({
    required Queue<String> templateQueue,
    required Queue<StartToken> tokenStack,
    required StringBuffer resultBuffer,
    required Map<String, dynamic> data,
    required TemplateProcessorOptions options,
    required Map<String, String> copies,
    required RunProcessorCallback onRunGenerator,
  }) {
    return resultBuffer.toString();
  }
}

class PasteToken extends EraseToken {
  PasteToken({required this.name});

  final String name;

  late final String paste;

  @override
  void onTokenStart({
    required Queue<String> templateQueue,
    required Queue<StartToken> tokenStack,
    required StringBuffer resultBuffer,
    required Map<String, dynamic> data,
    required TemplateProcessorOptions options,
    required Map<String, String> copies,
    required RunProcessorCallback onRunProcessor,
  }) {
    final String? copy = copies[name];
    if (copy == null) {
      throw ArgumentError('Could not find copy of name: `$name`.');
    }

    tokenStack.removeLast();
    _flush(
      templateQueue,
      tokenOpener: options.tokenOpener,
      tokenCloser: options.tokenCloser,
      copies: copies,
    );

    resultBuffer.write(onRunProcessor(
      templateQueue: Queue<String>.from(copy.split('')),
      tokenStack: tokenStack,
      resultBuffer: StringBuffer(),
      data: data,
      options: options,
      copies: copies,
    ));
  }
}

class EraseToken extends StartToken {
  @override
  void onTokenStart({
    required Queue<String> templateQueue,
    required Queue<StartToken> tokenStack,
    required StringBuffer resultBuffer,
    required Map<String, dynamic> data,
    required TemplateProcessorOptions options,
    required Map<String, String> copies,
    required RunProcessorCallback onRunProcessor,
  }) {
    tokenStack.removeLast();
    _flush(
      templateQueue,
      tokenOpener: options.tokenOpener,
      tokenCloser: options.tokenCloser,
      copies: copies,
    );
  }
}

class EndToken extends Token {}

// TODO: Give each token there own `tryParse` that takes a list of parts from this method
Token? tryParseToken(
  Queue<String> templateQueue, {
  required String tokenOpener,
  required String tokenCloser,
}) {
  if (templateQueue.isEmpty || !queueStartsWith(templateQueue, tokenOpener)) {
    return null;
  }

  final StringBuffer tokenStringBuffer = StringBuffer();
  for (int i = 0; i < tokenOpener.length; i++) {
    templateQueue.removeFirst();
  }

  while (!queueStartsWith(templateQueue, tokenCloser)) {
    if (templateQueue.length <= tokenCloser.length) {
      throw ArgumentError(
        'Found a token opener without a token closer: ${tokenStringBuffer.toString()}',
      );
    }

    tokenStringBuffer.write(templateQueue.removeFirst());
  }

  for (int i = 0; i < tokenCloser.length; i++) {
    templateQueue.removeFirst();
  }

  final String tokenString = tokenStringBuffer.toString();
  if (tokenString.isEmpty) {
    return EndToken();
  }

  final String tokenType = tokenString.split(' ').first;
  if (tokenType == 'iterate') {
    final String? joinModifier = _tryStringMatch(
      pattern: r"(?<=:join=')[^']*(?=')",
      input: tokenString,
    );
    final String name = _tryStringMatch(
      pattern: r'(?<=\s)[^\s]+(?=$)',
      input: tokenString,
    )!;
    final String identifier = _tryStringMatch(
      pattern: r'(?<=\s)[^\s]+(?=\s+[^\s]+$)',
      input: tokenString,
    )!;
    final String? startModifier = _tryStringMatch(
      pattern: r'(?<=:start=)\w+(?=\s)',
      input: tokenString,
    );
    final String? endModifier = _tryStringMatch(
      pattern: r'(?<=:end=)\w+(?=\s)',
      input: tokenString,
    );

    return IterateToken(
      dataInstanceName: name,
      identifier: identifier,
      join: joinModifier ?? '',
      start: startModifier == null ? 0 : int.parse(startModifier),
      end: endModifier == null ? null : int.parse(endModifier),
    );
  } else if (tokenType == 'replace') {
    final String? whatModifier = _tryStringMatch(
      pattern: r"(?<=:what=')[^']*(?=')",
      input: tokenString,
    );
    final String? casingModifier = _tryStringMatch(
      pattern: r'(?<=:case=)\w+(?=\s)',
      input: tokenString,
    );
    final String replacement = _tryStringMatch(
      pattern: r'(?<=\s)[^\s]+(?=$)',
      input: tokenString,
    )!;

    return ReplaceToken(
      what: whatModifier,
      casing: casingModifier,
      identifier: replacement,
    );
  } else if (tokenType == 'if' || tokenType == 'if!') {
    final String identifier = _tryStringMatch(
      pattern: r'(?<=\s)[^\s]+(?=$)',
      input: tokenString,
    )!;
    final String? equalToModifier = _tryStringMatch(
      pattern: r"(?<=:equalTo=')[^']*(?=')",
      input: tokenString,
    );

    return ConditionalToken(
      identifier: identifier,
      inverse: tokenType == 'if!',
      equalTo: equalToModifier,
    );
  } else if (tokenType == 'copy') {
    final String name = _tryStringMatch(
      pattern: r'(?<=\s)[^\s]+(?=$)',
      input: tokenString,
    )!;

    return CopyToken(name: name);
  } else if (tokenType == 'paste') {
    final String name = _tryStringMatch(
      pattern: r'(?<=\s)[^\s]+(?=$)',
      input: tokenString,
    )!;

    return PasteToken(name: name);
  } else if (tokenType == 'erase') {
    return EraseToken();
  }

  throw ArgumentError('Failed to parse token: $tokenString');
}

void _flush(
  Queue<String> templateQueue, {
  required String tokenOpener,
  required String tokenCloser,
  required Map<String, String> copies,
}) {
  int tokenCount = 1;
  while (tokenCount != 0) {
    final Token? newToken = tryParseToken(
      templateQueue,
      tokenOpener: tokenOpener,
      tokenCloser: tokenCloser,
    );

    if (newToken is CopyToken) {
      final Queue<String> copyQueue = Queue<String>.from(templateQueue);
      _flush(
        copyQueue,
        tokenOpener: tokenOpener,
        tokenCloser: tokenCloser,
        copies: copies,
      );

      final StringBuffer copyBuffer = StringBuffer();
      final int copyLength = (templateQueue.length - copyQueue.length) -
          (tokenOpener.length + tokenCloser.length);
      for (int i = 0; i < copyLength; i++) {
        copyBuffer.write(templateQueue.elementAt(i));
      }

      copies[newToken.name] = copyBuffer.toString();
    }

    if (newToken == null) {
      templateQueue.removeFirst();
    } else if (newToken is StartToken) {
      tokenCount++;
    } else if (newToken is EndToken) {
      tokenCount--;
    } else {
      throw StateError('Unknown token found: $newToken.');
    }
  }
}

// Also tries pattern that looks for string to try with '' and ""
String? _tryStringMatch({required String pattern, required String input}) {
  String? result = RegExp(
    pattern,
    multiLine: true,
    dotAll: true,
  ).stringMatch(input);

  if (pattern.contains("'")) {
    result ??= RegExp(
      pattern.replaceAll("'", '"'),
      multiLine: true,
      dotAll: true,
    ).stringMatch(input);
  } else if (pattern.contains('"')) {
    result ??= RegExp(
      pattern.replaceAll('"', "'"),
      multiLine: true,
      dotAll: true,
    ).stringMatch(input);
  }

  return result;
}
