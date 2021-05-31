import 'dart:collection';

String runGenerator(
  Queue<String> templateQueue,
  Queue<Token> tokens,
  StringBuffer resultBuffer,
  Map<String, Object> data,
) {
  while (templateQueue.isNotEmpty) {
    final Token newToken = tryParseToken(templateQueue);

    if (newToken == null) {
      resultBuffer.write(templateQueue.removeFirst());
    } else if (newToken is ReplaceToken || newToken is ConditionalToken) {
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

      final List<Map<String, Object>> dataList =
          data[currentToken.listName] as List<Map<String, Object>>;
      final List<String> outputs = <String>[];
      for (int i = 0; i < dataList.length; i++) {
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
      final ReplaceToken currentToken = tokens.removeFirst();

      if (currentToken.replacement.contains('_')) {
        return resultBuffer.toString().replaceAll(
              currentToken.from ?? resultBuffer.toString(),
              '\$\$${currentToken.replacement}\$\$',
            );
      } else {
        return resultBuffer.toString().replaceAll(
              currentToken.from ?? resultBuffer.toString(),
              data[currentToken.replacement],
            );
      }
    } else if (newToken is EndToken && tokens.first is IterateToken) {
      final IterateToken currentToken = tokens.first;

      String result = resultBuffer.toString();
      for (String key in data.keys) {
        if (data[key] is String) {
          result = result.replaceAll(
            '\$\$${currentToken.identifier}_$key\$\$',
            data[key],
          );
          result = result.replaceAll(
            '__${currentToken.identifier}_${key}__',
            data[key],
          );
        }
      }
      return result;
    } else if (newToken is EndToken && tokens.first is ConditionalToken) {
      final ConditionalToken currentToken = tokens.removeFirst();
      return data[currentToken.identifier] ? resultBuffer.toString() : '';
    }
  }

  return resultBuffer.toString();
}

void flush(Queue<String> templateQueue) {
  int tokenCount = 1;
  while (tokenCount != 0) {
    final Token newToken = tryParseToken(templateQueue);

    if (newToken == null) {
      templateQueue.removeFirst();
    } else if (newToken is! EndToken) {
      tokenCount++;
    } else {
      tokenCount--;
    }
  }
}

Token tryParseToken(Queue<String> templateQueue) {
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
    final String joinModifier =
        RegExp(r"(?<=:join=')[^']*(?=')", multiLine: true, dotAll: true)
            .stringMatch(tokenString);
    final String identifier =
        RegExp(r'(?<=\s)[^\s]+(?=\*/)', multiLine: true, dotAll: true)
            .stringMatch(tokenString);
    final String listName =
        RegExp(r'(?<=\s)[^\s]+(?=\s+[^\s]+\*/)', multiLine: true, dotAll: true)
            .stringMatch(tokenString);

    return IterateToken(
      listName: listName,
      identifier: identifier,
      join: joinModifier ?? '',
    );
  } else if (tokenType == '/*replace') {
    final String fromModifier =
        RegExp(r"(?<=:from=')[^']*(?=')", multiLine: true, dotAll: true)
            .stringMatch(tokenString);
    final String caseModifier =
        RegExp(r'(?<=:case=)\w+', multiLine: true, dotAll: true)
            .stringMatch(tokenString);
    final String replacement =
        RegExp(r'(?<=\s)[^\s]+(?=\*/)', multiLine: true, dotAll: true)
            .stringMatch(tokenString);

    return ReplaceToken(
      from: fromModifier,
      replacement: replacement,
      $case: caseModifier,
    );
  } else if (tokenType == '/*if') {
    final String identifier =
        RegExp(r'(?<=\s)[^\s]+(?=\*/)', multiLine: true, dotAll: true)
            .stringMatch(tokenString);
    return ConditionalToken(identifier);
  }

  return null;
}

abstract class Token {}

class IterateToken extends Token {
  IterateToken({this.listName, this.identifier, this.join = ''})
      : assert(listName != null),
        assert(identifier != null);

  final String listName;
  final String identifier;
  final String join;
}

class ReplaceToken extends Token {
  ReplaceToken({this.from, this.replacement, this.$case});

  final String from;
  final String replacement;
  final String $case;
}

class ConditionalToken extends Token {
  ConditionalToken(this.identifier);

  final String identifier;
}

class EndToken extends Token {}
