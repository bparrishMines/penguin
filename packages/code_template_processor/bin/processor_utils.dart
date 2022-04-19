import 'dart:collection';

import 'token.dart';

bool queueStartsWith(Queue<String> templateQueue, String tokenEdge) {
  if (templateQueue.length < tokenEdge.length) return false;

  for (int i = 0; i < tokenEdge.length; i++) {
    if (templateQueue.elementAt(i) != tokenEdge[i]) return false;
  }

  return true;
}

Object retrieveValueForIdentifier({
  required Queue<Token> tokenStack,
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
  for (Token token in tokenStack.toList().reversed) {
    if (token is IterateToken && token.dataInstanceName == dataName) {
      return token.dataQueue.first[valueIdentifier];
    }
  }

  throw ArgumentError('Could not find data for identifier: $identifier.');
}
