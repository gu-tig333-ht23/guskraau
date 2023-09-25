import 'dart:convert';
import 'package:flutter/material.dart';
import 'api.dart';
import 'package:http/http.dart' as http;

class Todo {
  final String? id;
  final String title;
  bool done;

  Todo({
    required this.title,
    this.id,
    required this.done,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as String?,
      title: json['title'] as String,
      done: json['done'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'done': done,
    };
  }
}

class TodoProvider extends ChangeNotifier {
  List<Todo> _todos = [];
  bool? _showCompleted;
  bool? get showCompleted => _showCompleted;

  void setShowCompleted(bool? value) {
    _showCompleted = value;
    notifyListeners();
  }

  Future<List<Todo>> fetchTodos() async {
    try {
      final response = await http.get(Uri.parse('$ENDPOINT/todos?key=$apiKey'));
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        List<dynamic> todosJson = jsonDecode(response.body);
        return todosJson.map((json) => Todo.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load todos');
      }
    } catch (error) {
      print('Error: $error');
      rethrow;
    }
  }

  Future<void> addTodo(String title) async {
    try {
      final newTodo = Todo(id: '', title: title, done: false);
      await addTodos(newTodo);
      _todos.add(newTodo);
      notifyListeners();
    } catch (error) {
      print('Fel vid läggning till av Todo: $error');
    }
  }

  Future<void> removeTodo(Todo todo) async {
    try {
      await deleteTodoItem(todo.id ?? '');
      _todos.remove(todo);
      notifyListeners();
    } catch (error) {
      print('Fel vid borttagning av Todo: $error');
    }
  }

  Future<void> updateTodo(Todo todo) async {
    try {
      await updateTodoItem(todo);
      notifyListeners();
    } catch (error) {
      print('Fel vid uppdatering av Todo: $error');
    }
  }

  List<Todo> get todos => _todos;
  List<Todo> get completedTodos => _todos.where((todo) => todo.done).toList();
  List<Todo> get nonCompletedTodos =>
      _todos.where((todo) => !todo.done).toList();
}
