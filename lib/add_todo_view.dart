import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'todo.dart';

class AddTodoView extends StatefulWidget {
  const AddTodoView({Key? key}) : super(key: key);

  @override
  _AddTodoViewState createState() => _AddTodoViewState();
}

class _AddTodoViewState extends State<AddTodoView> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lägg till ett nytt objekt'),
        backgroundColor: Colors.teal,
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
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: 'Skriv in en ny uppgift',
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                String newChore = _textEditingController.text;
                if (newChore.isNotEmpty) {
                  // Lägg till den nya Todo med API-anrop
                  await todoProvider.addTodo(newChore);
                  _textEditingController.clear();
                  Navigator.pop(context);
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),
              ),
              child: Text('Lägg till'),
            ),
          ],
        ),
      ),
    );
  }
}

