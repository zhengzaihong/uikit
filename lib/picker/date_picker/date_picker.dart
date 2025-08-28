import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../ext/top_view.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024/12/4
/// create_time: 11:09
/// describe: 1.支持范围日期选择，
/// 2，支持具体某天选择，
/// 3，支持可配置列时间选择.
/// 4.支持多语种(提供中文-英文，其他语种请实现 DatePickerStrings配置)

typedef ItemBuilder = Widget Function(DateType type, int value);

enum DateType {
  //年
  YEAR,
  //月
  MONTH,
  //日
  DAY,
  //时
  HOUR,
  //分
  MINUTE,
  //秒
  SECOND,
}

class DatePicker extends StatefulWidget {
  //构建每个item的widget
  final ItemBuilder itemBuilder;

  //选择器的装饰器
  final BoxDecoration? pickerDecoration;

  //开始日期和结束日期的控制器
  final DateController controller;

  //picker的高度
  final double height;

  //picker的宽度
  final double width;

  //是否可循环滚动
  final bool scrollLoop;

  //垂直间距
  final double vGap;

  //内距
  final EdgeInsetsGeometry? padding;

  //开始日期和结束日期的widget
  final Widget? startWidget;
  final Widget? endWidget;

  //picker的可见高度
  final double pickerVisibilityHeight;

  //每个item的宽度
  final double itemWidth;

  //遮罩的高度
  final double maskHeight;

  //遮罩的圆角
  final double maskRadius;

  //遮罩的颜色
  final Color? maskColor;

  //每个item的高度
  final double itemExtent;

  //控制滚轮的曲率，默认 1.07，越小越弯曲
  final double? diameterRatio;

  //滚轮背景颜色
  final Color? backgroundColor;

  //控制滚轮的水平偏移，默认 0.0。
  final double? offAxisFraction;

  //是否启用放大镜效果
  final bool? useMagnifier;

  //放大倍数，仅在 useMagnifier=true 时生效。
  final double? magnification;

  //控制子项之间的压缩程度，影响视觉密度
  final double? squeeze;

  //自定义选中项的覆盖样式，默认是灰色圆角背景
  final Widget? selectionOverlay;

  //默认选中的日期
  final DateTime? initStartDate;
  final DateTime? initEndDate;
  //倒推的年份个数
  final int forwardYears;

  //年份的个数  [重要：必须大于forwardYears，时间范围：[(当前时间-forwardYears) ---- (当前时间+(totalYears-forwardYears))]]
  final int totalYears;

  //动画时间
  final Duration duration;

  //动画曲线
  final Curve curve;

  //扩展按钮
  final Widget? action;

  //需要展示的日期类型
  final List<DateType> showColumn;

  DatePicker({
    required this.controller,
    required this.itemBuilder,
    this.startWidget,
    this.showColumn = const [
      DateType.YEAR,
      DateType.MONTH,
      DateType.DAY,
      DateType.HOUR,
      DateType.MINUTE
    ],
    this.endWidget,
    this.initStartDate,
    this.initEndDate,
    this.pickerDecoration,
    this.height = 500,
    this.width = 400,
    this.scrollLoop = true,
    this.padding,
    this.vGap = 16,
    this.pickerVisibilityHeight = 140,
    this.itemWidth = 100,
    this.maskHeight = 40,
    this.maskRadius = 0,
    this.maskColor = const Color.fromRGBO(242, 242, 244, 0.7),
    this.diameterRatio,
    this.backgroundColor,
    this.offAxisFraction,
    this.useMagnifier,
    this.magnification,
    this.itemExtent = 40,
    this.squeeze,
    this.selectionOverlay,
    this.forwardYears = 50,
    this.totalYears = 110,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOutCubic,
    this.action,
    Key? key,
  }) : super(key: key) {
    assert(totalYears > forwardYears, "totalYears必须大于forwardYears");
  }

  @override
  State<DatePicker> createState() => _DatePickerState();

  ///展示选择器基础示例，不满足样式外部更加DatePicker可自定义你的窗口


  ///开始时间--结束时间 -dialog
  static Future<dynamic> showDateRangePicker(
   {
    required BuildContext context,
    required DateController controller,
    bool barrierDismissible = true,
    double height = 500,
    double width = 400,
    int totalYears = 110,
    int forwardYears = 50,
    double vGap = 16,
    BoxDecoration? pickerDecoration,
    DateTime? initStartDate,
    DateTime? initEndDate,
    double pickerVisibilityHeight = 140,
    double itemExtent = 40,
    double maskHeight = 40,
    double itemWidth = 100,
    double maskRadius = 0,
    double? diameterRatio,
    Color? backgroundColor,
    double? offAxisFraction,
    bool? useMagnifier,
    double? magnification,
    double? squeeze,
    Widget? selectionOverlay,
    Color? maskColor = const Color.fromRGBO(242, 242, 244, 0.7),
    Duration duration = const Duration(milliseconds: 200),
    Curve curve = Curves.easeInOutCubic,
    List<DateType> showColumn = const [
      DateType.YEAR,
      DateType.MONTH,
      DateType.DAY,
      DateType.HOUR,
      DateType.MINUTE,
      DateType.SECOND
    ],
    DatePickerStrings? datePickerStrings, 
    Function(DateTime? startDate, DateTime? endDate)? callBack,
  }) {
    final strings = datePickerStrings ?? DatePickerStrings.fromLocale(Localizations.localeOf(context));
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return Center(child: DatePicker(
          controller: controller,
          pickerDecoration: pickerDecoration,
          width: width,
          height: height,
          totalYears: totalYears,
          initStartDate: initStartDate,
          initEndDate: initEndDate,
          forwardYears: forwardYears,
          vGap: vGap,
          pickerVisibilityHeight: pickerVisibilityHeight,
          itemExtent: itemExtent,
          itemWidth: itemWidth,
          maskHeight: maskHeight,
          maskRadius: maskRadius,
          maskColor: maskColor,
          diameterRatio: diameterRatio,
          backgroundColor: backgroundColor,
          offAxisFraction: offAxisFraction,
          useMagnifier: useMagnifier,
          magnification: magnification,
          squeeze: squeeze,
          selectionOverlay: selectionOverlay,
          duration: duration,
          curve: curve,
          showColumn: showColumn,
          startWidget: Padding( // Using strings.startDate
            padding: const EdgeInsets.only(left: 20),
            child: Text(strings.startDate,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
          ),
          endWidget: Padding( // Using strings.endDate
            padding: const EdgeInsets.only(left: 20),
            child: Text(strings.endDate,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
          ),
          itemBuilder: (type, value) {
            String label = '';
            switch (type) { // Using strings for year, month, day, etc.
              case DateType.YEAR:
                label = strings.year;
                break;
              case DateType.MONTH:
                label = strings.month;
                break;
              case DateType.DAY:
                label = strings.day;
                break;
              case DateType.HOUR:
                label = strings.hour;
                break;
              case DateType.MINUTE:
                label = strings.minute;
                break;
              case DateType.SECOND:
                label = strings.second;
                break;
            }
            return Center(
              child: Text(
                "$value$label",
                style: const TextStyle(
                    color: Color.fromRGBO(21, 21, 21, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
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
                child: Text(strings.confirm, // Using strings.confirm
                    style: const TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ),
        ));
      },
    );
  }
  ///开始时间--结束时间 -BottomSheet
  static Future<dynamic> showDateRangeModalBottomSheet({
        required BuildContext context,
        required DateController controller,
        bool barrierDismissible = true,
        double height = 500,
        double width = 400,
        int totalYears = 110,
        int forwardYears = 50,
        double vGap = 16,
        BoxDecoration? pickerDecoration,
        DateTime? initStartDate,
        DateTime? initEndDate,
        double pickerVisibilityHeight = 140,
        double itemExtent = 40,
        double maskHeight = 40,
        double itemWidth = 100,
        double maskRadius = 0,
        double? diameterRatio,
        Color? backgroundColor,
        double? offAxisFraction,
        bool? useMagnifier,
        double? magnification,
        double? squeeze,
        Widget? selectionOverlay,
        Color? maskColor = const Color.fromRGBO(242, 242, 244, 0.7),
        Duration duration = const Duration(milliseconds: 200),
        Curve curve = Curves.easeInOutCubic,
        List<DateType> showColumn = const [
          DateType.YEAR,
          DateType.MONTH,
          DateType.DAY,
          DateType.HOUR,
          DateType.MINUTE,
          DateType.SECOND
        ],
        DatePickerStrings? datePickerStrings,
        Color? bottomSheetBackgroundColor,
        String? barrierLabel,
        double? elevation,
        ShapeBorder? shape,
        Clip? clipBehavior,
        BoxConstraints? constraints,
        Color? barrierColor,
        bool isScrollControlled = false,
        double scrollControlDisabledMaxHeightRatio =  9.0 / 16.0,
        bool useRootNavigator = false,
        bool isDismissible = true,
        bool enableDrag = true,
        bool? showDragHandle,
        bool useSafeArea = false,
        RouteSettings? routeSettings,
        AnimationController? transitionAnimationController,
        Offset? anchorPoint,
        AnimationStyle? sheetAnimationStyle,
        Function(DateTime? startDate, DateTime? endDate)? callBack,
      }) {
    final strings = datePickerStrings ?? DatePickerStrings.fromLocale(Localizations.localeOf(context));
    return showModalBottomSheet(
      context: context,
      backgroundColor: bottomSheetBackgroundColor,
      barrierLabel: barrierLabel,
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
      constraints: constraints,
      barrierColor: barrierColor,
      isScrollControlled: isScrollControlled,
      scrollControlDisabledMaxHeightRatio: scrollControlDisabledMaxHeightRatio,
      useRootNavigator: useRootNavigator,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      showDragHandle: showDragHandle,
      useSafeArea: useSafeArea,
      routeSettings: routeSettings,
      transitionAnimationController: transitionAnimationController,
      anchorPoint: anchorPoint,
      sheetAnimationStyle: sheetAnimationStyle,
      builder: (context) {
        return DatePicker(
          controller: controller,
          pickerDecoration: pickerDecoration,
          width: width,
          height: height,
          totalYears: totalYears,
          initStartDate: initStartDate,
          initEndDate: initEndDate,
          forwardYears: forwardYears,
          vGap: vGap,
          pickerVisibilityHeight: pickerVisibilityHeight,
          itemExtent: itemExtent,
          itemWidth: itemWidth,
          maskHeight: maskHeight,
          maskRadius: maskRadius,
          maskColor: maskColor,
          diameterRatio: diameterRatio,
          backgroundColor: backgroundColor,
          offAxisFraction: offAxisFraction,
          useMagnifier: useMagnifier,
          magnification: magnification,
          squeeze: squeeze,
          selectionOverlay: selectionOverlay,
          duration: duration,
          curve: curve,
          showColumn: showColumn,
          startWidget: Padding( // Using strings.startDate
            padding: const EdgeInsets.only(left: 20),
            child: Text(strings.startDate,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
          ),
          endWidget: Padding( // Using strings.endDate
            padding: const EdgeInsets.only(left: 20),
            child: Text(strings.endDate,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
          ),
          itemBuilder: (type, value) {
            String label = '';
            switch (type) { // Using strings for year, month, day, etc.
              case DateType.YEAR:
                label = strings.year;
                break;
              case DateType.MONTH:
                label = strings.month;
                break;
              case DateType.DAY:
                label = strings.day;
                break;
              case DateType.HOUR:
                label = strings.hour;
                break;
              case DateType.MINUTE:
                label = strings.minute;
                break;
              case DateType.SECOND:
                label = strings.second;
                break;
            }
            return Center(
              child: Text(
                "$value$label",
                style: const TextStyle(
                    color: Color.fromRGBO(21, 21, 21, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            );
          },
          action: GestureDetector(
            onTap: () {
              final startDate = controller.getStartDate();
              callBack?.call(startDate,null);
              Navigator.pop(context, [startDate]);
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
                child: Text(strings.confirm, // Using strings.confirm
                    style: const TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ),
        );
      },
    );
  }

  ///选择某个日期-时间
  static Future<dynamic> showDateModalBottomSheet({
    required BuildContext context,
    required DateController controller,
    bool barrierDismissible = true,
    double height = 500,
    double width = 400,
    int totalYears = 110,
    int forwardYears = 50,
    double vGap = 16,
    BoxDecoration? pickerDecoration,
    DateTime? initStartDate,
    DateTime? initEndDate,
    double pickerVisibilityHeight = 140,
    double itemExtent = 40,
    double maskHeight = 40,
    double itemWidth = 100,
    double maskRadius = 0,
    double? diameterRatio,
    Color? backgroundColor,
    double? offAxisFraction,
    bool? useMagnifier,
    double? magnification,
    double? squeeze,
    Widget? selectionOverlay,
    Widget? title,
    Color? maskColor = const Color.fromRGBO(242, 242, 244, 0.7),
    Duration duration = const Duration(milliseconds: 200),
    Curve curve = Curves.easeInOutCubic,
    List<DateType> showColumn = const [
      DateType.YEAR,
      DateType.MONTH,
      DateType.DAY,
      DateType.HOUR,
      DateType.MINUTE,
      DateType.SECOND
    ],
    DatePickerStrings? datePickerStrings,
    Color? bottomSheetBackgroundColor,
    String? barrierLabel,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    BoxConstraints? constraints,
    Color? barrierColor,
    bool isScrollControlled = false,
    double scrollControlDisabledMaxHeightRatio =  9.0 / 16.0,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    bool? showDragHandle,
    bool useSafeArea = false,
    RouteSettings? routeSettings,
    AnimationController? transitionAnimationController,
    Offset? anchorPoint,
    AnimationStyle? sheetAnimationStyle,
    Function(DateTime? startDate, DateTime? endDate)? callBack,
  }) {
    final strings = datePickerStrings ?? DatePickerStrings.fromLocale(Localizations.localeOf(context));
    return showModalBottomSheet(
      context: context,
      backgroundColor: bottomSheetBackgroundColor,
      barrierLabel: barrierLabel,
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
      constraints: constraints,
      barrierColor: barrierColor,
      isScrollControlled: isScrollControlled,
      scrollControlDisabledMaxHeightRatio: scrollControlDisabledMaxHeightRatio,
      useRootNavigator: useRootNavigator,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      showDragHandle: showDragHandle,
      useSafeArea: useSafeArea,
      routeSettings: routeSettings,
      transitionAnimationController: transitionAnimationController,
      anchorPoint: anchorPoint,
      sheetAnimationStyle: sheetAnimationStyle,
      builder: (context) {
        return DatePicker(
          controller: controller,
          pickerDecoration: pickerDecoration,
          startWidget: title,
          width: width,
          height: height,
          totalYears: totalYears,
          initStartDate: initStartDate,
          initEndDate: initEndDate,
          forwardYears: forwardYears,
          vGap: vGap,
          pickerVisibilityHeight: pickerVisibilityHeight,
          itemExtent: itemExtent,
          itemWidth: itemWidth,
          maskHeight: maskHeight,
          maskRadius: maskRadius,
          maskColor: maskColor,
          diameterRatio: diameterRatio,
          backgroundColor: backgroundColor,
          offAxisFraction: offAxisFraction,
          useMagnifier: useMagnifier,
          magnification: magnification,
          squeeze: squeeze,
          selectionOverlay: selectionOverlay,
          duration: duration,
          curve: curve,
          showColumn: showColumn,
          itemBuilder: (type, value) {
            String label = '';
            switch (type) { // Using strings for year, month, day, etc.
              case DateType.YEAR:
                label = strings.year;
                break;
              case DateType.MONTH:
                label = strings.month;
                break;
              case DateType.DAY:
                label = strings.day;
                break;
              case DateType.HOUR:
                label = strings.hour;
                break;
              case DateType.MINUTE:
                label = strings.minute;
                break;
              case DateType.SECOND:
                label = strings.second;
                break;
            }
            return Center(
              child: Text(
                "$value$label",
                style: const TextStyle(
                    color: Color.fromRGBO(21, 21, 21, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
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
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(strings.confirm, // Using strings.confirm
                    style: const TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DatePickerState extends State<DatePicker> {
  late int _startYear;
  late DateTime _startDate;
  late DateModel _startDateModel;

  late DateTime _endDate;
  late DateModel _endDateModel;

  final startYearScrollController = FixedExtentScrollController();
  final startMonthScrollController = FixedExtentScrollController();
  final startDayScrollController = FixedExtentScrollController();
  final startHourScrollController = FixedExtentScrollController();
  final startMinuteScrollController = FixedExtentScrollController();
  final startSecondScrollController = FixedExtentScrollController();

  final endYearScrollController = FixedExtentScrollController();
  final endMonthScrollController = FixedExtentScrollController();
  final endDayScrollController = FixedExtentScrollController();
  final endHourScrollController = FixedExtentScrollController();
  final endMinuteScrollController = FixedExtentScrollController();
  final endSecondScrollController = FixedExtentScrollController();

  final now = DateTime.now();

  DateTime startDate() {
    return DateTime(_startDateModel.year, _startDateModel.month,
        _startDateModel.day, _startDateModel.hour, _startDateModel.minute, _startDateModel.second);
  }

  DateTime endDate() {
    return DateTime(_endDateModel.year, _endDateModel.month, _endDateModel.day,
        _endDateModel.hour, _endDateModel.minute, _endDateModel.second);
  }

  @override
  void initState() {
    super.initState();

    widget.controller.bind(this);

    _startDate = widget.initStartDate ??
        DateTime(
            now.year, now.month, now.day, now.hour, now.minute, now.second);
    _startYear = now.year - widget.forwardYears;
    _endDate = widget.initEndDate ??
        DateTime(
            now.year, now.month, now.day, now.hour, now.minute, now.second);

    _startDateModel = DateModel(_startDate.year, _startDate.month,
        _startDate.day, _startDate.hour, _startDate.minute, _startDate.second);
    _endDateModel = DateModel(_endDate.year, _endDate.month, _endDate.day,
        _endDate.hour, _endDate.minute, _endDate.second);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _animateTo();
    });
  }

  void _animateTo() {
    if(widget.showColumn.contains(DateType.YEAR)) _animateScroll(startYearScrollController, _startDate.year - _startYear);
    if(widget.showColumn.contains(DateType.MONTH)) _animateScroll(startMonthScrollController, _startDate.month - 1);
    if(widget.showColumn.contains(DateType.DAY)) _animateScroll(startDayScrollController, _startDate.day - 1);
    if(widget.showColumn.contains(DateType.HOUR)) _animateScroll(startHourScrollController, _startDate.hour);
    if(widget.showColumn.contains(DateType.MINUTE)) _animateScroll(startMinuteScrollController, _startDate.minute);
    if(widget.showColumn.contains(DateType.SECOND)) _animateScroll(startSecondScrollController, _startDate.second);

    if (widget.endWidget != null) {
      if(widget.showColumn.contains(DateType.YEAR)) _animateScroll(endYearScrollController, _endDate.year - _startYear);
      if(widget.showColumn.contains(DateType.MONTH)) _animateScroll(endMonthScrollController, _endDate.month - 1);
      if(widget.showColumn.contains(DateType.DAY)) _animateScroll(endDayScrollController, _endDate.day - 1);
      if(widget.showColumn.contains(DateType.HOUR)) _animateScroll(endHourScrollController, _endDate.hour);
      if(widget.showColumn.contains(DateType.MINUTE)) _animateScroll(endMinuteScrollController, _endDate.minute);
      if(widget.showColumn.contains(DateType.SECOND)) _animateScroll(endSecondScrollController, _endDate.second);
    }
  }

  void _animateScroll(FixedExtentScrollController controller, int item) {
    if (controller.hasClients && item >=0 && controller.position.maxScrollExtent >= item * widget.itemExtent) { // Ensure item is valid
      controller.animateToItem(item,
          duration: widget.duration, curve: widget.curve);
    }
  }

  @override
  void dispose() {
    startYearScrollController.dispose();
    startMonthScrollController.dispose();
    startDayScrollController.dispose();
    startHourScrollController.dispose();
    startMinuteScrollController.dispose();
    startSecondScrollController.dispose();

    endYearScrollController.dispose();
    endMonthScrollController.dispose();
    endDayScrollController.dispose();
    endHourScrollController.dispose();
    endMinuteScrollController.dispose();
    endSecondScrollController.dispose();

    widget.controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant DatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      widget.controller.bind(this);
    }
    if (widget.initStartDate != oldWidget.initStartDate || widget.initEndDate != oldWidget.initEndDate) {
        _startDate = widget.initStartDate ?? DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second);
        _endDate = widget.initEndDate ?? DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second);
        _startDateModel = DateModel(_startDate.year, _startDate.month, _startDate.day, _startDate.hour, _startDate.minute, _startDate.second);
        _endDateModel = DateModel(_endDate.year, _endDate.month, _endDate.day, _endDate.hour, _endDate.minute, _endDate.second);
        WidgetsBinding.instance.addPostFrameCallback((_) => _animateTo());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: widget.padding,
      decoration: widget.pickerDecoration ?? BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          vGap(widget.vGap),
          if (widget.startWidget != null) ...[
           widget.startWidget!,
            vGap(widget.vGap),
          ],
          _buildDatePicker(_startDateModel, true),
          if (widget.endWidget != null) ...[
            vGap(widget.vGap),
            widget.endWidget!,
            vGap(widget.vGap),
            _buildDatePicker(_endDateModel, false),
          ],
          const Spacer(),
          if (widget.action != null) widget.action!,
          vGap(widget.vGap),
        ],
      ),
    );
  }

  Widget _buildDatePicker(DateModel dateModel, bool isStart) {
    return SizedBox(
      width: widget.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: widget.maskHeight,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.maskRadius),
                color: widget.maskColor),
          ),
          _buildDateTime(dateModel, isStart)
        ],
      ),
    );
  }

  Widget _buildDateTime(DateModel dateModel, bool isStart) {
    final List<Widget> columns = widget.showColumn
        .map((type) => _createColumnItem(type, dateModel, isStart))
        .toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: columns,
    );
  }

  Widget _createColumnItem(DateType type, DateModel dateModel, bool isStart) {
    switch (type) {
      case DateType.YEAR:
        return _buildPickerColumn(
          controller:
              isStart ? startYearScrollController : endYearScrollController,
          itemCount: widget.totalYears,
          itemBuilder: (index) => _startYear + index,
          onSelectedItemChanged: (index) {
            setState(() {
              dateModel.year = _startYear + index;
              _validateDay(dateModel, isStart);
            });
          },
          type: type,
        );
      case DateType.MONTH:
        return _buildPickerColumn(
          controller:
              isStart ? startMonthScrollController : endMonthScrollController,
          itemCount: 12,
          itemBuilder: (index) => index + 1,
          onSelectedItemChanged: (index) {
            setState(() {
              dateModel.month = index + 1;
              _validateDay(dateModel, isStart);
            });
          },
          type: type,
        );
      case DateType.DAY:
        return _buildPickerColumn(
          controller:
              isStart ? startDayScrollController : endDayScrollController,
          itemCount: _getMonthDay(dateModel.year, dateModel.month),
          itemBuilder: (index) => index + 1,
          onSelectedItemChanged: (index) {
            dateModel.day = index + 1;
          },
          type: type,
        );
      case DateType.HOUR:
        return _buildPickerColumn(
          controller:
              isStart ? startHourScrollController : endHourScrollController,
          itemCount: 24,
          itemBuilder: (index) => index,
          onSelectedItemChanged: (index) {
            dateModel.hour = index;
          },
          type: type,
        );
      case DateType.MINUTE:
        return _buildPickerColumn(
          controller:
              isStart ? startMinuteScrollController : endMinuteScrollController,
          itemCount: 60,
          itemBuilder: (index) => index,
          onSelectedItemChanged: (index) {
            dateModel.minute = index;
          },
          type: type,
        );
      case DateType.SECOND:
        return _buildPickerColumn(
          controller:
              isStart ? startSecondScrollController : endSecondScrollController,
          itemCount: 60,
          itemBuilder: (index) => index,
          onSelectedItemChanged: (index) {
            // Bug fix: was setting dateModel.minute, should be dateModel.second
            dateModel.second = index;
          },
          type: type,
        );
    }
  }

  Widget _buildPickerColumn({
    required FixedExtentScrollController controller,
    required int itemCount,
    required int Function(int index) itemBuilder,
    required ValueChanged<int> onSelectedItemChanged,
    required DateType type,
  }) {
    return SizedBox(
      width: widget.itemWidth,
      height: widget.pickerVisibilityHeight,
      child: CupertinoPicker(
        scrollController: controller,
        itemExtent: widget.itemExtent,
        looping: widget.scrollLoop,
        diameterRatio: widget.diameterRatio ?? 1.07,
        backgroundColor: widget.backgroundColor,
        offAxisFraction: widget.offAxisFraction ?? 0,
        useMagnifier: widget.useMagnifier ?? false,
        magnification: widget.magnification ?? 1.0,
        squeeze: widget.squeeze ?? 1.45,
        selectionOverlay: widget.selectionOverlay,
        onSelectedItemChanged: onSelectedItemChanged,
        children: List<Widget>.generate(itemCount, (index) {
          return widget.itemBuilder.call(type, itemBuilder(index));
        }),
      ),
    );
  }

  void _validateDay(DateModel dateModel, bool isStart) {
    var maxDay = _getMonthDay(dateModel.year, dateModel.month);
    if (dateModel.day > maxDay) {
      dateModel.day = maxDay;
      final controller =
          isStart ? startDayScrollController : endDayScrollController;
      if (controller.hasClients) {
         // Animate to the new valid day instead of jumping
        controller.animateToItem(maxDay - 1, duration: widget.duration, curve: widget.curve);
      }
    }
  }

  int _getMonthDay(int year, int month) {
    if (month < 1 || month > 12) return 31; // Should not happen with current setup
    if (month == 2) {
      if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
        return 29;
      }
      return 28;
    }
    const daysInMonth = <int>[ // Index 0 is unused, 1 for Jan, etc.
      0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
    ];
    return daysInMonth[month];
  }
}

class DateModel {
  int year;
  int month;
  int day;
  int hour;
  int minute;
  int second; // Added second

  DateModel(
      this.year, this.month, this.day, this.hour, this.minute, this.second); // Added second

  Map<String, dynamic> toJson() {
    return {
      "year": year,
      "month": month,
      "day": day,
      "hour": hour,
      "minute": minute,
      "second": second, // Added second
    };
  }
}

class DateController {

   DateController();
  _DatePickerState? _state;

  DateTime? getStartDate() {
    return _state?.startDate();
  }

  DateTime? getEndDate() {
    return _state?.endDate();
  }

  void bind(_DatePickerState _datePickerState) {
    _state = _datePickerState;
  }

  void dispose() {
    _state = null;
  }
}

class DatePickerStrings {
  final String year;
  final String month;
  final String day;
  final String hour;
  final String minute;
  final String second;
  final String startDate;
  final String endDate;
  final String confirm;

  const DatePickerStrings({
    required this.year,
    required this.month,
    required this.day,
    required this.hour,
    required this.minute,
    required this.second,
    required this.startDate,
    required this.endDate,
    required this.confirm,
  });

  factory DatePickerStrings.fromLocale(Locale locale) {
    switch (locale.languageCode) {
      case 'zh':
        return const DatePickerStrings.zh();
      case 'en':
      default:
        return const DatePickerStrings.en();
    }
  }

  // 中文
  const factory DatePickerStrings.zh() = _DatePickerStringsZh;
  // 英文
  const factory DatePickerStrings.en() = _DatePickerStringsEn;
}

// Chinese strings.
class _DatePickerStringsZh implements DatePickerStrings {
  const _DatePickerStringsZh();
  @override String get year => '年';
  @override String get month => '月';
  @override String get day => '日';
  @override String get hour => '时';
  @override String get minute => '分';
  @override String get second => '秒';
  @override String get startDate => '开始日期：';
  @override String get endDate => '结束日期：';
  @override String get confirm => '确定';
}

//  English strings.
class _DatePickerStringsEn implements DatePickerStrings {
  const _DatePickerStringsEn();
  @override String get year => 'Year';
  @override String get month => 'Month';
  @override String get day => 'Day';
  @override String get hour => 'Hour';
  @override String get minute => 'Minute';
  @override String get second => 'Second';
  @override String get startDate => 'Start Date:';
  @override String get endDate => 'End Date:';
  @override String get confirm => 'Confirm';
}
