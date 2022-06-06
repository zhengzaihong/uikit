import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/uiktlib.dart';

class CalendarExample extends StatefulWidget {
  const CalendarExample({Key? key}) : super(key: key);

  @override
  _CalendarExampleState createState() => _CalendarExampleState();
}

class _CalendarExampleState extends State<CalendarExample> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(),
      body: InkWell(
          onTap: () {
            var config = CalendarHelper.getConfig();
            config.sureButtonWidth = 200;

            config.callBackStartTime = (dateTime) {
              return createDateWidget(dateTime);
            };

            config.callBackEndTime = (dateTime) {
              return createDateWidget(dateTime);
            };
            config.dayTextSize = 10;
            config.sureButton = const Text("sure",style: TextStyle(fontSize: 10));
            config.sureButtonBgStyle =  BoxDecoration(
              color: Colors.red,
              borderRadius: const BorderRadius.all(
                  Radius.circular(24.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.red.withOpacity(0.6),
                  blurRadius: 8,
                  offset: const Offset(4, 4),
                ),
              ],
            );

            CalendarHelper.showDateDialog(context,
                callBack: (startTime, endTime) {
              print(
                  "---${startTime.year}--${startTime.month}--${startTime.day}->");
              print("---${endTime.year}--${endTime.month}--${endTime.day}->");
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

  Widget createDateWidget(DateTime? dateTime){
    var checkedText = const TextStyle(
      color: Colors.black54,
      fontSize: 16,
    );
    return Text(
      dateTime == null
          ? "--/--"
          : "${dateTime.year}年${dateTime.month}月${dateTime.day}日",
      style: checkedText,
    );
  }
}
