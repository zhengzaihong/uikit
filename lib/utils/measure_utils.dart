
import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/uikitlib.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/11/3
/// create_time: 16:45
/// describe: 测量相关工具
///
class MeasureUtils{

  MeasureUtils._();

  static Size measureTextSize(String text, TextStyle style,
      {int maxLines = 2^31, double maxWidth = double.infinity}) {
    if (StringUtils.isEmpty(text)) {
      return Size.zero;
    }
    final TextPainter textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(text: text, style: style), maxLines: maxLines)
      ..layout(maxWidth: maxWidth);
    return textPainter.size;
  }

}