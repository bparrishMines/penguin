import 'package:todo_reporter/todo_reporter.dart';

part "second_todo.g.dart";

@PenguinClass(javaPackage: 'com.potample')
class SecondTodo {}

@PenguinClass(javaPackage: 'com.example')
class MoreTodos {
  final String something;

  const MoreTodos(this.something);
}
