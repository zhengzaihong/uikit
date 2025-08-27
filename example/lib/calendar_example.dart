import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/uikit_lib.dart';

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
    config.calendarWidth = 480;

    config.callBackStartTime = (dateTime) {
      return createDateWidget(dateTime);
    };

    config.callBackEndTime = (dateTime) {
      return createDateWidget(dateTime);
    };
    config.dayTextSize = 14;
    config.sureButtonWidth=200;
  }

  String selectDate = "日期选择器 style1";
  String selectDate2 = "日期选择器 style2";

  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("日历选择器"),
      ),
      body: LayoutBuilder(
        builder: (context,_){
          return Column(
            children: [
              const SizedBox(height: 40,),
              GestureDetector(
                  onTap: (){
                   DatePicker.simpleDatePicker(context,
                       width: 350,
                       height: 470,
                       startDate: DateModel(1992, 3, 31),
                       endDate: DateModel(2002, 10, 31),
                       callBack: (date1,data2){
                        setState(() {
                          selectDate = "开始时间：${date1?.year}/${date1?.month}/${date1?.day}   结束时间：${data2?.year}/${data2?.month}/${data2?.day}";
                        });
                   });
                  },
                child:  Center(child: Text(selectDate,style: const TextStyle(fontSize: 20,color: Colors.red))),
              ),


             const SizedBox(height: 40,),
             GestureDetector(
               onTap: (){
                 _openCalendar();
               },
               child:  Center(child: Text(selectDate2,style: const TextStyle(fontSize: 20,color: Colors.red))),
             )
            ],
          );
      }),
    );
  }

  void _openCalendar(){
    CalendarHelper.showDateDialog(context,
        aspectRatio: 1/2,   ///添加宽高比，设置的高度将失效。
        onClickOutSide: true,
        callBack: (startTime, endTime) {
          setState(() {
            selectDate2 = "开始时间：${startTime.year}/${startTime.month}/${startTime.day}   "
                "结束时间：${endTime.year}/${endTime.month}/${endTime.day}";

            Toast.show(selectDate2);
          });
        });
  }
}

