import 'package:flutter/material.dart';
import 'package:todolist/models/task_data.dart';
import 'package:todolist/screens/ToDoList.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //provide instance to children
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ToDoList(),
      ),
    );
  }
}
