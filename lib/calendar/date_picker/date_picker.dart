import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../ext/top_view.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024/12/4
/// create_time: 11:09
/// describe: 日期选择器，一次可选择开始和结束日期
///
typedef DateBuilder = Widget Function(int date);

class DatePicker extends StatefulWidget {

  final DateBuilder yearBuilder;
  final DateBuilder monthBuilder;
  final DateBuilder dayBuilder;
  final BoxDecoration? pickerDecoration;
  final DateController controller;
  final double height;
  final double width;
  final bool scrollLoop;
  final double vGap;
  final EdgeInsetsGeometry? padding;
  final Widget startWidget;
  final Widget endWidget;
  final double pickerVisibilityHeight;
  final double itemHeight;
  final double itemWidth;
  final double maskHeight;
  final double maskRadius;
  final Color? maskColor;
  final Color? itemBackgroundColor;
  //默认选中的日期
  final DateModel? startDate;
  final DateModel? endDate;
  //倒推的年份个数
  final int backwardYear;
  //年份的个数
  final int needYear;
  final Duration duration;
  final Curve curve;
  final Widget? action;

  const DatePicker(
      {
        required this.yearBuilder,
        required this.monthBuilder,
        required this.dayBuilder,
        required this.startWidget,
        required this.endWidget,
        required this.controller,
        this.startDate,
        this.endDate,
        this.pickerDecoration,
        this.height = 500,
        this.width = 400,
        this.scrollLoop = true,
        this.padding,
        this.vGap = 16,
        this.pickerVisibilityHeight = 140,
        this.itemHeight = 40,
        this.itemWidth = 100,
        this.maskHeight = 40,
        this.maskRadius = 0,
        this.maskColor = const Color.fromRGBO(242, 242, 244, 0.7),
        this.itemBackgroundColor,
        this.backwardYear = 50,
        this.needYear = 110,
        this.duration = const Duration(milliseconds: 300),
        this.curve = Curves.easeInOutCubic,
        this.action,
        Key? key}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();

  ///展示选择器基础示例，不满足样式外部可自定义。
  static Future<dynamic> simpleDatePicker(
      BuildContext context,
      {bool barrierDismissible = true,
        double height = 500,
        double width = 400,
        int needYear = 110,
        double vGap = 16,
        BoxDecoration? pickerDecoration,
        DateModel? startDate,
        DateModel? endDate,
        double pickerVisibilityHeight = 140,
        double itemHeight = 40,
        double itemWidth = 100,
        double maskHeight = 40,
        double maskRadius = 0,
        int backwardYear = 50,
        Color? maskColor = const Color.fromRGBO(242, 242, 244, 0.7),
        Duration duration = const Duration(milliseconds: 500),
        Curve curve = Curves.easeInOutCubic,
        Function(DateModel? startDate, DateModel? endDate)? callBack}) {
    final  controller = DateController();
    return showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return DatePicker(
            controller: controller,
            pickerDecoration: pickerDecoration,
            width: width,
            height: height,
            needYear: needYear,
            startDate: startDate,
            endDate: endDate,
            backwardYear: backwardYear,
            vGap: vGap,
            pickerVisibilityHeight: pickerVisibilityHeight,
            itemHeight: itemHeight,
            itemWidth: itemWidth,
            maskHeight: maskHeight,
            maskRadius: maskRadius,
            maskColor: maskColor,
            duration: duration,
            curve: curve,
            startWidget: const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text('开始日期：',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
            ),
            endWidget: const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text('结束日期：',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
            ),
            yearBuilder: (year) {
              return Center(
                child: Text(
                  "$year年",
                  style: const TextStyle(
                      color: Color.fromRGBO(21, 21, 21, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.bold)
                ),
              );
            },
            monthBuilder: (month) {
              return Container(
                alignment: Alignment.center,
                child: Text(
                  "$month月",
                  style: const TextStyle(
                      color: Color.fromRGBO(21, 21, 21, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.bold)
                ),
              );
            },
            dayBuilder: (day) {
              return Container(
                alignment: Alignment.center,
                child: Text(
                  "$day日",
                  style: const TextStyle(
                      color: Color.fromRGBO(21, 21, 21, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.bold)
                ),
              );
            },
            action: GestureDetector(
              onTap: () {
                final startDate = controller.getStartDate();
                final endDate = controller.getEndDate();
                callBack?.call(startDate, endDate);
                Navigator.pop(context, [startDate, endDate]);
              },
              child: Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 30),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text("确定",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  )),
            ),
          );
        });
  }
}

class _DatePickerState extends State<DatePicker> {

  late int _startYear;
  late DateModel _startDate;

  late int _endYear;
  late DateModel _endDate;

  final startYearScrollController = FixedExtentScrollController();
  final startMonthScrollController = FixedExtentScrollController();
  final startDayScrollController = FixedExtentScrollController();

  final endYearScrollController = FixedExtentScrollController();
  final endMonthScrollController = FixedExtentScrollController();
  final endDayScrollController = FixedExtentScrollController();

  final now = DateTime.now();

  int abs(int i,int j){
    if(i<j){
      return j-i;
    }
    return i-j;
  }

  DateModel startDate(){
    return DateModel(_startDate.year, _startDate.month+1, _startDate.day);
  }
  DateModel endDate(){
    return DateModel(_endDate.year,_endDate.month+1,_endDate.day);
  }

  @override
  void initState() {
    super.initState();

    widget.controller.bind(this);

    _startDate = widget.startDate ?? DateModel(now.year, now.month-1, now.day-1);
    _startYear =  now.year-widget.backwardYear;
    _endDate = widget.endDate ?? DateModel(now.year, now.month-1, now.day-1);
    _endYear = _endDate.year;

    if(widget.startDate != null){
      _startDate.month = _startDate.month-1;
      _startDate.day = _startDate.day-1;
      if(_startDate.day == 0){
        _startDate.day =1;
      }
    }
    if(widget.endDate != null){
      _endDate.month = _endDate.month-1;
      _endDate.day = _endDate.day-1;
      if(_endDate.day == 0){
        _endDate.day =1;
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _animateTo();
    });
  }

  void _animateTo() {
    startYearScrollController.animateToItem(abs(_startDate.year,_startYear), duration:widget.duration, curve:widget.curve);
    startMonthScrollController.animateToItem(_startDate.month, duration:widget.duration, curve:widget.curve);
    startDayScrollController.animateToItem(_startDate.day, duration:widget.duration, curve:widget.curve);

    endYearScrollController.animateToItem(abs(_endDate.year,_endYear), duration:widget.duration, curve:widget.curve);
    endMonthScrollController.animateToItem(_endDate.month, duration:widget.duration, curve:widget.curve);
    endDayScrollController.animateToItem(_endDate.day, duration:widget.duration, curve:widget.curve);
  }

  @override
  void dispose() {
    startYearScrollController.dispose();
    startMonthScrollController.dispose();
    startDayScrollController.dispose();

    endYearScrollController.dispose();
    endMonthScrollController.dispose();
    endDayScrollController.dispose();
    widget.controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant DatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      widget.controller.bind(this);
    }
  }

  Widget _buildDatePicker(DateModel dateModel,int startYear,bool isStart) {
    return SizedBox(
      width: widget.width,
      child:StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return  Stack(
              children: [
                Container(
                  height: widget.pickerVisibilityHeight,
                  alignment: Alignment.center,
                  child: Container(
                    width:widget.width,
                    height: widget.maskHeight,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(widget.maskRadius),
                        color: widget.maskColor),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: widget.itemWidth,
                      height: widget.pickerVisibilityHeight,
                      child: CupertinoPicker(
                        scrollController:isStart?startYearScrollController:endYearScrollController,
                        itemExtent: widget.itemHeight,
                        looping: widget.scrollLoop,
                        onSelectedItemChanged: (index) {
                          dateModel.year = index + startYear;
                          var maxDay = _getMonthDay(dateModel.year, dateModel.month + 1);
                          if (dateModel.day + 1 > maxDay) {
                            dateModel.day = maxDay - 1;
                          }
                          // _animateTo();
                        },
                        children: List<Widget>.generate(widget.needYear, (index) {
                          return widget.yearBuilder.call(startYear + index);
                        }),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: widget.itemWidth,
                      height: widget.pickerVisibilityHeight,
                      child: CupertinoPicker(
                        scrollController:isStart? startMonthScrollController:endMonthScrollController,
                        itemExtent: widget.itemHeight,
                        looping: widget.scrollLoop,
                        onSelectedItemChanged: (index) {
                          dateModel.month = index;
                          var maxDay = _getMonthDay(dateModel.year, dateModel.month + 1);
                          if (dateModel.day + 1 > maxDay) {
                            dateModel.day = maxDay - 1;
                          }
                          // _animateTo();
                        },
                        children: List<Widget>.generate(12, (index) {
                          return widget.monthBuilder.call(index + 1);
                        }),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: widget.itemWidth,
                      height: widget.pickerVisibilityHeight,
                      child: CupertinoPicker(
                          scrollController: isStart?startDayScrollController:endDayScrollController,
                          itemExtent: widget.itemHeight,
                          looping: widget.scrollLoop,
                          onSelectedItemChanged: (index) {
                            dateModel.day = index+1;
                          },
                          children: List<Widget>.generate(_getMonthDay(dateModel.year, dateModel.month + 1), (index) {
                            return widget.dayBuilder.call(index + 1);
                          })
                      ),
                    )
                  ],
                )
              ],
            );
          }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          width: widget.width,
          height: widget.height,
          padding: widget.padding,
          decoration: widget.pickerDecoration ?? BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              vGap(widget.vGap),
              widget.startWidget,
              vGap(widget.vGap),
              _buildDatePicker(_startDate,_startYear,true),
              vGap(widget.vGap),
              widget.endWidget,
              vGap(widget.vGap),
              _buildDatePicker(_endDate,_endYear,false),
              const Spacer(),
              widget.action??Container(),
              vGap(widget.vGap),
            ],
          ),
        ),
      ),
    );
  }



  int _getMonthDay(int year, int month) {
    final months = <int, int>{
      1: 31,
      2: 28,
      3: 31,
      4: 30,
      5: 31,
      6: 30,
      7: 31,
      8: 31,
      9: 30,
      10: 31,
      11: 30,
      12: 31
    };
    if (month != 2) {
      return months[month]!;
    }
    if (year % 400 == 0) {
      return 29;
    }
    if (year % 4 == 0 && year % 100 != 0) {
      return 29;
    }
    return 28;
  }
}


class DateModel {
  int year;
  int month;
  int day;
  DateModel(this.year, this.month, this.day);

  Map<String, dynamic> toJson() {
    return {"year": year, "month": month, "day": day};
  }
}

class DateController{

  _DatePickerState? _state;

  DateModel? getStartDate(){
    return _state?.startDate();
  }

  DateModel? getEndDate(){
    return _state?.endDate();
  }

  void bind(_DatePickerState _datePickerState) {
    _state = _datePickerState;
  }

  void dispose() {
    _state = null;
  }
}