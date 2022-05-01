import 'dart:collection';

import 'token.dart';

bool queueStartsWith(Queue<String> templateQueue, String tokenEdge) {
  if (templateQueue.length < tokenEdge.length) return false;

  for (int i = 0; i < tokenEdge.length; i++) {
    if (templateQueue.elementAt(i) != tokenEdge[i]) return false;
  }

  return true;
}

Object? retrieveValueForIdentifier({
  required Queue<Token> tokenStack,
  required String identifier,
  required Map<String, dynamic> data,
  bool throwOnMissing = true,
}) {
  final List<String> identifierParts = identifier.split('_');

  final Object? value = _tryFindInMap(
    identifierParts: identifierParts,
    data: data,
  );
  if (value != null) return value;

  final String dataName = identifierParts.first;
  for (Token token in tokenStack.toList().reversed) {
    if (token is IterateToken && token.dataInstanceName == dataName) {
      final Object? value = _tryFindInMap(
        identifierParts: identifierParts.sublist(1),
        data: token.dataQueue.first,
      );
      if (value != null) return value;
    }
  }

  if (throwOnMissing) {
    throw ArgumentError(
      'Could not find data for identifier parts ($identifierParts) in data:$data.',
    );
  }

  return null;
}

Object? _tryFindInMap({
  required List<String> identifierParts,
  required Map<dynamic, dynamic> data,
}) {
  if (identifierParts.isEmpty) {
    return null;
  } else if (identifierParts.length == 1) {
    return data[identifierParts.first];
  }

  final Map<dynamic, dynamic>? nextMap = data[identifierParts.first];
  if (nextMap != null) {
    return _tryFindInMap(
      identifierParts: identifierParts.sublist(1),
      data: nextMap,
    );
  }

  return null;
}
