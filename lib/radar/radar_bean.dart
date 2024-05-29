import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024/5/29
/// create_time: 14:45
/// describe: 五维图数据
///
class RadarBean {
  double score;
  String name;
  Color bgColor;
  TextStyle textStyle;

  RadarBean(this.score, this.name,
      {this.bgColor = Colors.white,
      this.textStyle = const TextStyle(color: Colors.black,
          fontSize: 12)});
}
