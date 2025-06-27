
import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2023/2/1
/// create_time: 16:05
/// describe: 简化边框样式
///
class OutlineInputTextBorder extends OutlineInputBorder{

  final double childGapPadding;
  final BorderRadius childBorderRadius;

  const OutlineInputTextBorder({
    BorderSide borderSide = const BorderSide(),
    this.childBorderRadius = const BorderRadius.all(Radius.circular(4.0)),
    this.childGapPadding = 4.0,
  }):super(borderSide: borderSide,borderRadius: childBorderRadius,gapPadding: childGapPadding);

  @override
  OutlineInputBorder copyWith({
    BorderSide? borderSide,
    BorderRadius? borderRadius,
    double? gapPadding,
    Color? borderColor,
    double? borderWidth,
  }) {
    return super.copyWith(borderSide: borderSide??BorderSide(
        color: borderColor??Colors.transparent,
        width: borderWidth??1.0
    ), borderRadius: borderRadius, gapPadding: gapPadding);
  }
}