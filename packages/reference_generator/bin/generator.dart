import 'dart:collection';

import 'dart:math';

String runGenerator(
  Queue<String> templateQueue,
  Queue<Token> tokens,
  StringBuffer resultBuffer,
  Map<String, Object> data,
) {
  while (templateQueue.isNotEmpty) {
    final Token? newToken = tryParseToken(templateQueue);

    if (newToken == null) {
      resultBuffer.write(templateQueue.removeFirst());
    } else if (newToken is ConditionalToken) {
      handleConditionalToken(
        newToken,
        templateQueue,
        tokens,
        resultBuffer,
        data,
      );
    } else if (newToken is ReplaceToken) {
      tokens.addFirst(newToken);
      resultBuffer.write(runGenerator(
        templateQueue,
        tokens,
        StringBuffer(),
        data,
      ));
    } else if (newToken is IterateToken) {
      tokens.addFirst(newToken);

      final IterateToken currentToken = newToken;

      final List<Map<String, Object>>? dataList =
          data[currentToken.listName] as List<Map<String, Object>>?;
      final List<String> outputs = <String>[];

      if (dataList == null) {
        print(data);
        print(currentToken.listName);
        print(resultBuffer.toString());
        throw StateError('Failed to find data!');
      }

      final int end = min(currentToken.end ?? dataList.length, dataList.length);
      for (int i = currentToken.start; i < end; i++) {
        outputs.add(runGenerator(
          Queue<String>.from(templateQueue),
          tokens,
          StringBuffer(),
          dataList[i],
        ));
      }
      flush(templateQueue);
      tokens.removeFirst();
      resultBuffer.write(outputs.join(currentToken.join));
    } else if (newToken is EndToken && tokens.first is ReplaceToken) {
      final ReplaceToken currentToken = tokens.removeFirst() as ReplaceToken;

      if (currentToken.replacement.contains('_')) {
        return resultBuffer.toString().replaceAll(
              currentToken.from ?? resultBuffer.toString(),
              '\$\$${currentToken.replacement}\$\$',
            );
      } else {
        return resultBuffer.toString().replaceAll(
              currentToken.from ?? resultBuffer.toString(),
              data[currentToken.replacement] as String,
            );
      }
    } else if (newToken is EndToken && tokens.first is IterateToken) {
      final IterateToken currentToken = tokens.first as IterateToken;

      String result = resultBuffer.toString();
      for (String key in data.keys) {
        if (data[key] is String) {
          result = result.replaceAll(
            '\$\$${currentToken.identifier}_$key\$\$',
            data[key] as String,
          );
          result = result.replaceAll(
            '__${currentToken.identifier}_${key}__',
            data[key] as String,
          );
        }
      }
      return result;
    } else if (newToken is EndToken && tokens.first is ConditionalToken) {
      tokens.removeFirst();
      return resultBuffer.toString();
    }
  }

  return resultBuffer.toString();
}

void handleConditionalToken(
  ConditionalToken token,
  Queue<String> templateQueue,
  Queue<Token> tokens,
  StringBuffer resultBuffer,
  Map<String, Object> data,
) {
  bool condition = data[token.identifier] as bool;
  if (token.inverse) condition = !condition;
  if (condition) {
    tokens.addFirst(token);
    resultBuffer.write(runGenerator(
      templateQueue,
      tokens,
      StringBuffer(),
      data,
    ));
  } else {
    flush(templateQueue);
  }
}

void flush(Queue<String> templateQueue) {
  int tokenCount = 1;
  while (tokenCount != 0) {
    final Token? newToken = tryParseToken(templateQueue);

    if (newToken == null) {
      templateQueue.removeFirst();
    } else if (newToken is! EndToken) {
      tokenCount++;
    } else {
      tokenCount--;
    }
  }
}

Token? tryParseToken(Queue<String> templateQueue) {
  if (templateQueue.isEmpty ||
      templateQueue.first != '/' ||
      templateQueue.elementAt(1) != '*') {
    return null;
  }

  final StringBuffer tokenStringBuffer = StringBuffer();
  String lastChar = templateQueue.removeFirst();
  tokenStringBuffer.write(lastChar);
  while (true) {
    final String currentChar = templateQueue.removeFirst();
    tokenStringBuffer.write(currentChar);
    if (lastChar == '*' && currentChar == '/') break;
    lastChar = currentChar;
  }

  final String tokenString = tokenStringBuffer.toString();
  if (tokenString == '/**/') return EndToken();

  final String tokenType = tokenString.split(' ').first;
  if (tokenType == '/*iterate') {
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

    return IterateToken(
      listName: listName,
      identifier: identifier,
      join: joinModifier ?? '',
      start: startModifier == null ? 0 : int.parse(startModifier),
      end: endModifier == null ? null : int.parse(endModifier),
    );
  } else if (tokenType == '/*replace') {
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
  } else if (tokenType.startsWith('/*if')) {
    final String identifier =
        RegExp(r'(?<=\s)[^\s]+(?=\*/)', multiLine: true, dotAll: true)
            .stringMatch(tokenString)!;

    return ConditionalToken(
      identifier: identifier,
      inverse: tokenType == '/*if!',
    );
  }

  throw StateError('Failed to parse token');
}

abstract class Token {}

class IterateToken extends Token {
  IterateToken({
    required this.listName,
    required this.identifier,
    required this.join,
    required this.start,
    this.end,
  });

  final String listName;
  final String identifier;
  final String join;
  final int start;
  final int? end;
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

class EndToken extends Token {}
