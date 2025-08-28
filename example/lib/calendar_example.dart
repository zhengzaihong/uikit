import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/uikit_lib.dart';
import 'package:intl/intl.dart';

class CalendarExample extends StatefulWidget {
  const CalendarExample({Key? key}) : super(key: key);

  @override
  _CalendarExampleState createState() => _CalendarExampleState();
}

class _CalendarExampleState extends State<CalendarExample> {

  @override
  void initState() {
    super.initState();
  }

  String selectDate = "日期选择器 style1";


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
                   DatePicker.simpleDateRangePicker(context,
                       width: 700,
                       height: 600,
                       backwardYear: 100,//当前时间的前100年
                       needYear: 120, ////当前时间的后20年
                       // initStartDate: DateTime(1992, 3, 31,10,22,44),//默认选中的开始时间
                       // initEndDate: DateTime(2002, 10, 31), //默认选中的结束时间
                       initStartDate: DateTime.tryParse("2022-02-27 13:27:00"),//默认选中的开始时间
                       initEndDate:DateTime.tryParse("2023-04-27 14:47:30"), //默认选中的结束时间
                       showColumn: [DateType.YEAR, DateType.MONTH, DateType.DAY,DateType.HOUR,DateType.MINUTE,DateType.SECOND],
                       maskColor:  const Color.fromRGBO(242, 242, 244, 0.7),//横向遮罩颜色
                       //设置选中的条目的遮罩色
                       selectionOverlay:  CupertinoPickerDefaultSelectionOverlay(
                         background: CupertinoColors.activeBlue.withAlpha(10),
                         capStartEdge: true,
                         capEndEdge: true,
                       ),
                       pickerVisibilityHeight: 200,
                       diameterRatio: 0.8,//设置曲率，越小越弯曲
                       itemExtent: 40,//每个item的高度
                       maskHeight: 40,//遮罩的高度
                       maskRadius: 0,//遮罩的圆角
                       //itemWidth: 100,//每个item的宽度
                       //vGap: 16,//垂直间距
                       //useMagnifier: true,//是否启用放大镜效果
                       //magnification: 1.5, //设置放大倍数
                       callBack: (date1,date2){
                        setState(() {
                          selectDate = "开始时间：${ DateFormat("yyyy-MM-dd HH:mm:ss").format(date1!)} "
                              " 结束时间：${ DateFormat("yyyy-MM-dd HH:mm:ss").format(date2!)} ";
                        });
                   });
                  },
                child:Center(child: Text(selectDate,style: const TextStyle(fontSize: 20,color: Colors.red))),
              ),


             const SizedBox(height: 40,),
             GestureDetector(
               onTap: (){
               },
               child:  Center(child: Text(selectDate,style: const TextStyle(fontSize: 20,color: Colors.red))),
             )
            ],
          );
      }),
    );
  }
}

