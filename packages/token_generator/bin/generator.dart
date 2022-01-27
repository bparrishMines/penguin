import 'dart:collection';

import 'dart:math';

import 'token.dart';
import 'token_generator_options.dart';

String runGenerator({
  required String input,
  required Map<String, Object> data,
  required TokenGeneratorOptions options,
}) {
  return _runGenerator(
    templateQueue: Queue<String>.from(input.split('')),
    tokens: Queue<Token>(),
    resultBuffer: StringBuffer(),
    data: data,
    options: options,
  );
}

String _runGenerator({
  required Queue<String> templateQueue,
  required Queue<Token> tokens,
  required StringBuffer resultBuffer,
  required Map<String, Object> data,
  required TokenGeneratorOptions options,
}) {
  while (templateQueue.isNotEmpty) {
    final Token? newToken = tryParseToken(
      templateQueue,
      tokenOpener: options.tokenOpener,
      tokenCloser: options.tokenCloser,
    );

    if (newToken == null) {
      resultBuffer.write(templateQueue.removeFirst());
    } else if (newToken is ConditionalToken) {
      handleConditionalToken(
        token: newToken,
        templateQueue: templateQueue,
        tokens: tokens,
        resultBuffer: resultBuffer,
        data: data,
        options: options,
      );
    } else if (newToken is EraseToken) {
      _flush(
        templateQueue,
        tokenOpener: options.tokenOpener,
        tokenCloser: options.tokenCloser,
      );
    } else if (newToken is ReplaceToken) {
      tokens.addFirst(newToken);
      resultBuffer.write(_runGenerator(
        templateQueue: templateQueue,
        tokens: tokens,
        resultBuffer: StringBuffer(),
        data: data,
        options: options,
      ));
    } else if (newToken is FunctionToken) {
      tokens.addFirst(newToken);
      resultBuffer.write(_runGenerator(
        templateQueue: templateQueue,
        tokens: tokens,
        resultBuffer: StringBuffer(),
        data: data,
        options: options,
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

      final String? ifIdentifier = currentToken.ifIdentifier;
      final int end = min(currentToken.end ?? dataList.length, dataList.length);
      for (int i = currentToken.start; i < end; i++) {
        if (ifIdentifier == null || dataList[i][ifIdentifier] as bool) {
          outputs.add(_runGenerator(
            templateQueue: Queue<String>.from(templateQueue),
            tokens: tokens,
            resultBuffer: StringBuffer(),
            data: dataList[i],
            options: options,
          ));
        }
      }
      _flush(
        templateQueue,
        tokenOpener: options.tokenOpener,
        tokenCloser: options.tokenCloser,
      );
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
    } else if (newToken is EndToken && tokens.first is FunctionToken) {
      final FunctionToken currentToken = tokens.removeFirst() as FunctionToken;
      final String Function(String) function =
          data[currentToken.identifier] as String Function(String);
      return function(resultBuffer.toString());
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

void handleConditionalToken({
  required ConditionalToken token,
  required Queue<String> templateQueue,
  required Queue<Token> tokens,
  required StringBuffer resultBuffer,
  required Map<String, Object> data,
  required TokenGeneratorOptions options,
}) {
  bool condition = data[token.identifier] as bool;
  if (token.inverse) condition = !condition;
  if (condition) {
    tokens.addFirst(token);
    resultBuffer.write(_runGenerator(
      templateQueue: templateQueue,
      tokens: tokens,
      resultBuffer: StringBuffer(),
      data: data,
      options: options,
    ));
  } else {
    _flush(
      templateQueue,
      tokenOpener: options.tokenOpener,
      tokenCloser: options.tokenCloser,
    );
  }
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
    } else if (newToken is! EndToken) {
      tokenCount++;
    } else {
      tokenCount--;
    }
  }
}
