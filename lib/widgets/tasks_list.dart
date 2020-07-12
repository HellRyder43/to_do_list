import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist/screens/ToDoListForm.dart';
import 'package:todolist/widgets/task_tile.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/task_data.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          padding: EdgeInsets.all(8.0),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final task = taskData.tasks[index];
            //Slide to Delete functionality
            return Dismissible(
              key: UniqueKey(),
              background: Container(
                padding: EdgeInsets.all(10.0),
                color: Colors.red,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                taskData.deleteTask(task);
                //Show snack bar item is deleted
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text("Item deleted")));
              },
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ToDoListForm(
                        id: task.id,
                        parentTitle: task.title,
                        parentStartDate: task.start,
                        parentEndDate: task.end,
                      ),
                    ),
                  );
                },
                child: TaskTile(
                  title: task.title,
                  isChecked: task.isChecked,
                  dateStart: task.start,
                  dateEnd: task.end,
                  checkboxCallback: (checkboxState) {
                    taskData.updateCheckbox(task);
                  },
                  longPressCallback: () {
                    taskData.deleteTask(task);
                  },
                ),
              ),
            );
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }
}
