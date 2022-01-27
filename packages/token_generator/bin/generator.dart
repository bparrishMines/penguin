import 'dart:collection';

import 'token.dart';
import 'token_generator_options.dart';

String runGenerator(TokenGeneratorOptions options) {
  return _runGenerator(
    templateQueue: Queue<String>.from(options.template.split('')),
    tokens: Queue<StartToken>(),
    resultBuffer: StringBuffer(),
    data: options.jsonData,
    options: options,
  );
}

String _runGenerator({
  required Queue<String> templateQueue,
  required Queue<StartToken> tokens,
  required StringBuffer resultBuffer,
  required Map<String, dynamic> data,
  required TokenGeneratorOptions options,
}) {
  while (templateQueue.isNotEmpty) {
    final Token? newToken = tryParseToken(
      templateQueue,
      tokenOpener: options.tokenOpener,
      tokenCloser: options.tokenCloser,
    );

    if (newToken is StartToken) {
      tokens.addFirst(newToken);
      newToken.onTokenStart(
        templateQueue: templateQueue,
        tokens: tokens,
        resultBuffer: resultBuffer,
        data: data,
        options: options,
        onRunGenerator: _runGenerator,
      );
    } else if (newToken is EndToken) {
      return tokens.removeFirst().onTokenEnd(
            templateQueue: templateQueue,
            tokens: tokens,
            resultBuffer: resultBuffer,
            data: data,
            options: options,
            onRunGenerator: _runGenerator,
          );
    } else if (queueStartsWith(templateQueue, '__') ||
        queueStartsWith(templateQueue, r'$$')) {
      String identifier = '';

      while (!RegExp(r'^__\w*__$').hasMatch(identifier) &&
          !RegExp(r'^\$\$\w*\$\$$').hasMatch(identifier)) {
        identifier += templateQueue.removeFirst();
      }

      final String value = retrieveValueForIdentifier(
        tokens: tokens,
        identifier: identifier.replaceAll('__', '').replaceAll(r'$$', ''),
        data: data,
      ).toString();
      resultBuffer.write(value);
    } else {
      resultBuffer.write(templateQueue.removeFirst());
    }
  }

  return resultBuffer.toString();
}
