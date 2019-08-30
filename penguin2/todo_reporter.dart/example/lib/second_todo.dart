import 'package:todo_reporter/todo_reporter.dart';

part "second_todo.g.dart";

@Class(javaPackage: 'com.potample')
class SecondTodo {}

@Class(javaPackage: 'com.example')
class MoreTodos {
  final String something;

  const MoreTodos(this.something);
}
