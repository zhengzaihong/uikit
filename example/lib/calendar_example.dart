import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_uikit_forzzh/uikitlib.dart';

class CalendarExample extends StatefulWidget {
  const CalendarExample({Key? key}) : super(key: key);

  @override
  _CalendarExampleState createState() => _CalendarExampleState();
}

class _CalendarExampleState extends State<CalendarExample> {

  var config = CalendarHelper.getConfig();


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
    config.sureButtonWidth = 200;

    config.callBackStartTime = (dateTime) {
      return createDateWidget(dateTime);
    };

    config.callBackEndTime = (dateTime) {
      return createDateWidget(dateTime);
    };
    config.dayTextSize = 14;
    config.sureButton =
    const Text("确定", style: TextStyle(fontSize: 14));
    config.sureButtonBgStyle = BoxDecoration(
      color: Colors.lightBlue,
      borderRadius: const BorderRadius.all(Radius.circular(24.0)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.red.withOpacity(0.6),
          blurRadius: 8,
          offset: const Offset(4, 4),
        ),
      ],
    );


   WidgetsBinding.instance?.addPostFrameCallback((callback){

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
