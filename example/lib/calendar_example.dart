import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/uikitlib.dart';

class CalendarExample extends StatefulWidget {
  const CalendarExample({Key? key}) : super(key: key);

  @override
  _CalendarExampleState createState() => _CalendarExampleState();
}

class _CalendarExampleState extends State<CalendarExample> {



  Widget createDateWidget(DateTime? dateTime) {
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

  @override
  void initState() {
    super.initState();

    var config = CalendarHelper.getConfig();
    config.calendarWidth=480;


    config.callBackStartTime = (dateTime) {
      return createDateWidget(dateTime);
    };

    config.callBackEndTime = (dateTime) {
      return createDateWidget(dateTime);
    };
    config.dayTextSize = 14;
    config.sureButtonWidth=200;

   WidgetsBinding.instance.addPostFrameCallback((callback){
     _openCalendar();
    });
  }

  String selectDate = "请选中时间";

  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("日历选择器"),
      ),
      body: LayoutBuilder(
        builder: (context,_){
          return GestureDetector(
            onTap: (){
              _openCalendar();
            },
            child: Container(
              child: Center(child: Text(selectDate,style: const TextStyle(fontSize: 14,color: Colors.red))),
                color: Colors.white),
          );
      }),
    );
  }

  void _openCalendar(){
    CalendarHelper.showDateDialog(context,
        aspectRatio: 1/2,   ///添加宽高比，设置的高度将失效。
        onClickOutSide: true,
        callBack: (startTime, endTime) {
          print("---${startTime.year}--${startTime.month}--${startTime.day}->");
          print("---${endTime.year}--${endTime.month}--${endTime.day}->");

          selectDate = "开始时间：${startTime.year}--${startTime.month}--${startTime.day}   "
              "结束时间：${endTime.year}--${endTime.month}--${endTime.day}";

          Toast.show(selectDate);

          setState(() {

          });
        });
  }
}
