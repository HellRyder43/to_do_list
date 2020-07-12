import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/task_data.dart';

class ToDoListForm extends StatefulWidget {
  ToDoListForm(
      {this.id, this.parentTitle, this.parentStartDate, this.parentEndDate});

  final Guid id;
  final String parentTitle;
  final String parentStartDate;
  final String parentEndDate;

  @override
  _ToDoListFormState createState() => _ToDoListFormState();
}

class _ToDoListFormState extends State<ToDoListForm> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  TextEditingController startDate;
  TextEditingController endDate;
  DateTime pickedDateStart;
  DateTime pickedDateEnd;
  String newTitle = "";

  @override
  void initState() {
    super.initState();
    pickedDateStart = DateTime.now();
    pickedDateEnd = DateTime.now();
    startDate = TextEditingController(
        text: widget.parentStartDate != null ? widget.parentStartDate : "");
    endDate = TextEditingController(
        text: widget.parentEndDate != null ? widget.parentEndDate : "");
  }

  _pickedDateStart() async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: pickedDateStart,
      firstDate: pickedDateStart,
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (date != null) {
      setState(() {
        startDate = TextEditingController(
            text: formatDate(date, [dd, ' ', MM, ' ', 'yyyy']));
      });
    }
  }

  _pickedDateEnd() async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: pickedDateEnd,
      firstDate: pickedDateEnd,
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (date != null) {
      setState(() {
        endDate = TextEditingController(
            text: formatDate(date, [dd, ' ', MM, ' ', 'yyyy']));
      });
    }
  }

  String validateEmpty(String value) {
    if (value.isEmpty || value == null)
      return 'Please fill input a value';
    else
      return null;
  }

  void _submit() {
    if (_formKey.currentState.validate()) {
      String title;
      String startdate;
      String enddate;

      if (widget.id != null) {
        if (newTitle.isEmpty) {
          title = widget.parentTitle;
        } else {
          title = newTitle;
        }

        if (startDate != null && startDate.text != null) {
          startdate = startDate.text;
        } else {
          startdate = widget.parentStartDate;
        }

        if (endDate != null && endDate.text != null) {
          enddate = endDate.text;
        } else {
          enddate = widget.parentEndDate;
        }

        Provider.of<TaskData>(context, listen: false)
            .updateTask(widget.id, title, startdate, enddate, 'timeleft');
      } else {
        //Add new
        Provider.of<TaskData>(context, listen: false).addTask(
          Guid.newGuid,
          newTitle,
          startDate.text,
          endDate.text,
        );
      }

      Navigator.pop(context);
    } else {
      setState(() => _autoValidate = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Add new To-Do List',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color(0xFFFFC83D),
      ),
      body: SafeArea(
          child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('To-Do Title'),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5.0),
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: TextFormField(
                      initialValue: widget.parentTitle,
                      validator: validateEmpty,
                      onChanged: (value) {
                        setState(() {
                          newTitle = value;
                        });
                      },
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          hintText: "Please key in your To-Do title here",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text('Start Date'),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5.0),
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: TextFormField(
                      //initialValue: widget.parentStartDate,
                      controller: startDate,
                      validator: validateEmpty,
                      onTap: _pickedDateStart,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                          hintText: "Select Date",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.keyboard_arrow_down)),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text('Estimated End Date'),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5.0),
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: TextFormField(
                      //initialValue: widget.parentEndDate,
                      controller: endDate,
                      validator: validateEmpty,
                      onTap: _pickedDateEnd,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          hintText: "Select Date",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.keyboard_arrow_down)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).padding.bottom + 50,
        child: SafeArea(
          child: FlatButton(
            onPressed: _submit,
            color: Colors.black,
            textColor: Colors.white,
            child:
                Text(widget.parentTitle != null ? 'Update Now' : 'Create Now'),
          ),
        ),
      ),
    );
  }
}
