import 'package:flutter/material.dart';
import 'calendar_config.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/12/2
/// create_time: 16:48
/// describe: 日历
///
class CustomCalendarView extends StatefulWidget {

  const CustomCalendarView(
      {Key? key,
        this.initialStartDate,
        this.initialEndDate,
        this.startEndDateChange,
        this.minimumDate,
        this.maximumDate,
        required this.calendarConfig,
        this.allowSameDate = true

      })
      : super(key: key);

  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final CalendarConfig calendarConfig;
  final bool? allowSameDate;

  final Function(DateTime, DateTime)? startEndDateChange;

  @override
  _CustomCalendarViewState createState() => _CustomCalendarViewState();
}

class _CustomCalendarViewState extends State<CustomCalendarView> {

  List<DateTime> dateList = <DateTime>[];
  DateTime currentMonthDate = DateTime.now();
  DateTime? startDate;
  DateTime? endDate;
  late CalendarConfig calendarConfig;

  @override
  void initState() {
    calendarConfig = widget.calendarConfig;
    setListOfDate(currentMonthDate);
    if (widget.initialStartDate != null) {
      startDate = widget.initialStartDate;
    }
    if (widget.initialEndDate != null) {
      endDate = widget.initialEndDate;
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setListOfDate(DateTime monthDate) {
    dateList.clear();
    final DateTime newDate = DateTime(monthDate.year, monthDate.month, 0);
    int previousMothDay = 0;
    ///如果是上月周末则会多占用一行
    if (newDate.weekday < 7) {
      previousMothDay = newDate.weekday;
      for (int i = 1; i <= previousMothDay; i++) {
        dateList.add(newDate.subtract(Duration(days: previousMothDay - i)));
      }
    }
    ///7*6 最大需要6行
    for (int i = 0; i < (42 - previousMothDay); i++) {
      dateList.add(newDate.add(Duration(days: i + 1)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: calendarConfig.preNextPadding,
          child: Row(
            children: <Widget>[

              Padding(
                padding: calendarConfig.yearWidgetPadding,
                child: Container(
                  height: calendarConfig.yearWidgetHeight,
                  width: calendarConfig.yearWidgetWidth,
                  decoration: calendarConfig.yearWidgetDecoration,
                  child: Material(
                    color: Colors.transparent,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentMonthDate = DateTime.utc(currentMonthDate.year-1,
                              currentMonthDate.month,
                              currentMonthDate.day,
                              currentMonthDate.hour,
                              currentMonthDate.minute,
                              currentMonthDate.second);
                          setListOfDate(currentMonthDate);
                        });
                      },
                      child: calendarConfig.preYearWidget,
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Center(
                  child: Row(
                     mainAxisSize: MainAxisSize.min,
                      children: [
                    Padding(
                      padding: calendarConfig.monthWidgetPadding,
                      child: Container(
                        height: calendarConfig.monthWidgetHeight,
                        width: calendarConfig.monthWidgetWidth,
                        decoration: calendarConfig.monthWidgetDecoration,
                        child: Material(
                          color: Colors.transparent,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                currentMonthDate = DateTime(currentMonthDate.year,
                                    currentMonthDate.month, 0);
                                setListOfDate(currentMonthDate);
                              });
                            },
                            child: calendarConfig.preMonthWidget,
                          ),
                        ),
                      ),
                    ),

                    Text(
                      "${currentMonthDate.year} ${
                          calendarConfig.getDateFormat()==1? "-":
                          calendarConfig.getDateFormat()==2? "年":"/"
                      } ${currentMonthDate.month} ${
                          calendarConfig.getDateFormat()==1? "-":
                          calendarConfig.getDateFormat()==2? "月":"/"
                      }",
                      style: calendarConfig.yearMonthStyle,
                    ),

                    Padding(
                      padding: calendarConfig.monthWidgetPadding,
                      child: Container(
                        height: calendarConfig.monthWidgetHeight,
                        width: calendarConfig.monthWidgetWidth,
                        decoration: calendarConfig.monthWidgetDecoration,
                        child: Material(
                          color: Colors.transparent,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                currentMonthDate = DateTime(currentMonthDate.year,
                                    currentMonthDate.month + 2, 0);
                                setListOfDate(currentMonthDate);
                              });
                            },
                            child: calendarConfig.nextMonthWidget,
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),


              Padding(
                padding: calendarConfig.yearWidgetPadding,
                child: Container(
                  height: calendarConfig.yearWidgetHeight,
                  width: calendarConfig.yearWidgetWidth,
                  decoration: calendarConfig.yearWidgetDecoration,
                  child: Material(
                    color: Colors.transparent,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentMonthDate = DateTime.utc(currentMonthDate.year+1,
                              currentMonthDate.month,
                              currentMonthDate.day,
                              currentMonthDate.hour,
                              currentMonthDate.minute,
                              currentMonthDate.second);
                          setListOfDate(currentMonthDate);
                        });
                      },
                      child: calendarConfig.nextYearWidget,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
        //   child: Row(
        //     children: getDaysNameUI(),
        //   ),
        // ),
        Padding(
          padding: calendarConfig.daysNoUIPadding,
          child: Column(
            children: getDaysNoUI(),
          ),
        ),
      ],
    );
  }

  // List<Widget> getDaysNameUI() {
  //   final List<Widget> listUI = <Widget>[];
  //   for (int i = 0; i < 7; i++) {
  //     listUI.add(
  //       Expanded(
  //         child: Center(
  //           child: Text(
  //            "${dateList[i].day}",
  //             style: calendarConfig.currentMonthDayStyle,
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  //   return listUI;
  // }

  List<Widget> getDaysNoUI() {
    final List<Widget> noList = <Widget>[];
    int count = 0;
    for (int i = 0; i < dateList.length / 7; i++) {
      final List<Widget> listUI = <Widget>[];
      for (int i = 0; i < 7; i++) {
        final DateTime date = dateList[count];
        listUI.add(
          Expanded(
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: startDate != null && endDate != null
                          ? getIsItStartAndEndDate(date) ||
                          getIsInRange(date)
                          ? calendarConfig.inRangeColor
                          : Colors.transparent
                          : Colors.transparent,

                      borderRadius: BorderRadius.only(
                        bottomLeft: isStartDateRadius(date)
                            ? calendarConfig.successionRadius
                            : const Radius.circular(0.0),
                        topLeft: isStartDateRadius(date)
                            ? calendarConfig.successionRadius
                            : const Radius.circular(0.0),
                        topRight: isEndDateRadius(date)
                            ? calendarConfig.successionRadius
                            : const Radius.circular(0.0),
                        bottomRight: isEndDateRadius(date)
                            ? calendarConfig.successionRadius
                            : const Radius.circular(0.0),
                      ),
                    ),
                  ),

                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius:
                          calendarConfig.dayClickBackRadius,
                      onTap: () {
                        if (currentMonthDate.month == date.month) {
                          if (widget.minimumDate != null &&
                              widget.maximumDate != null) {
                            final DateTime newminimumDate = DateTime(
                                widget.minimumDate!.year,
                                widget.minimumDate!.month,
                                widget.minimumDate!.day - 1);
                            final DateTime newmaximumDate = DateTime(
                                widget.maximumDate!.year,
                                widget.maximumDate!.month,
                                widget.maximumDate!.day + 1);
                            if (date.isAfter(newminimumDate) &&
                                date.isBefore(newmaximumDate)) {
                              onDateClick(date);
                            }
                          } else if (widget.minimumDate != null) {
                            final DateTime newminimumDate = DateTime(
                                widget.minimumDate!.year,
                                widget.minimumDate!.month,
                                widget.minimumDate!.day - 1);
                            if (date.isAfter(newminimumDate)) {
                              onDateClick(date);
                            }
                          } else if (widget.maximumDate != null) {
                            final DateTime newmaximumDate = DateTime(
                                widget.maximumDate!.year,
                                widget.maximumDate!.month,
                                widget.maximumDate!.day + 1);
                            if (date.isBefore(newmaximumDate)) {
                              onDateClick(date);
                            }
                          } else {
                            onDateClick(date);
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: getIsItStartAndEndDate(date)
                              ? calendarConfig.cycleBgColor
                              : Colors.transparent,
                          borderRadius:  calendarConfig.dayClickBackRadius,
                          border: Border.all(
                            color: getIsItStartAndEndDate(date)
                                ? calendarConfig.cycleSlidColor
                                : Colors.transparent,
                            width: calendarConfig.cycleWidth,
                          ),
                          boxShadow: getIsItStartAndEndDate(date)
                              ? <BoxShadow>[
                               calendarConfig.boxShadow
                          ]
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            '${date.day}',
                            style: TextStyle(
                                color: getIsItStartAndEndDate(date)
                                    ? calendarConfig.startAndEndDayTextColor
                                    : currentMonthDate.month == date.month
                                    ? calendarConfig.currentMonthTextColor
                                    : calendarConfig.otherMonthTextColor,
                                fontSize:
                                calendarConfig.dayTextSize,
                                fontWeight: getIsItStartAndEndDate(date)
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
        count += 1;
      }
      noList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: listUI,
      ));
    }
    return noList;
  }

  bool getIsInRange(DateTime date) {
    if (startDate != null && endDate != null) {
      if (date.isAfter(startDate!) && date.isBefore(endDate!)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool getIsItStartAndEndDate(DateTime date) {
    if (startDate != null &&
        startDate!.day == date.day &&
        startDate!.month == date.month &&
        startDate!.year == date.year) {
      return true;
    } else if (endDate != null &&
        endDate!.day == date.day &&
        endDate!.month == date.month &&
        endDate!.year == date.year) {
      return true;
    } else {
      return false;
    }
  }

  bool isStartDateRadius(DateTime date) {
    if (startDate != null &&
        startDate!.year == date.year&&
        startDate!.day == date.day &&
        startDate!.month == date.month) {
      return true;
    } else if (date.weekday == 1) {
      return true;
    } else {
      return false;
    }
  }

  bool isEndDateRadius(DateTime date) {
    if (endDate != null &&
        endDate!.year == date.year&&
        endDate!.day == date.day &&
        endDate!.month == date.month) {
      return true;
    } else if (date.weekday == 7) {
      return true;
    } else {
      return false;
    }
  }


  int _count = 0;
  void onDateClick(DateTime date) {
    if(widget.allowSameDate!){
      _dataPickerState2(date);
    }else{
      _dataPickerState(date);
    }
  }

  void _dataPickerState2(DateTime date) {
    if (startDate != null && endDate != null) {
      if (
          endDate!.year == date.year &&
          endDate!.day == date.day &&
          endDate!.month == date.month &&
          startDate!.year == date.year &&
          startDate!.day == date.day &&
          startDate!.month == date.month &&
          _count >= 1
      ) {
        _count = 0;
        endDate = null;
        startDate = null;
        setState(() {
          try {
            widget.startEndDateChange!(startDate!, endDate!);
          } catch (_) {}
        });
        return;
      }
    }

    if (startDate == null) {
      startDate = date;
    } else if (startDate != null && endDate == null) {
      endDate = date;
    }
    else if (startDate!.day == date.day && startDate!.month == date.month) {
      startDate = null;
    } else if (endDate!.day == date.day && endDate!.month == date.month) {
      endDate = null;
    }
    if (startDate == null && endDate != null) {
      startDate = endDate;
      endDate = null;
    }
    if (startDate != null && endDate != null) {
      if (!endDate!.isAfter(startDate!)) {
        final DateTime d = startDate!;
        startDate = endDate;
        endDate = d;
      }
      if (date.isBefore(startDate!)) {
        startDate = date;
      }else{
        if (date.isAfter(startDate!) && date.isBefore(endDate!)) {
          startDate = date;
        }
      }
      if (date.isAfter(endDate!)) {
        endDate = date;
      }
      if(
         endDate!.year == date.year&&
          endDate!.day == date.day &&
          endDate!.month == date.month &&
          startDate!.year == date.year&&
          startDate!.day == date.day &&
          startDate!.month == date.month
      ){
        _count++;
      }
    }
    setState(() {
      try {
        widget.startEndDateChange!(startDate!, endDate!);
      } catch (_) {}
    });
  }


  void _dataPickerState(DateTime date){
    if (startDate == null) {
      startDate = date;
    } else if (startDate != date && endDate == null) {
      endDate = date;
    } else if (startDate!.day == date.day && startDate!.month == date.month) {
      startDate = null;
    } else if (endDate!.day == date.day && endDate!.month == date.month) {
      endDate = null;
    }
    if (startDate == null && endDate != null) {
      startDate = endDate;
      endDate = null;
    }
    if (startDate != null && endDate != null) {
      if (!endDate!.isAfter(startDate!)) {
        final DateTime d = startDate!;
        startDate = endDate;
        endDate = d;
      }
      if (date.isBefore(startDate!)) {
        startDate = date;
      }
      if (date.isAfter(endDate!)) {
        endDate = date;
      }
    }
    setState(() {
      try {
        widget.startEndDateChange!(startDate!, endDate!);
      } catch (_) {}
    });
  }
}
