import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:todolist/models/task.dart';
import 'dart:collection';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [
//    Task(
//        id: Guid.newGuid,
//        title: 'Beli',
//        start: '12 July 2020',
//        end: '13 July 2020',
//        timeLeft: '3 hrs 3 min')
  ];

  //Creates protection so that other file cannot add new object
  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  //Returns task count
  int get taskCount {
    return _tasks.length;
  }

  //Add new todos using this function
  void addTask(Guid id, String title, String start, String end) {
    final task = Task(id: id, title: title, start: start, end: end);
    _tasks.add(task);
    notifyListeners();
  }

  //Update todos using this function
  void updateTask(
      Guid id, String title, String start, String end, String timeleft) {
    final taskToBeUpdated = _tasks.firstWhere((element) => element.id == id);
    taskToBeUpdated.title = title;
    taskToBeUpdated.start = start;
    taskToBeUpdated.end = end;

    notifyListeners();
  }

  //Toggle checkbox checked value
  void updateCheckbox(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  //Delete a t'odo item
  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
