import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/the_home_page.dart';
import 'todo.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: const TheApp(),
    ),
  );
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