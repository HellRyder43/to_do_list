import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:todolist/widgets/countDownTimer.dart';

class TaskTile extends StatefulWidget {
  TaskTile(
      {this.isChecked,
      this.title,
      this.dateStart,
      this.dateEnd,
      this.checkboxCallback,
      this.longPressCallback});

  final bool isChecked;
  final String title;
  final String dateStart;
  final String dateEnd;
  final Function checkboxCallback;
  final Function longPressCallback;

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  int getTimeLeft() {
    var parsedStartDate = DateFormat('dd MMMM yyyy').parse(widget.dateStart);
    var parsedEndDate = DateFormat('dd MMMM yyyy').parse(widget.dateEnd);

    //Get difference time in seconds and pass to other widget
    int difference = parsedEndDate.difference(DateTime.now()).inSeconds;
    return difference;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onLongPress: widget.longPressCallback,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0))),
          color: Colors.white,
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 30.0, 8.0, 8.0),
                child: Text(
                  widget.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              'Start Date',
                              style: TextStyle(
                                color: Color(0xFF9e9e9e),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              widget.dateStart,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              'End Date',
                              style: TextStyle(
                                color: Color(0xFF9e9e9e),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              widget.dateEnd,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              'Time left',
                              style: TextStyle(
                                color: Color(0xFF9e9e9e),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            CountDownTimer(
                              secondsRemaining: getTimeLeft(),
                              whenTimeExpires: () {},
                              countDownTimerStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ])),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                decoration: BoxDecoration(
                    color: Color(0xFFE2DCC6),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'Status',
                          style: TextStyle(
                            color: Color(0xFF8f8f8f),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          widget.isChecked ? 'Completed' : 'Incomplete',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text('Tick if completed'),
                        Checkbox(
                          activeColor: Color(0xFFFFC83D),
                          value: widget.isChecked,
                          onChanged: widget.checkboxCallback,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
