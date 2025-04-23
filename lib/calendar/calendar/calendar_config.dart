import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/uikitlib.dart';
///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/12/9
/// create_time: 15:21
/// describe: 日历样式的配置文件
///
/// 待优化
///

typedef CallBackWidget = Widget Function(DateTime? dateTime);
class CalendarConfig{

  ///日历宽高
  double calendarWidth=400;
  double calendarHeight=600;

  ///日历的起 始时间
  DateTime? minimumDate;
  DateTime? maximumDate;


  ///顶部选中后显示的时间样式组件，外部自定义
  CallBackWidget? callBackStartTime;
  CallBackWidget? callBackEndTime;


  ///当天日期下面的小圆点颜色
  Color currentDayDotColor = Colors.lightBlue.withAlpha(100);

  ///连续选中的连接颜色
  Color inRangeColor = Colors.redAccent.withAlpha(200);

  ///选择的起始时间背景色
  Color cycleBgColor = Colors.greenAccent.withAlpha(200);

  ///选择的起始时间背景的边框颜色
  Color cycleSlidColor = Colors.white;
  ///边框的宽度
  double cycleWidth = 2.0;

  ///连续选中的 开始时间和结束时间的 背景阴影效果
  BoxShadow boxShadow = BoxShadow(
      color: Colors.grey.setOpacity(0.6),
      blurRadius: 4,
      offset: const Offset(0, 0));

  ///选择的起始时间和结束时间的文本颜色
  Color startAndEndDayTextColor = Colors.white;
  /// 本月的日期文本颜色
  Color currentMonthTextColor = Colors.black;
  /// 非本月的日期颜色
  Color otherMonthTextColor = Colors.grey.setOpacity(0.6);

  ///日期的字体大小
  double dayTextSize = 16.0;



  ///日历的浮层的背景色
  Color backgroundColor = Colors.transparent;

  ///日历的背景色
  Color calendarBgColor = Colors.white;

  ///背景阴影
  Color boxShadowColor = Colors.grey.setOpacity(0.2);

  ///背景阴影偏移
  Offset boxShadowOffset = const Offset(4, 4);

  ///高斯模糊度数
  double blurRadius = 8.0;

  ///日历内边距
  EdgeInsets calendarPadding = const EdgeInsets.all(24.0);

  ///日历内的日期内距
  EdgeInsets daysNoUIPadding = const EdgeInsets.only(right: 8, left: 8);

  ///背景圆角
  Radius bgRadius = const Radius.circular(24.0);


  ///日历的垂直分割线
  Widget verticalLineWidget = Container(
      height: 74,
      width: 1,
      color: Colors.black12
  );
  ///日历的横向分割线
  Widget landscapeLineWidget = const Divider(height: 1,color: Colors.black12);


  ///顶部开始时间文字样式
  Widget startText = Text('开始时间', textAlign: TextAlign.left, style: TextStyle(
        fontWeight: FontWeight.w100,
        fontSize: 16,
        color:
        Colors.lightBlue.setOpacity(0.8)),
  );

  ///顶部结束时间文字样式
  Widget endText = Text('结束时间', textAlign: TextAlign.left, style: TextStyle(
        fontWeight: FontWeight.w100,
        fontSize: 16,
        color:
        Colors.lightBlue.setOpacity(0.8)),
  );


  ///翻月 行的内距
  EdgeInsets preNextPadding = const EdgeInsets.only(left: 8.0, right: 8.0, top: 4, bottom: 4);





  Widget preYearWidget = const Icon(
    Icons.keyboard_arrow_left,
    color: Colors.grey,
  );

  Widget nextYearWidget = const Icon(
    Icons.keyboard_arrow_right,
    color: Colors.grey,
  );


  EdgeInsets yearWidgetPadding = const EdgeInsets.all(8.0);
  double yearWidgetWidth = 38.0;
  double yearWidgetHeight =38.0;

  BoxDecoration yearWidgetDecoration= BoxDecoration(
    borderRadius:
    const BorderRadius.all(Radius.circular(24.0)),
    border: Border.all(
      color:Colors.black12,
    ),
  );




  ///翻月 按钮的内距 和宽高
  EdgeInsets monthWidgetPadding = const EdgeInsets.all(8.0);
  double monthWidgetWidth = 38.0;
  double monthWidgetHeight =38.0;

  BoxDecoration monthWidgetDecoration= BoxDecoration(
    borderRadius:
    const BorderRadius.all(Radius.circular(24.0)),
    border: Border.all(
      color:Colors.transparent,
    ),
  );

  Widget preMonthWidget = const Icon(
    Icons.keyboard_arrow_left,
    color: Colors.grey,
    size: 30,
  );

  Widget nextMonthWidget = const Icon(
    Icons.keyboard_arrow_right,
    color: Colors.grey,
    size: 30,
  );







  TextStyle yearMonthStyle = const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 20,
      color: Colors.black);


  TextStyle currentMonthDayStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black12);

  TextStyle notThisMonthDayStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black12);


  ///确定按钮文本样式
  Widget sureButton = const Text(
    '确定',
    style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: Colors.white),
  );

  ///确定按钮的宽高
  double sureButtonWidth = 100;
  double sureButtonHeight = 48;

  ///确定按钮的背景样式
  BoxDecoration sureButtonBgStyle =  BoxDecoration(
    color: Colors.lightBlue,
    borderRadius: const BorderRadius.all(
        Radius.circular(24.0)),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: Colors.grey.setOpacity(0.6),
        blurRadius: 8,
        offset: const Offset(4, 4),
      ),
    ],
  );

  ///确定按钮的内距
  EdgeInsets sureButtonPadding =  const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8);


  ///连续选中的圆角度数
  Radius successionRadius = const Radius.circular(24.0);

  ///日期点击时的背景效果
  BorderRadius dayClickBackRadius = const  BorderRadius.all(Radius.circular(32.0));


  static String dateFormat = "yyyy-MM-dd";
  static String dateFormat1 = "yyyy年MM月dd日";
  static String dateFormat2 = "yyyy/MM/dd";

  String? _currentDateFormat = dateFormat1;

  void setDateFormat(String format){
      _currentDateFormat = format;
  }

  int getDateFormat(){
    return dateFormat==_currentDateFormat?1:dateFormat1==_currentDateFormat?2:3;
  }


}