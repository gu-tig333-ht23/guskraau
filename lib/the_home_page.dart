import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_todo_view.dart';
import 'todo.dart';

class TheHomePage extends StatelessWidget {
  const TheHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          'Att göra',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        actions: [
          DropdownButton<bool?>(
            value: todoProvider.showCompleted,
            onChanged: (newValue) {
              todoProvider.setShowCompleted(newValue);
            },
            items: [
              DropdownMenuItem(
                value: null,
                child: Text('Alla sysslor'),
              ),
              DropdownMenuItem(
                value: false,
                child: Text('Ej avklarade'),
              ),
              DropdownMenuItem(
                value: true,
                child: Text('Avklarade'),
              ),
            ],
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AddTodoView()),
            );
          },
        ),
      ),
      body: FutureBuilder<List<Todo>>(
        future: todoProvider.fetchTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Fel: ${snapshot.error}'));
          } else {
            final todos = snapshot.data ?? [];
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                if (todoProvider.showCompleted == null ||
                    (todoProvider.showCompleted == todo.done)) {
                  return _item(context, todo);
                }
                return SizedBox.shrink();
              },
            );
          }
        },
      ),
    );
  }

  Widget _item(BuildContext context, Todo todo) {
    final todoProvider = Provider.of<TodoProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Transform.scale(
            scale: 1.5,
            child: Checkbox(
              value: todo.done,
              onChanged: (bool? newValue) async {
                if (newValue != null) {
                  todo.done = newValue;
                  await todoProvider.updateTodo(todo);
                }
              },
              activeColor: Colors.teal,
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                todo.title,
                style: TextStyle(
                  fontSize: 22,
                  decoration: todo.done
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: () async {
              await todoProvider.removeTodo(todo);
            },
            child: Icon(
              Icons.close,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}
