class LibraryNode {
  LibraryNode(this.classes);

  final List<ClassNode> classes;
}

class ClassNode {
  ClassNode(this.name);

  final String name;
}