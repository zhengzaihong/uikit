import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uikit_plus/uikit_lib.dart';
import 'package:intl/intl.dart';

class DateSelectExample extends StatefulWidget {

  const DateSelectExample({Key? key}) : super(key: key);

  @override
  _DateSelectExampleState createState() => _DateSelectExampleState();
}

class _DateSelectExampleState extends State<DateSelectExample> {

  @override
  void initState() {
    super.initState();
  }

  String selectDate = "";


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("日历选择器"),
      ),
      body: LayoutBuilder(
        builder: (context,_){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40,width: double.infinity),

              FilledButton(onPressed:(){
                DatePicker.showDateRangePicker(
                    context: context,
                    controller: DateController(),
                    width: 700,
                    height: 600,
                    datePickerStrings: const DatePickerStrings.zh(), //显示的语种
                    forwardYears: 100,//当前时间的前100年
                    totalYears: 120, //总共120年 [可选时间范围，前100年-后20年]
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
                    pickerVisibilityHeight: 200, //滚轮的可见高度
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
              }, child: const Text("Dialog时间范围选择")),
              vGap(20),
              FilledButton(onPressed:(){
                DatePicker.showDateRangeModalBottomSheet(
                    context: context,
                    controller: DateController(),
                    height: 600,
                    pickerDecoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.horizontal(start: Radius.circular(20),end: Radius.circular(20))
                    ),
                    datePickerStrings: const DatePickerStrings.zh(), //显示的语种
                    forwardYears: 100,//当前时间的前100年
                    totalYears: 120, //总共120年 [可选时间范围，前100年-后20年]
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
                    pickerVisibilityHeight: 200, //滚轮的可见高度
                    diameterRatio: 0.8,//设置曲率，越小越弯曲
                    itemExtent: 40,//每个item的高度
                    maskHeight: 40,//遮罩的高度
                    maskRadius: 0,//遮罩的圆角
                    itemWidth: 100,//每个item的宽度
                    //vGap: 16,//垂直间距
                    //useMagnifier: true,//是否启用放大镜效果
                    //magnification: 1.5, //设置放大倍数
                    callBack: (date1,date2){
                      setState(() {
                        selectDate = "开始时间：${ DateFormat("yyyy-MM-dd HH:mm:ss").format(date1!)} "
                            " 结束时间：${ DateFormat("yyyy-MM-dd HH:mm:ss").format(date2!)} ";
                      });
                    });
              }, child: const Text("ModalBottomSheet时间范围选择")),

              vGap(20),
              FilledButton(onPressed:(){
                DatePicker.showDatePicker(
                    context: context,
                    controller: DateController(),
                    width: 400,
                    height: 330,
                    datePickerStrings: const DatePickerStrings.zh(), //显示的语种
                    forwardYears: 100,//当前时间的前100年
                    totalYears: 120, //总共120年 [可选时间范围，前100年-后20年]
                    initStartDate: DateTime.tryParse("2022-02-27 13:27:00"),//默认选中的开始时间
                    showColumn: [DateType.YEAR, DateType.MONTH, DateType.DAY,DateType.HOUR,DateType.MINUTE,DateType.SECOND],
                    diameterRatio: 0.9,
                    pickerVisibilityHeight: 200,
                    callBack: (date1,date2){
                      setState(() {
                        selectDate = "选择了：${ DateFormat("yyyy-MM-dd HH:mm:ss").format(date1!)} ";
                      });
                    });
              }, child: const Text("Dialog日期选择")),

              vGap(20),
              FilledButton(onPressed:(){
                DatePicker.showDatePicker(
                    context: context,
                    controller: DateController(),
                    width: 300,
                    height: 280,
                    datePickerStrings: const DatePickerStrings.zh(), //显示的语种
                    initStartDate: DateTime.tryParse("2022-02-27 13:27:00"),//默认选中的开始时间
                    showColumn: [DateType.HOUR,DateType.MINUTE,DateType.SECOND],
                    diameterRatio: 0.9,
                    callBack: (date1,date2){
                      setState(() {
                        selectDate = "选择了：${ DateFormat("HH:mm:ss").format(date1!)} ";
                      });
                    });
              }, child: const Text("Dialog时间选择")),

              vGap(20),
              FilledButton(onPressed:(){
                DatePicker.showDateModalBottomSheet(
                    context: context,
                    controller: DateController(),
                    height: 330,
                    pickerDecoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadiusDirectional.horizontal(start: Radius.circular(20),end: Radius.circular(20))
                    ),
                    datePickerStrings: const DatePickerStrings.zh(), //显示的语种
                    forwardYears: 100,//当前时间的前100年
                    totalYears: 120, //总共120年 [可选时间范围，前100年-后20年]
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
                    pickerVisibilityHeight: 200, //滚轮的可见高度
                    diameterRatio: 0.8,//设置曲率，越小越弯曲
                    itemExtent: 40,//每个item的高度
                    maskHeight: 40,//遮罩的高度
                    maskRadius: 0,//遮罩的圆角
                    itemWidth: 100,//每个item的宽度
                    //vGap: 16,//垂直间距
                    //useMagnifier: true,//是否启用放大镜效果
                    //magnification: 1.5, //设置放大倍数
                    callBack: (date1,date2){
                      setState(() {
                        selectDate = "选择了：${ DateFormat("yyyy-MM-dd HH:mm:ss").format(date1!)} ";
                      });
                    });
              }, child: const Text("ModalBottomSheet时间选择")),

              vGap(60),
              Text(selectDate,style: const TextStyle(color: Colors.red))
            ],
          );
      }),
    );
  }
}

