import 'dart:collection';

import 'processor_utils.dart';
import 'token.dart';
import 'code_template_processor_options.dart';

String runProcessor(TemplateProcessorOptions options) {
  return _runProcessor(
    templateQueue: Queue<String>.from(options.template.split('')),
    tokenStack: Queue<StartToken>(),
    resultBuffer: StringBuffer(),
    data: options.jsonData,
    options: options,
  );
}

String _runProcessor({
  required Queue<String> templateQueue,
  required Queue<StartToken> tokenStack,
  required StringBuffer resultBuffer,
  required Map<String, dynamic> data,
  required TemplateProcessorOptions options,
}) {
  while (templateQueue.isNotEmpty) {
    final Token? newToken = tryParseToken(
      templateQueue,
      tokenOpener: options.tokenOpener,
      tokenCloser: options.tokenCloser,
    );

    if (newToken is StartToken) {
      tokenStack.addLast(newToken);
      newToken.onTokenStart(
        templateQueue: templateQueue,
        tokenStack: tokenStack,
        resultBuffer: resultBuffer,
        data: data,
        options: options,
        onRunProcessor: _runProcessor,
      );
    } else if (newToken is EndToken) {
      return tokenStack.removeLast().onTokenEnd(
            templateQueue: templateQueue,
            tokenStack: tokenStack,
            resultBuffer: resultBuffer,
            data: data,
            options: options,
            onRunGenerator: _runProcessor,
          );
    } else if (queueStartsWith(templateQueue, '__') ||
        queueStartsWith(templateQueue, r'$$')) {
      String identifier = '';

      while (!RegExp(r'^__\w*__$').hasMatch(identifier) &&
          !RegExp(r'^\$\$\w*\$\$$').hasMatch(identifier)) {
        identifier += templateQueue.removeFirst();
      }

      final String value = retrieveValueForIdentifier(
        tokenStack: tokenStack,
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
