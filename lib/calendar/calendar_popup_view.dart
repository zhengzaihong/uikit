import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/calendar/calendar_config.dart';
import 'custom_calendar.dart';


///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/12/2
/// create_time: 16:48
/// describe: 日历弹出视图
///
class CalendarPopupView extends StatefulWidget {

  const CalendarPopupView(
      {Key? key,
      this.initialStartDate,
      this.initialEndDate,
      this.onApplyClick,
      this.onCancelClick,
      this.barrierDismissible = true,
      this.minimumDate,
      this.maximumDate,
        required this.calendarConfig,
        this.allowSameDate = true
      })
      : super(key: key);

  final DateTime? minimumDate;
  final DateTime? maximumDate;

  final bool barrierDismissible;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final CalendarConfig calendarConfig;
  final Function(DateTime, DateTime)? onApplyClick;
  final Function()? onCancelClick;
  final bool? allowSameDate;
  @override
  _CalendarPopupViewState createState() => _CalendarPopupViewState();
}

class _CalendarPopupViewState extends State<CalendarPopupView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  DateTime? startDate;
  DateTime? endDate;
  late CalendarConfig calendarConfig;
  @override
  void initState() {
    calendarConfig = widget.calendarConfig;

    animationController = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    if (widget.initialStartDate != null) {
      startDate = widget.initialStartDate;
    }
    if (widget.initialEndDate != null) {
      endDate = widget.initialEndDate;
    }
    animationController?.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: calendarConfig.backgroundColor,
      body: AnimatedBuilder(
        animation: animationController!,
        builder: (BuildContext context, Widget? child) {
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 100),
            opacity: animationController!.value,
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () {
                if (widget.barrierDismissible) {
                  Navigator.pop(context);
                }
              },
              child: Center(
                child: Padding(
                  padding: calendarConfig.calendarPadding,
                  child: Container(
                    decoration: BoxDecoration(
                      color: calendarConfig.calendarBgColor,
                      borderRadius: BorderRadius.all(calendarConfig.bgRadius),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: calendarConfig.boxShadowColor,
                            offset: calendarConfig.boxShadowOffset,
                            blurRadius: calendarConfig.blurRadius)],
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.all(calendarConfig.bgRadius),
                      onTap: () {
                        // todo

                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[

                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: <Widget>[
                                    calendarConfig.startText,
                                    calendarConfig.callBackStartTime?.call(startDate)??const SizedBox(),

                                  ],
                                ),
                              ),
                             calendarConfig.verticalLineWidget ,
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: <Widget>[
                                    calendarConfig.endText,
                                    calendarConfig.callBackEndTime?.call(endDate)??const SizedBox(),
                                  ],
                                ),
                              )
                            ],
                          ),

                          calendarConfig.landscapeLineWidget,

                          CustomCalendarView(
                            calendarConfig: calendarConfig,
                            minimumDate: widget.minimumDate,
                            maximumDate: widget.maximumDate,
                            initialEndDate: widget.initialEndDate,
                            initialStartDate: widget.initialStartDate,
                            allowSameDate: widget.allowSameDate,
                            startEndDateChange: (DateTime startDateData, DateTime endDateData) {
                              setState(() {
                                startDate = startDateData;
                                endDate = endDateData;
                              });
                            },
                          ),

                          InkWell(
                            onTap: () {
                              try {
                                widget.onApplyClick!(startDate!, endDate!);
                                Navigator.pop(context);
                              } catch (_) {}
                            },
                            child: Padding(
                              padding: calendarConfig.sureButtonPadding,
                              child: Container(
                                height: calendarConfig.sureButtonHeight,
                                width: calendarConfig.sureButtonWidth,
                                alignment: Alignment.center,
                                decoration: calendarConfig.sureButtonBgStyle,
                                child: calendarConfig.sureButton,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
