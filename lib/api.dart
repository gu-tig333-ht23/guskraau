import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:template/todo.dart';

const String ENDPOINT = 'https://todoapp-api.apps.k8s.gu.se';
const String apiKey = 'cddfa743-1300-4e97-aa14-0284935d4ebe';

// Getlist
Future<List<Todo>> getTodoItem() async {
  http.Response response =
      await http.get(Uri.parse('$ENDPOINT/todos?key=$apiKey'));
  String body = response.body;
  Map<String, dynamic> jsonResponse = jsonDecode(body);
  List<dynamic> todosJson = jsonResponse['todos'] as List<dynamic>;

  return todosJson.map((json) => Todo.fromJson(json)).toList();
  }

// AddItem
Future<void> addTodos(Todo todos) async {
  await http.post(
    Uri.parse('$ENDPOINT/todos?key=$apiKey'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(todos.toJson()),
  );
}

// Delete item
Future<void> deleteTodoItem(String id) async {
  await http.delete(Uri.parse('$ENDPOINT/todos/$id?key=$apiKey'));
}

//Update item
Future<void> updateTodoItem(Todo todos) async {
  final id = todos.id;
  await http.put(
   Uri.parse('$ENDPOINT/todos/$id?key=$apiKey'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(todos.toJson()),
  );
}