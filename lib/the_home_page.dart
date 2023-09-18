import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_todo_view.dart';
import 'todo.dart';


// Kod för att bygga upp homepage och sköta tillståndshantering   

class TheHomePage extends StatefulWidget {
  const TheHomePage({super.key});

  @override
  _TheHomePageState createState() => _TheHomePageState();
}

class _TheHomePageState extends State<TheHomePage> {
  bool? showCompleted;

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Padding(
          padding: EdgeInsets.only(left: 45),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'Att göra', 
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
        ),
        actions: [
          DropdownButton<bool?>(
            value: showCompleted,
            onChanged: (newValue) {
              setState(() {
                showCompleted = newValue;
              });
            },
            items: [
              DropdownMenuItem(
                value: null,
                child: Text('Alla sysslor'), // Visa både avklarade och ej avklarade
              ),
              DropdownMenuItem(
                value: false,
                child: Text('Ej avklarade'), // Visa endast ej avklarade todos
              ),
              DropdownMenuItem(
                value: true,
                child: Text('Avklarade'), // Visa endast avklarade todos
              ),
            ],
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTodoView()), // Öppna sidan för att lägga till ny todo
            );
          },
        ),
      ),
      body: ListView.builder(
        itemCount: todoProvider.getFilteredTodos(showCompleted).length,
        itemBuilder: (context, index) {
          return _item(
            context,
            todoProvider.getFilteredTodos(showCompleted)[index],
          );
        },
      ),
    );
  }

  // Widget för att hantera element i listan
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
              value: todo.isCompleted,
              onChanged: (bool? newValue) {
                if (newValue != null) {
                  setState(() {
                    todo.isCompleted = newValue;
                  });
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
                todo.chore,
                style: TextStyle(
                  fontSize: 22,
                  decoration: todo.isCompleted
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
            onTap: () {
              todoProvider.removeTodo(todo); // Ta bort todo när användaren klickar på stängknappen
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


