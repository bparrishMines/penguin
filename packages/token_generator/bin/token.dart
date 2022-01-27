import 'dart:collection';

import 'token_generator_options.dart';

typedef RunGeneratorCallback = String Function({
  required Queue<String> templateQueue,
  required Queue<StartToken> tokens,
  required StringBuffer resultBuffer,
  required Map<String, dynamic> data,
  required TokenGeneratorOptions options,
});

abstract class Token {}

abstract class StartToken extends Token {
  void onTokenStart({
    required Queue<String> templateQueue,
    required Queue<StartToken> tokens,
    required StringBuffer resultBuffer,
    required Map<String, dynamic> data,
    required TokenGeneratorOptions options,
    required RunGeneratorCallback onRunGenerator,
  }) {
    throw UnimplementedError();
  }

  String onTokenEnd({
    required Queue<String> templateQueue,
    required Queue<StartToken> tokens,
    required StringBuffer resultBuffer,
    required Map<String, dynamic> data,
    required TokenGeneratorOptions options,
    required RunGeneratorCallback onRunGenerator,
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
  });

  final String dataInstanceName;
  final String identifier;
  final String join;
  final int start;
  final int? end;
  late final Queue<Map<dynamic, dynamic>> dataQueue;

  @override
  void onTokenStart({
    required Queue<String> templateQueue,
    required Queue<StartToken> tokens,
    required StringBuffer resultBuffer,
    required Map<String, dynamic> data,
    required TokenGeneratorOptions options,
    required RunGeneratorCallback onRunGenerator,
  }) {
    final List<Map<dynamic, dynamic>>? dataList = retrieveValueForIdentifier(
        tokens: tokens,
        identifier: identifier,
        data: data) as List<Map<dynamic, dynamic>>?;
    final List<String> outputs = <String>[];

    if (dataList == null) {
      print(data);
      print(dataInstanceName);
      print(resultBuffer.toString());
      throw StateError('Failed to find data!');
    }

    dataQueue = Queue<Map<dynamic, dynamic>>.of(
      dataList.sublist(start, end ?? dataList.length),
    );

    while (dataQueue.isNotEmpty) {
      outputs.add(onRunGenerator(
        templateQueue: Queue<String>.from(templateQueue),
        tokens: Queue<StartToken>.from(tokens),
        resultBuffer: StringBuffer(),
        data: dataQueue.first.cast<String, dynamic>(),
        options: options,
      ));
      dataQueue.removeFirst();
    }
    _flush(
      templateQueue,
      tokenOpener: options.tokenOpener,
      tokenCloser: options.tokenCloser,
    );
    tokens.removeFirst();
    resultBuffer.write(outputs.join(join));
  }

  @override
  String onTokenEnd(
      {required Queue<String> templateQueue,
      required Queue<StartToken> tokens,
      required StringBuffer resultBuffer,
      required Map<String, dynamic> data,
      required TokenGeneratorOptions options,
      required RunGeneratorCallback onRunGenerator}) {
    return resultBuffer.toString();
  }
}

class ReplaceToken extends StartToken {
  ReplaceToken({this.what, required this.identifier});

  final String? what;
  final String identifier;

  @override
  void onTokenStart({
    required Queue<String> templateQueue,
    required Queue<StartToken> tokens,
    required StringBuffer resultBuffer,
    required Map<String, dynamic> data,
    required TokenGeneratorOptions options,
    required RunGeneratorCallback onRunGenerator,
  }) {
    resultBuffer.write(onRunGenerator(
      templateQueue: templateQueue,
      tokens: tokens,
      resultBuffer: StringBuffer(),
      data: data,
      options: options,
    ));
  }

  @override
  String onTokenEnd({
    required Queue<String> templateQueue,
    required Queue<StartToken> tokens,
    required StringBuffer resultBuffer,
    required Map<String, dynamic> data,
    required TokenGeneratorOptions options,
    required RunGeneratorCallback onRunGenerator,
  }) {
    final String replacement = retrieveValueForIdentifier(
      tokens: tokens,
      identifier: identifier,
      data: data,
    ).toString();

    if (what == null) {
      return replacement;
    }

    return resultBuffer.toString().replaceAll(what!, replacement);
  }
}

class ConditionalToken extends StartToken {
  ConditionalToken({required this.identifier, required this.inverse});

  final String identifier;
  final bool inverse;

  @override
  void onTokenStart({
    required Queue<String> templateQueue,
    required Queue<StartToken> tokens,
    required StringBuffer resultBuffer,
    required Map<String, dynamic> data,
    required TokenGeneratorOptions options,
    required RunGeneratorCallback onRunGenerator,
  }) {
    bool condition = retrieveValueForIdentifier(
      tokens: tokens,
      identifier: identifier,
      data: data,
    ) as bool;
    if (inverse) condition = !condition;
    if (condition) {
      resultBuffer.write(onRunGenerator(
        templateQueue: templateQueue,
        tokens: tokens,
        resultBuffer: StringBuffer(),
        data: data,
        options: options,
      ));
    } else {
      tokens.removeFirst();
      _flush(
        templateQueue,
        tokenOpener: options.tokenOpener,
        tokenCloser: options.tokenCloser,
      );
    }
  }

  @override
  String onTokenEnd({
    required Queue<String> templateQueue,
    required Queue<Token> tokens,
    required StringBuffer resultBuffer,
    required Map<String, dynamic> data,
    required TokenGeneratorOptions options,
    required RunGeneratorCallback onRunGenerator,
  }) {
    return resultBuffer.toString();
  }
}

class FunctionToken extends Token {
  FunctionToken({required this.identifier});

  final String identifier;
}

class EraseToken extends StartToken {
  @override
  void onTokenStart({
    required Queue<String> templateQueue,
    required Queue<Token> tokens,
    required StringBuffer resultBuffer,
    required Map<String, dynamic> data,
    required TokenGeneratorOptions options,
    required RunGeneratorCallback onRunGenerator,
  }) {
    tokens.removeFirst();
    _flush(
      templateQueue,
      tokenOpener: options.tokenOpener,
      tokenCloser: options.tokenCloser,
    );
  }
}

class EndToken extends Token {}

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
    final String? joinModifier =
        RegExp(r"(?<=:join=')[^']*(?=')", multiLine: true, dotAll: true)
            .stringMatch(tokenString);
    final String identifier =
        RegExp(r'(?<=\s)[^\s]+(?=$)', multiLine: true, dotAll: true)
            .stringMatch(tokenString)!;
    final String name =
        RegExp(r'(?<=\s)[^\s]+(?=\s+[^\s]+$)', multiLine: true, dotAll: true)
            .stringMatch(tokenString)!;
    final String? startModifier =
        RegExp(r'(?<=:start=)\w+(?=\s)', multiLine: true, dotAll: true)
            .stringMatch(tokenString);
    final String? endModifier =
        RegExp(r'(?<=:end=)\w+(?=\s)', multiLine: true, dotAll: true)
            .stringMatch(tokenString);

    return IterateToken(
      dataInstanceName: name,
      identifier: identifier,
      join: joinModifier ?? '',
      start: startModifier == null ? 0 : int.parse(startModifier),
      end: endModifier == null ? null : int.parse(endModifier),
    );
  } else if (tokenType == 'replace') {
    final String? whatModifier =
        RegExp(r"(?<=:what=')[^']*(?=')", multiLine: true, dotAll: true)
            .stringMatch(tokenString);
    final String replacement =
        RegExp(r'(?<=\s)[^\s]+(?=$)', multiLine: true, dotAll: true)
            .stringMatch(tokenString)!;

    return ReplaceToken(
      what: whatModifier,
      identifier: replacement,
    );
  } else if (tokenType.startsWith('if')) {
    final String identifier =
        RegExp(r'(?<=\s)[^\s]+(?=$)', multiLine: true, dotAll: true)
            .stringMatch(tokenString)!;

    return ConditionalToken(
      identifier: identifier,
      inverse: tokenType == 'if!',
    );
  } else if (tokenType.startsWith('function')) {
    final String replacement =
        RegExp(r'(?<=\s)[^\s]+(?=$)', multiLine: true, dotAll: true)
            .stringMatch(tokenString)!;

    return FunctionToken(identifier: replacement);
  } else if (tokenType.startsWith('erase')) {
    return EraseToken();
  }

  throw ArgumentError('Failed to parse token: $tokenType');
}

bool queueStartsWith(Queue<String> templateQueue, String tokenEdge) {
  if (templateQueue.length < tokenEdge.length) return false;

  for (int i = 0; i < tokenEdge.length; i++) {
    if (templateQueue.elementAt(i) != tokenEdge[i]) return false;
  }

  return true;
}

Object retrieveValueForIdentifier({
  required Queue<Token> tokens,
  required String identifier,
  required Map<String, dynamic> data,
}) {
  final List<String> identifierParts = identifier.split('_');
  if (identifierParts.length == 1) {
    final Object? value = data[identifierParts.single];
    if (value != null) return value;
    throw ArgumentError('Could not find data for identifier: $identifier');
  } else if (identifierParts.length > 2) {
    throw ArgumentError('An identifier had too many parts: $identifier.');
  }

  final String dataName = identifierParts.first;
  final String valueIdentifier = identifierParts[1];
  for (Token token in tokens) {
    if (token is IterateToken && token.dataInstanceName == dataName) {
      return token.dataQueue.first[valueIdentifier];
    }
  }

  throw ArgumentError('Could not find data for identifier: $identifier.');
}

void _flush(
  Queue<String> templateQueue, {
  required String tokenOpener,
  required String tokenCloser,
}) {
  int tokenCount = 1;
  while (tokenCount != 0) {
    final Token? newToken = tryParseToken(
      templateQueue,
      tokenOpener: tokenOpener,
      tokenCloser: tokenCloser,
    );

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
