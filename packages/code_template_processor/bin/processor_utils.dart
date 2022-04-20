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
  }

  final String dataName = identifierParts.first;
  for (Token token in tokenStack.toList().reversed) {
    if (token is IterateToken && token.dataInstanceName == dataName) {
      Map<dynamic, dynamic> currentMap = token.dataQueue.first;
      for (int i = 1; i < identifierParts.length; i++) {
        if (i == identifierParts.length - 1) {
          final Object? result = currentMap[identifierParts[i]];
          if (result != null) {
            return result;
          }
        } else {
          final Map<dynamic, dynamic>? nextMap = currentMap[identifierParts[i]];
          if (nextMap != null) {
            currentMap = nextMap;
          } else {
            break;
          }
        }
      }
    }
  }

  throw ArgumentError(
    'Could not find data for identifier parts: $identifierParts.',
  );
}
