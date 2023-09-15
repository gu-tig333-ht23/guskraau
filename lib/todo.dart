import 'package:flutter/material.dart';


class Todo {  // klass för element i sistan
  final String chore;
  bool isCompleted;

  Todo(this.chore, this.isCompleted);
}

class TodoProvider extends ChangeNotifier {  //Exepellista (egentligen inte nödvändig men har kvar för tydlighets skull)
  List<Todo> todos = [
    Todo('Städa', false),
    Todo('Laga mat', false),
    Todo('Träna', false),
    Todo('Plugga', false),
    Todo('Sova', false),
    Todo('Diska', false),
    Todo('Duscha', false),
    Todo('Läsa', false),
    Todo('Se film', false)
  ];

  // Lägger till en ny todo i listan och notifierar "lyssnare"
  void addTodo(String chore) {
    todos.add(Todo(chore, false));
    notifyListeners();
  }

  // Tar bort en todo från listan och notifierar "lyssnare"
  void removeTodo(Todo todo) {
    todos.remove(todo);
    notifyListeners();
  }

  // Returnerar en lista med filtrerade todos baserat på showCompleted
  List<Todo> getFilteredTodos(bool? showCompleted) {
    if (showCompleted == true) {
      return todos.where((todo) => todo.isCompleted).toList();
    } else if (showCompleted == false) {
      return todos.where((todo) => !todo.isCompleted).toList();
    } else {
      // Visa både avklarade och ej avklarade sysslor
      return todos;
    }
  }
}
