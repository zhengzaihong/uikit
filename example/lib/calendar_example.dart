
import 'package:flutter/material.dart';
import 'package:uikit/calendar/calendar_helper.dart';

class CalendarExample extends StatefulWidget {
  const CalendarExample({Key? key}) : super(key: key);

  @override
  _CalendarExampleState createState() => _CalendarExampleState();
}

class _CalendarExampleState extends State<CalendarExample> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
      body:   InkWell(
          onTap: () {
            var config = CalendarHelper.getConfig();
            config.sureButtonWidth = 200;
            var checkedText = const TextStyle(
              color: Colors.black54,
              fontSize: 16,
            );

            config.checkedEndTimeStyle = checkedText;
            config.checkedStartTimeStyle = checkedText;
            CalendarHelper.showDateDialog(context,
                callBack: (startTime, endTime) {
                  print(
                      "---${startTime.year}--${startTime.month}--${startTime.day}->");
                  print(
                      "---${endTime.year}--${endTime.month}--${endTime.day}->");
                });
          },
          child: Container(
            margin: EdgeInsets.only(top: 20),
            color: Colors.lightBlue,
            padding: EdgeInsets.all(30),
            child: Text("日历"),
          )),
    ));
  }
}
