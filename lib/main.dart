import 'package:flutter/material.dart';

void main() {
  runApp(const TheApp());
}

class TheApp extends StatelessWidget {
  const TheApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: const TheHomePage(),
    );
  }
}

class Todo {
  final String chore;

  Todo(this.chore);
}

class TheHomePage extends StatelessWidget {
  const TheHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Todo> todos = [
      Todo('Städa'),
      Todo('Laga mat'),
      Todo('Träna'),
      Todo('Plugga'),
      Todo('Sova'),
      Todo('Diska'),
      Todo('Duscha'),
      Todo('Läsa'),
      Todo('Se film')
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Att göra'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTodoView()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: todos.map((todo) => _item(context, todo.chore)).toList(),
      ),
    );
  }

  Widget _item(BuildContext context, String chore) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(width: 2),
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
                chore,
                style: TextStyle(fontSize: 22),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(
            Icons.close,
            size: 30,
          ),
        ),
      ],
    );
  }
}

class AddTodoView extends StatelessWidget {
  const AddTodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lägg till ett nytt objekt'),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(40),
              child: Container(
                width: 350,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(width: 2),
                ),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Vad vill du lägga till i din lista?',
                      style: TextStyle(fontSize: 16.0, color: Colors.blueGrey),
                    ),
                  ),
                ),
              ),
            ),
            const Icon(
              Icons.add,
              size: 48,
              color: Colors.blueGrey,
            ),
          ],
        ),
      ),
    );
  }
}
