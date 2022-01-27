import 'dart:collection';

abstract class Token {}

class IterateToken extends Token {
  IterateToken({
    required this.listName,
    required this.identifier,
    required this.join,
    required this.start,
    this.end,
    this.ifIdentifier,
  });

  final String listName;
  final String identifier;
  final String join;
  final int start;
  final int? end;
  final String? ifIdentifier;
}

class ReplaceToken extends Token {
  ReplaceToken({this.from, required this.replacement});

  final String? from;
  final String replacement;
}

class ConditionalToken extends Token {
  ConditionalToken({required this.identifier, required this.inverse});

  final String identifier;
  final bool inverse;
}

class FunctionToken extends Token {
  FunctionToken({required this.identifier});

  final String identifier;
}

class EraseToken extends Token {}

class EndToken extends Token {}

Token? tryParseToken(
  Queue<String> templateQueue, {
  required String tokenOpener,
  required String tokenCloser,
}) {
  if (templateQueue.isEmpty || !_isTokenEdge(templateQueue, tokenOpener)) {
    return null;
  }

  final StringBuffer tokenStringBuffer = StringBuffer();
  for (int i = 0; i < tokenOpener.length; i++) {
    templateQueue.removeFirst();
  }

  while (!_isTokenEdge(templateQueue, tokenCloser)) {
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
  if (tokenString == '$tokenOpener$tokenCloser') {
    return EndToken();
  }

  final String tokenType = tokenString.split(' ').first;
  if (tokenType == 'iterate') {
    final String? joinModifier =
        RegExp(r"(?<=:join=')[^']*(?=')", multiLine: true, dotAll: true)
            .stringMatch(tokenString);
    final String identifier =
        RegExp(r'(?<=\s)[^\s]+(?=\*/)', multiLine: true, dotAll: true)
            .stringMatch(tokenString)!;
    final String listName =
        RegExp(r'(?<=\s)[^\s]+(?=\s+[^\s]+\*/)', multiLine: true, dotAll: true)
            .stringMatch(tokenString)!;
    final String? startModifier =
        RegExp(r'(?<=:start=)\w+(?=\s)', multiLine: true, dotAll: true)
            .stringMatch(tokenString);
    final String? endModifier =
        RegExp(r'(?<=:end=)\w+(?=\s)', multiLine: true, dotAll: true)
            .stringMatch(tokenString);
    final String? ifModifier =
        RegExp(r'(?<=:if=)\w+(?=\s)', multiLine: true, dotAll: true)
            .stringMatch(tokenString);

    return IterateToken(
      listName: listName,
      identifier: identifier,
      join: joinModifier ?? '',
      start: startModifier == null ? 0 : int.parse(startModifier),
      end: endModifier == null ? null : int.parse(endModifier),
      ifIdentifier: ifModifier,
    );
  } else if (tokenType == 'replace') {
    final String? fromModifier =
        RegExp(r"(?<=:from=')[^']*(?=')", multiLine: true, dotAll: true)
            .stringMatch(tokenString);
    final String replacement =
        RegExp(r'(?<=\s)[^\s]+(?=\*/)', multiLine: true, dotAll: true)
            .stringMatch(tokenString)!;

    return ReplaceToken(
      from: fromModifier,
      replacement: replacement,
    );
  } else if (tokenType.startsWith('if')) {
    final String identifier =
        RegExp(r'(?<=\s)[^\s]+(?=\*/)', multiLine: true, dotAll: true)
            .stringMatch(tokenString)!;

    return ConditionalToken(
      identifier: identifier,
      inverse: tokenType == 'if!',
    );
  } else if (tokenType.startsWith('function')) {
    final String replacement =
        RegExp(r'(?<=\s)[^\s]+(?=\*/)', multiLine: true, dotAll: true)
            .stringMatch(tokenString)!;

    return FunctionToken(identifier: replacement);
  } else if (tokenType.startsWith('erase')) {
    return EraseToken();
  }

  throw StateError('Failed to parse token: $tokenType');
}

bool _isTokenEdge(Queue<String> templateQueue, String tokenEdge) {
  if (templateQueue.length < tokenEdge.length) return false;

  for (int i = 0; i < tokenEdge.length; i++) {
    if (templateQueue.elementAt(i) != tokenEdge[i]) return false;
  }

  return true;
}
