
import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/12/9
/// create_time: 15:21
/// describe: 日历样式的配置文件
///
class CalendarConfig{

  ///日历宽高
  double calendarWidth=400;
  double calendarHeight=800;

  ///日历的起 始时间
  DateTime? minimumDate;
  DateTime? maximumDate;

  ///当天日期下面的小圆点颜色
  Color currentDayDotColor = Colors.lightBlue.withAlpha(100);

  ///连续选中的连接颜色
  Color inRangeColor = Colors.redAccent.withAlpha(200);

  ///选择的起始时间背景色
  Color cycleBgColor = Colors.greenAccent.withAlpha(200);

  ///选择的起始时间背景的边框颜色
  Color cycleSlidColor = Colors.white;

  ///日历的浮层的背景色
  Color backgroundColor = Colors.transparent;

  ///日历的背景色
  Color calendarBgColor = Colors.white;

  ///背景阴影
  Color boxShadowColor = Colors.grey.withOpacity(0.2);

  ///背景阴影偏移
  Offset boxShadowOffset = const Offset(4, 4);

  ///高斯模糊度数
  double blurRadius = 8.0;

  ///日历内边距
  EdgeInsets calendarPadding = const EdgeInsets.all(24.0);

  ///背景圆角
  Radius bgRadius = const Radius.circular(24.0);


  ///顶部开始时间文字样式
  Widget startText = Text('开始时间', textAlign: TextAlign.left, style: TextStyle(
        fontWeight: FontWeight.w100,
        fontSize: 16,
        color:
        Colors.lightBlue.withOpacity(0.8)),
  );

  ///顶部结束时间文字样式
  Widget endText = Text('结束时间', textAlign: TextAlign.left, style: TextStyle(
        fontWeight: FontWeight.w100,
        fontSize: 16,
        color:
        Colors.lightBlue.withOpacity(0.8)),
  );



  ///顶部选中日期后显示的样式
  TextStyle checkedStartTimeStyle =  const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  TextStyle checkedEndTimeStyle =  const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );


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
        color: Colors.grey.withOpacity(0.6),
        blurRadius: 8,
        offset: const Offset(4, 4),
      ),
    ],
  );

  ///确定按钮的内距
  EdgeInsets sureButtonPadding =  const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8);

}