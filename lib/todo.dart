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

  List<Todo> get todos => _todos;

  void setShowCompleted(bool? value) {
    _showCompleted = value;
    notifyListeners();
  }

  Future<void> fetchAndSetTodos() async {
    try {
      final response = await http.get(Uri.parse('$ENDPOINT/todos?key=$apiKey'));

      if (response.statusCode == 200) {
        List<dynamic> todosJson = jsonDecode(response.body);
        _todos = todosJson.map((json) => Todo.fromJson(json)).toList();
        notifyListeners();
      } else {
        throw Exception('Kan ej ladda lista');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addTodo(String title) async {
  try {
    final newTodo = Todo(id: '', title: title, done: false);
    await addTodos(newTodo);
    await fetchAndSetTodos(); // Hämta alla todos igen för att uppdatera med rätt ID
  } catch (error) {
    print('Fel vid addering av Todo: $error');
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
}


