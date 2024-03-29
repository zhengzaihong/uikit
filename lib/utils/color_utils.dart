import 'package:flutter/material.dart';


///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2023/5/12
/// create_time: 9:35
/// describe: 颜色工具
///


///#FFE6E6E6(argb) 格式转 dart 颜色
Color parseColorStr(String? colorStr) {
  if (null == colorStr || colorStr.isEmpty) {
    return Colors.transparent;
  }
  return Color(int.parse(colorStr.replaceFirst('#', ''), radix: 16));
}

///Colors.red/0xFFF44336 转 #FFF44336
String colorToStr(Color color) {
  String hexString = '#${color.value.toRadixString(16).substring(2)}'; // 转换为 16 进制字符串
  return hexString;
}