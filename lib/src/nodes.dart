import 'package:penguin/src/plugin.dart';
import 'package:penguin/src/writer.dart';

class NodeStructure {
  NodeStructure(this.plugin) {
    _initialize();
  }

  final Plugin plugin;

  final Map<String, ClassNode> _classNodes = <String, ClassNode>{};
  final Set<ClassNode> _rootNodes = <ClassNode>{};

  List<Node> getNodeList(Class theClass) =>
      _getNodeList(theClass, <ClassNode>{}).reversed.toList();

  List<Node> _getNodeList(Class theClass, Set<ClassNode> seenClassNodes) {
    final List<Node> nodes = <Node>[];

    final ClassNode startNode = _classNodes[theClass.name];
    nodes.add(startNode);

    if (_rootNodes.contains(startNode)) return nodes;

    final List<CreatorNode> creatorNodes = startNode.returningCreators;

    CreatorNode bestNode;
    for (CreatorNode creatorNode in creatorNodes) {
      final ClassNode creatorClassNode = creatorNode.parentClass;

      if (_rootNodes.contains(creatorClassNode)) {
        nodes.add(creatorNode);
        nodes.add(creatorClassNode);
        return nodes;
      }

      if (!seenClassNodes.contains(creatorClassNode)) {
        bestNode = creatorNode;
      }
    }

    if (bestNode == null) {
      throw StateError('Not possible');
    }

    nodes.add(bestNode);
    seenClassNodes.add(bestNode.parentClass);
    return nodes
      ..addAll(
        _getNodeList(bestNode.parentClass.theClass, seenClassNodes),
      );
  }

  void _initialize() {
    for (Class theClass in plugin.classes) {
      final ClassNode node = ClassNode(theClass);
      _classNodes[theClass.name] = node;

      final ClassStructure structure = _structureFromClass(plugin, theClass);
      if (structure == ClassStructure.unspecifiedPublic) {
        _rootNodes.add(node);
      } else {
        for (Method method in theClass.methods) {
          if (method.returns == theClass.name) {
            _rootNodes.add(node);
          }
        }

        for (Field field in theClass.fields) {
          if (field.type == theClass.name && field.static) {
            _rootNodes.add(node);
          }
        }
      }
    }

    for (Class theClass in plugin.classes) {
      for (Method method in theClass.methods) {
        if (_classNodes.containsKey(method.returns)) {
          final CreatorNode newNode = CreatorNode(
            method,
            _classNodes[theClass.name],
          );
          _classNodes[method.returns].addMethod(newNode);
        }
      }
    }

    for (Class theClass in plugin.classes) {
      for (Field field in theClass.fields) {
        if (_classNodes.containsKey(field.type)) {
          final CreatorNode newNode = CreatorNode(
            field,
            _classNodes[theClass.name],
          );
          _classNodes[field.type].addMethod(newNode);
        }
      }
    }
  }
}

class Node {}

class ClassNode implements Node {
  ClassNode(this.theClass) : assert(theClass != null);

  final Class theClass;
  final List<CreatorNode> _returningCreators = <CreatorNode>[];

  List<CreatorNode> get returningCreators =>
      List<CreatorNode>.unmodifiable(_returningCreators);

  void addMethod(CreatorNode method) => _returningCreators.add(method);

  @override
  String toString() => theClass.name;
}

class CreatorNode implements Node {
  CreatorNode(this.returner, this.parentClass)
      : assert(returner != null),
        assert(returner is Field || returner is Method),
        assert(parentClass != null);

  final dynamic returner;
  final ClassNode parentClass;

  @override
  String toString() => returner.name;
}

// TODO(bparrishMines): This is a copy from Writer class
ClassStructure _structureFromClass(Plugin plugin, Class theClass) {
  assert(theClass != null);

  for (Class dClass in plugin.classes) {
    for (Method method in dClass.methods) {
      if (method.returns == theClass.name) {
        return ClassStructure.unspecifiedPrivate;
      }
    }

    for (Field field in dClass.fields) {
      if (field.type == theClass.name) {
        return ClassStructure.unspecifiedPrivate;
      }
    }
  }

  return ClassStructure.unspecifiedPublic;
}
