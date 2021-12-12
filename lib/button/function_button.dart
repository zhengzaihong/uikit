import 'package:flutter/material.dart';
import 'package:uikit/res/color_res.dart';

import 'function_container.dart';


///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/5/22
/// create_time: 17:11
/// describe: 封装一个功能按钮组件 背景切换 功能组件 顶层需要FunctionContainer包装
///
///
class FunctionButton extends StatefulWidget {
  final TextStyle checkedTextStyle;
  final TextStyle unCheckTextStyle;
  final BoxDecoration checkedBoxDecoration;
  final BoxDecoration unCheckedBoxDecoration;
  final int index;
  final String title;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry margin;

  const FunctionButton(
    this.title,
    this.index, {
    this.checkedTextStyle =
        const TextStyle(color: ColorRes.color_ff4ecdf5, fontSize: 20),
    this.unCheckTextStyle =
        const TextStyle(color: ColorRes.black, fontSize: 20),
    this.checkedBoxDecoration = const BoxDecoration(
        color: ColorRes.color_ff4ecdf5,
        borderRadius: BorderRadius.all(Radius.circular(10))),
    this.unCheckedBoxDecoration = const BoxDecoration(
        color:  ColorRes.color_fff1f2f6,
        borderRadius: BorderRadius.all(Radius.circular(10))),
    this.width = 20,
    this.height = 20,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.alignment = Alignment.center,
    Key? key,
  }) : super(key: key);

  @override
  _FunctionButtonState createState() => _FunctionButtonState();
}

class _FunctionButtonState extends State<FunctionButton> {
  @override
  Widget build(BuildContext context) {
    final containerManger = FunctionContainer.of(context);
    final checkeds = containerManger?.defaultCheckeds;
    final allow = containerManger?.allowMultipleChoice;
    final check = containerManger?.defaultCheck;

    Decoration decoration;
    TextStyle style;

    if (allow!) {
      if (checkeds!.contains(widget.index)) {
        decoration = widget.checkedBoxDecoration;
        style = widget.checkedTextStyle;
      } else {
        decoration = widget.unCheckedBoxDecoration;
        style = widget.unCheckTextStyle;
      }
    } else {
      if (check == widget.index) {
        decoration = widget.checkedBoxDecoration;
        style = widget.checkedTextStyle;
      } else {
        decoration = widget.unCheckedBoxDecoration;
        style = widget.unCheckTextStyle;
      }
    }
    return InkWell(
        highlightColor: Colors.transparent,
       hoverColor: Colors.transparent,
        onTap: () {
          containerManger?.mangerState?.updateChange(widget.index);
        },
        child: Container(
            padding: widget.padding,
            margin: widget.margin,
            alignment: widget.alignment,
            width: widget.width,
            height: widget.height,
            decoration: decoration,
            child: Text(widget.title, style: style)));
  }
}
