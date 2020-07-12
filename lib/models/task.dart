import 'package:flutter_guid/flutter_guid.dart';

class Task {
  //Define constructor with isCheck defaulted to false for checkbox
  Task({
    this.id,
    this.title,
    this.isChecked = false,
    this.start,
    this.end,
  });

  final Guid id;
  String title;
  bool isChecked;
  String start;
  String end;

  //Provide this function to toggle boolean value
  void toggleDone() {
    isChecked = !isChecked;
  }
}
